require "paper_trail/sinatra/version"

require "active_support/core_ext/object" # provides the `try` method

module PaperTrail
  # Extensions to `Sinatra`.
  module Sinatra
    # Register this module inside your Sinatra application to gain access to
    # controller-level methods used by PaperTrail.
    def self.registered(app)
      app.use RequestStore::Middleware
      app.helpers self
      app.before {
        set_paper_trail_whodunnit
        set_paper_trail_request_info
        set_paper_trail_enabled_for_request
      }
    end

    protected

    # Returns the user who is responsible for any changes that occur.
    # By default this calls `current_user` and returns the result.
    #
    # Override this method in your controller to call a different
    # method, e.g. `current_person`, or anything you like.
    def user_for_paper_trail
      return unless defined?(current_user)
      ActiveSupport::VERSION::MAJOR >= 4 ? current_user.try!(:id) : current_user.try(:id)
    rescue NoMethodError
      current_user
    end

    # Returns any information about the controller or request that you
    # want PaperTrail to store alongside any changes that occur.  By
    # default this returns an empty hash.
    #
    # Override this method in your controller to return a hash of any
    # information you need.  The hash's keys must correspond to columns
    # in your `versions` table, so don't forget to add any new columns
    # you need.
    #
    # For example:
    #
    #     {:ip => request.remote_ip, :user_agent => request.user_agent}
    #
    # The columns `ip` and `user_agent` must exist in your `versions` # table.
    #
    # Use the `:meta` option to
    # `PaperTrail::Model::ClassMethods.has_paper_trail` to store any extra
    # model-level data you need.
    def info_for_paper_trail
      {}
    end

    # Returns `true` (default) or `false` depending on whether PaperTrail
    # should be active for the current request.
    #
    # Override this method in your controller to specify when PaperTrail
    # should be off.
    def paper_trail_enabled_for_request
      ::PaperTrail.enabled?
    end

    private

    # Tells PaperTrail who is responsible for any changes that occur.
    def set_paper_trail_whodunnit
      return unless ::PaperTrail.enabled?
      if ::Gem::Version.new(::PaperTrail::VERSION) >= ::Gem::Version.new('9')
        ::PaperTrail.request.whodunnit = user_for_paper_trail
      else
        ::PaperTrail.whodunnit = user_for_paper_trail
      end
    end

    # Tells PaperTrail any information from the controller you want to store
    # alongside any changes that occur.
    def set_paper_trail_request_info
      return unless ::PaperTrail.enabled?
      if ::Gem::Version.new(::PaperTrail::VERSION) >= ::Gem::Version.new('9')
        ::PaperTrail.request.controller_info = info_for_paper_trail
      else
        ::PaperTrail.controller_info = info_for_paper_trail
      end
    end

    # Tells PaperTrail whether versions should be saved in the current
    # request.
    def set_paper_trail_enabled_for_request
      return unless ::PaperTrail.enabled?
      if ::Gem::Version.new(::PaperTrail::VERSION) >= ::Gem::Version.new('9')
        ::PaperTrail.request.enabled = paper_trail_enabled_for_request
      else
        ::PaperTrail.enabled_for_controller = paper_trail_enabled_for_request
      end
    end
  end
end

if defined?(::Sinatra)
  ::Sinatra.register(::PaperTrail::Sinatra)
end
