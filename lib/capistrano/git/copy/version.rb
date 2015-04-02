require 'capistrano/scm'

# Capistrano
module Capistrano
  # Git
  class Git < Capistrano::SCM
    # Copy
    module Copy
      # gem version
      VERSION = '0.7.0'
    end
  end
end
