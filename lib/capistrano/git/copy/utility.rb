require 'tmpdir'
require 'digest/md5'

module Capistrano
  module Git
    module Copy
      # Utility stuff to avoid cluttering of deploy.cap
      class Utility
        def initialize(context)
          @context = context
        end

        # Check if repo cache exists
        #
        # @return [Boolean] indicates if repo cache exists
        def test
          test! " [ -d #{repo_path} ] "
        end

        # Check if repo is accessible
        #
        # @return void
        def check
          git :'ls-remote --heads', repo_url
        end

        # Clone repo to cache
        #
        # @return void
        def clone
          execute :mkdir, '-p', tmp_path

          git :clone, fetch(:repo_url), repo_path
        end

        # Update repo and submodules to branch
        #
        # @return void
        def update
          branch = fetch(:branch, 'master')

          git :remote, :update
          git :reset, '--hard', branch
          git :reset, '--hard', "origin/#{branch}"

          # submodules
          git :submodule, :init
          git :submodule, :update
          git :submodule, :foreach, '--recursive', :git, :submodule, :update, '--init'

          # cleanup
          git :clean, '-d', '-f'
          git :submodule, :foreach, '--recursive', :git, :clean, '-d', '-f'
        end

        # Create tar archive
        #
        # @return void
        def prepare_release
          execute git_archive_all_bin, "--prefix=''", archive_path
        end

        # Upload and extract release
        #
        # @return void
        def release
          remote_archive_path = File.join(fetch(:deploy_to), File.basename(archive_path))

          upload! archive_path, remote_archive_path

          execute :mkdir, '-p', release_path
          execute :tar, '-f', remote_archive_path, '-x', '-C', release_path
          execute :rm, '-f', remote_archive_path
        end

        # Set deployed revision
        #
        # @return void
        def fetch_revision
          git 'rev-list', '--max-count=1', '--abbrev-commit', fetch(:branch)
        end

        # Cleanup repo cache
        #
        # @return void
        def cleanup
          execute :rm, '-rf', tmp_path

          info 'Local repo cache was removed'
        end

        # Temporary path for all git-copy operations
        #
        # @return [String]
        def tmp_path
          @_tmp_path ||= File.join(Dir.tmpdir, deploy_id)
        end

        # Path to repo cache
        #
        # @return [String]
        def repo_path
          @_repo_path ||= File.join(tmp_path, 'repo')
        end

        # Path to archive
        #
        # @return [String]
        def archive_path
          @_archive_path ||= File.join(tmp_path, 'archive.tar.gz')
        end

        private

        def fetch(*args)
          @context.fetch(*args)
        end

        def test!(*args)
          @context.test(*args)
        end

        def execute(*args)
          @context.execute(*args)
        end

        def upload!(*args)
          @context.upload!(*args)
        end

        def info(*args)
          @context.info(*args)
        end

        def git(*args)
          args.unshift(:git)
          execute(*args)
        end

        def git_archive_all_bin
          File.expand_path('../../../../../vendor/git-archive-all/git-archive-all', __FILE__)
        end

        def deploy_id
          [
            fetch(:application),
            fetch(:stage),
            Digest::MD5.hexdigest(fetch(:repo_url))[0..7]
          ].compact.join('_')
        end
      end
    end
  end
end
