require "spec_helper"

# Register our sinatra application
module Sinatra
  class Application
    configs = YAML.load_file(File.expand_path("database.yml", __dir__))
    ActiveRecord::Base.configurations = configs
    ActiveRecord::Base.establish_connection(:test)

    get "/test" do
      Widget.create!(name: "bar")
      "Hai"
    end

    def current_user
      @current_user ||= OpenStruct.new(id: "raboof")
    end

    def info_for_paper_trail
      { ip: request.ip, user_agent: request.user_agent }
    end
  end
end

RSpec.describe "classic sinatra application" do
  include Rack::Test::Methods

  def app
    ::Sinatra::Application
  end

  context "`PaperTrail::Sinatra` in a `Sinatra::Application` application" do
    it "sets the `user_for_paper_trail` from the `current_user` method, also sets `info_for_paper_trail`" do
      env "HTTP_USER_AGENT", "chrome"
      env "HTTP_X_FORWARDED_FOR", "8.8.8.8"
      get "/test"
      expect(last_response.body).to eq("Hai")
      widget = Widget.last
      expect(widget).to_not be_nil
      expect(widget.name).to eq("bar")
      expect(widget.versions.size).to eq(1)
      expect(widget.versions.first.whodunnit).to eq("raboof")
      expect(widget.versions.first.ip).to eq("8.8.8.8")
      expect(widget.versions.first.user_agent).to eq("chrome")
    end
  end
end
