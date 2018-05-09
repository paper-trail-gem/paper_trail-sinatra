require "spec_helper"

module PaperTrail
  RSpec.describe Sinatra do
    describe '.gem_version' do
      it 'returns a ::Gem::Version' do
        expect(described_class.gem_version).to be_a(::Gem::Version)
      end
    end
  end
end
