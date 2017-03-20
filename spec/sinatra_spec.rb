require "spec_helper"

# Register our sinatra application
module Sinatra
  class Application
    configs = YAML.load_file(File.expand_path("database.yml", __dir__))
    ActiveRecord::Base.configurations = configs
    ActiveRecord::Base.establish_connection(:test)

    # We shouldn't actually need this line if I'm not mistaken but the tests
    # seem to fail without it ATM
    register PaperTrail::Sinatra

    get "/test" do
      Widget.create!(name: "bar")
      "Hai"
    end

    def current_user
      @current_user ||= OpenStruct.new(id: "raboof")
    end
  end
end

RSpec.describe "classic sinatra application" do
  include Rack::Test::Methods

  def app
    ::Sinatra::Application
  end

  context "`PaperTrail::Sinatra` in a `Sinatra::Application` application" do
    it "sets the `user_for_paper_trail` from the `current_user` method" do
      get "/test"
      expect(last_response.body).to eq("Hai")
      widget = Widget.last
      expect(widget).to_not be_nil
      expect(widget.name).to eq("bar")
      expect(widget.versions.size).to eq(1)
      expect(widget.versions.first.whodunnit).to eq("raboof")
    end
  end
end
