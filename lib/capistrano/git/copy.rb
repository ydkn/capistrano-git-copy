module Capistrano
  module Git
    module Copy
      def self.root_path
        File.expand_path('../../../..', __FILE__)
      end
    end
  end
end

require 'capistrano/git/copy/version'
require 'capistrano/git/copy/deploy'
