# Capistrano::GIT::Copy

Creates a tar archive from the locale git repository and uploads it to the remote server.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano', '~> 3.0.0'
    gem 'capistrano-git-copy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-git-copy

## Usage

Require in `Capfile` to use the default task:

    require 'capistrano/git/copy'

Now use `git_copy` as your SCM type:

    set :scm, :git_copy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
