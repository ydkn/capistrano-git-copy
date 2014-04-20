# Capistrano::GIT::Copy

Creates a tar archive from the locale git repository and uploads it to the remote server.

## Setup

Add the library to your `Gemfile`:

```ruby
group :development do
  gem 'capistrano-git-copy', require: false
end
```

And load it in your `Capfile`:

```ruby
require 'capistrano/git/copy'
```

Now use `git_copy` as your SCM type in your `config/deploy.rb`:

    set :scm, :git_copy

## Configuration

You can modify any of the following Capistrano variables in your deploy.rb config.

- `git_archive_all_bin`     - Set git-archive-all command. Defaults to git-archive-all found in $PATH or to included version.
- `git_copy_tmp_path`       - Temp path used to clone the repository and create archive.

## Notes

* Uses [git-archive-all](https://github.com/Kentzo/git-archive-all) for bundling repositories.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
