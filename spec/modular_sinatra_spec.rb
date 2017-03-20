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
end

RSpec.describe "modular-style sinatra application" do
  include Rack::Test::Methods

  def app
    @app ||= BaseApp
  end

  it "baseline" do
    expect(Widget.create.versions.first.whodunnit).to be_nil
  end

  context "`PaperTrail::Sinatra` in a `Sinatra::Base` application" do
    it "sets the `user_for_paper_trail` from the `current_user` method" do
      get "/test"
      expect(last_response.body).to eq("Hello")
      widget = Widget.last
      expect(widget).to_not be_nil
      expect(widget.name).to eq("foo")
      expect(widget.versions.size).to eq(1)
      expect(widget.versions.first.whodunnit).to eq("foobar")
    end
  end
end
