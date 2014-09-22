# Capistrano::GIT::Copy

Creates a tar archive locally from the git repository and uploads it to the remote server.

## Setup

Add the library to your `Gemfile`:

```ruby
group :development do
  gem 'capistrano-git-copy', require: false
end
```

And require it in your `Capfile`:

```ruby
require 'capistrano/git/copy'
```

Now use `git_copy` as your SCM type in your `config/deploy.rb`:

    set :scm, :git_copy

## Configuration

You can modify any of the following Capistrano variables in your `deploy.rb` config.

- `git_archive_all_bin`     - Set the path for the git-archive-all command. Defaults to git-archive-all found in $PATH or the included version as a fallback.
- `git_copy_tmp_path`       - Temporary path where the repository is cloned to and the archive is created.

## Notes

* Uses [git-archive-all](https://github.com/Kentzo/git-archive-all) for bundling repositories.

## Code status

* [![Gem Version](https://badge.fury.io/rb/capistrano-git-copy.png)](http://badge.fury.io/rb/capistrano-git-copy)
* [![Dependencies](https://gemnasium.com/ydkn/capistrano-git-copy.png?travis)](https://gemnasium.com/ydkn/capistrano-git-copy)
* [![PullReview stats](https://www.pullreview.com/github/ydkn/capistrano-git-copy/badges/master.svg?)](https://www.pullreview.com/github/ydkn/capistrano-git-copy/reviews/master)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
