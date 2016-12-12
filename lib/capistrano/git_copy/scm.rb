require 'capistrano/scm/plugin'

module Capistrano
  module GitCopy
    # SCM plugin for capistrano
    # uses a local clone and uploads a tar archive to the server
    class SCM < ::Capistrano::SCM::Plugin
      # set default values
      def set_defaults
        set_if_empty :with_submodules, true
        set_if_empty :git_excludes,    []
        set_if_empty :repo_tree,       false
      end

      # define plugin tasks
      def define_tasks
        eval_rakefile File.expand_path('../tasks/git_copy.rake', __FILE__)
      end

      # register capistrano hooks
      def register_hooks
        after  'deploy:new_release_path',     'git_copy:create_release'
        before 'deploy:check',                'git_copy:check'
        before 'deploy:set_current_revision', 'git_copy:set_current_revision'
      end

      # Check if repository is accessible
      #
      # @return void
      def check
        git(:'ls-remote --heads', repo_url)
      end

      # Check if repository cache exists and is valid
      #
      # @return [Boolean] indicates if repo cache exists
      def test
        if backend.test("[ -d #{repo_cache_path} ]")
          backend.within(repo_cache_path) do
            if backend.test(:git, :status, '>/dev/null 2>/dev/null')
              true
            else
              backend.execute(:rm, '-rf', repo_cache_path)

              false
            end
          end
        else
          false
        end
      end

      # Clone repo to cache
      #
      # @return void
      def clone
        backend.execute(:mkdir, '-p', tmp_path)

        git(:clone, fetch(:repo_url), repo_cache_path)
      end

      # Update repo and submodules to branch
      #
      # @return void
      def update
        git(:remote, :update)
        git(:reset, '--hard', commit_hash)

        # submodules
        if fetch(:with_submodules)
          git(:submodule, :init)
          git(:submodule, :update)
          git(:submodule, :foreach, '--recursive', :git, :submodule, :update, '--init')
        end

        # cleanup
        git(:clean, '-d', '-f')

        if fetch(:with_submodules)
          git(:submodule, :foreach, '--recursive', :git, :clean, '-d', '-f')
        end
      end

      # Create tar archive
      #
      # @return void
      def prepare_release
        target = fetch(:repo_tree) ? "HEAD:#{fetch(:repo_tree)}" : 'HEAD'

        if fetch(:with_submodules)
          backend.execute(git_archive_all_bin, "--prefix=''", archive_path)
        else
          git(:archive, '--format=tar', target, '|', 'gzip', "> #{archive_path}")
        end

        exclude_files_from_archive if fetch(:git_excludes, []).count > 0
      end

      # Upload and extract release
      #
      # @return void
      def release
        backend.execute :mkdir, '-p', release_path

        remote_archive_path = File.join(fetch(:deploy_to), File.basename(archive_path))

        backend.upload!(archive_path, remote_archive_path)

        backend.execute(:mkdir, '-p', release_path)
        backend.execute(:tar, '-f', remote_archive_path, '-x', '-C', release_path)
        backend.execute(:rm, '-f', remote_archive_path)
      end

      # Set deployed revision
      #
      # @return void
      def fetch_revision
        backend.capture(:git, 'rev-list', '--max-count=1', '--abbrev-commit', commit_hash).strip
      end

      # Cleanup repo cache
      #
      # @return void
      def cleanup
        backend.execute(:rm, '-rf', tmp_path)

        backend.info('Local repo cache was removed')
      end

      # Temporary path for all git-copy operations
      #
      # @return [String]
      def tmp_path
        @_tmp_path ||= File.join(Dir.tmpdir, deploy_id)
      end

      # Path to repository cache
      #
      # @return [String]
      def repo_cache_path
        @_repo_cache_path ||= File.join(tmp_path, 'repo')
      end

      # Path to archive
      #
      # @return [String]
      def archive_path
        @_archive_path ||= File.join(tmp_path, 'archive.tar.gz')
      end

      private

      def deploy_id
        [
          fetch(:application),
          fetch(:stage),
          Digest::MD5.hexdigest(fetch(:repo_url))[0..7],
          Digest::MD5.hexdigest(Dir.getwd)[0..7]
        ].compact.join('_').gsub(/[^\w]/, '')
      end

      def commit_hash
        return @_commit_hash if @_commit_hash

        branch = fetch(:branch, 'master').to_s.strip

        if backend.test(:git, 'rev-parse', "origin/#{branch}", '>/dev/null 2>/dev/null')
          @_commit_hash = backend.capture(:git, 'rev-parse', "origin/#{branch}").strip
        else
          @_commit_hash = backend.capture(:git, 'rev-parse', branch).strip
        end
      end

      def git_archive_all_bin
        File.expand_path('../../../../vendor/git-archive-all/git_archive_all.py', __FILE__)
      end

      def git(*args)
        backend.execute(:git, *args)
      end

      def exclude_files_from_archive
        archive_dir = File.join(tmp_path, 'archive')

        backend.execute :rm, '-rf', archive_dir
        backend.execute :mkdir, '-p', archive_dir
        backend.execute :tar, '-xzf', archive_path, '-C', archive_dir

        fetch(:git_excludes, []).each do |f|
          file_path = File.join(archive_dir, f.gsub(/\A\//, ''))

          unless File.exists?(file_path)
            backend.warn("#{f} does not exists!")

            next
          end

          FileUtils.rm_rf(file_path)
        end

        backend.execute :tar, '-czf', archive_path, '-C', archive_dir, '.'
      end
    end
  end
end
