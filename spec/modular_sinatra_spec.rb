require "spec_helper"

# Modular `Sinatra::Base` style
class BaseApp < Sinatra::Base
  configs = YAML.load_file(File.expand_path("database.yml", __dir__))
  ActiveRecord::Base.configurations = configs
  ActiveRecord::Base.establish_connection(:test)
  register PaperTrail::Sinatra

  get "/test" do
    Widget.create!(name: "foo")
    "Hello"
  end

  def current_user
    @current_user ||= OpenStruct.new(id: "foobar")
  end

  def info_for_paper_trail
    { ip: request.ip, user_agent: request.user_agent }
  end

  def paper_trail_enabled_for_request
    request.user_agent =~ /mozilla/
  end
end

RSpec.describe "modular-style sinatra application" do
  include Rack::Test::Methods

  def app
    @app ||= BaseApp
  end

  it "baseline" do
    widget = Widget.create.versions.first
    expect(widget.whodunnit).to be_nil
    expect(widget.ip).to be_nil
    expect(widget.user_agent).to be_nil
  end

  context "`PaperTrail::Sinatra` in a `Sinatra::Base` application" do
    it "sets the `user_for_paper_trail` from the `current_user` method, also sets `info_for_paper_trail` and `paper_trail_enabled_for_request`" do
      env "HTTP_USER_AGENT", "mozilla"
      get "/test"
      expect(last_response.body).to eq("Hello")
      widget = Widget.last
      expect(widget).to_not be_nil
      expect(widget.name).to eq("foo")
      expect(widget.versions.size).to eq(1)
      expect(widget.versions.first.whodunnit).to eq("foobar")
      expect(widget.versions.first.ip).to eq("127.0.0.1")
      expect(widget.versions.first.user_agent).to eq("mozilla")

      # change user agent
      env "HTTP_USER_AGENT", "edge"
      get "/test"
      expect(last_response.body).to eq("Hello")
      widget2 = Widget.last
      expect(widget2).to_not be_nil
      expect(widget2.name).to eq("foo")
      expect(widget2.versions.size).to eq(0)
    end
  end
end
