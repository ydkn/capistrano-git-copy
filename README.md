[![Gem Version](https://img.shields.io/gem/v/capistrano-git-copy.svg)](https://rubygems.org/gems/capistrano-git-copy)
[![Dependencies](https://img.shields.io/gemnasium/ydkn/capistrano-git-copy.svg)](https://gemnasium.com/ydkn/capistrano-git-copy)
[![Code Climate](https://img.shields.io/codeclimate/github/ydkn/capistrano-git-copy.svg)](https://codeclimate.com/github/ydkn/capistrano-git-copy)

[![Join the chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ydkn/capistrano-git-copy)


# Capistrano::GitCopy

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

## Notes

* Uses [git-archive-all](https://github.com/Kentzo/git-archive-all) for bundling repositories.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
