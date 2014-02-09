# Capistrano
module Capistrano
  # GIT
  module Git
    # Copy
    module Copy
      # Quick-Access to this gems root directory
      #
      # @return [String] Root directory of this gem
      def self.root_path
        File.expand_path('../../../..', __FILE__)
      end
    end
  end
end

require 'capistrano/git/copy/version'
require 'capistrano/git/copy/deploy'
