module PaperTrail
  module Sinatra
    VERSION = "0.7.0"

    # Added in 0.5.0
    # @api public
    def self.gem_version
      ::Gem::Version.new(VERSION)
    end
  end
end
