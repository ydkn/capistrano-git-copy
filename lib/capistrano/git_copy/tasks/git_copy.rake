git_copy_plugin = self

namespace :git_copy do
  desc 'Check that the repository is reachable'
  task :check do
    run_locally do
      git_copy_plugin.check
    end
  end

  desc 'Clone the repo to the cache'
  task :clone do
    run_locally do
      if git_copy_plugin.test
        info t(:mirror_exists, at: git_copy_plugin.repo_cache_path)
      else
        git_copy_plugin.clone
      end
    end
  end

  desc 'Update the repo mirror to reflect the origin state'
  task update: :'git_copy:clone' do
    run_locally do
      within git_copy_plugin.repo_cache_path do
        git_copy_plugin.update
      end
    end
  end

  desc 'Copy repo to releases'
  task create_release: :'git_copy:update' do
    run_locally do
      within git_copy_plugin.repo_cache_path do
        git_copy_plugin.prepare_release
      end
    end

    on release_roles :all do
      git_copy_plugin.release
    end
  end

  desc 'Determine the revision that will be deployed'
  task set_current_revision: :'git_copy:update' do
    run_locally do
      within git_copy_plugin.repo_cache_path do
        set :current_revision, git_copy_plugin.fetch_revision
      end
    end
  end

  desc 'Clean repo cache'
  task :cleanup do
    run_locally do
      git_copy_plugin.cleanup
    end
  end
end
