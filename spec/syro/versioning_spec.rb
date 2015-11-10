require 'spec_helper'

class TestDeck < Syro::Deck
  include Syro::Versioning

  def self.app
    Syro.new(self) {
      version(3) {
        get {
          res.write "Version 3"
        }
      }

      version(1) {
        get {
          res.write "Version 1"
        }
      }
    }
  end
end

describe Syro::Versioning do
  let(:app) { TestDeck.app }

  it "uses the Accept header for versioning" do
    header 'Accept', 'text/plain; version=1'
    expect(get('/').body).to eql("Version 1")

  end

  it "has a default version" do
    expect(get('/').body).to eql("Version 3")
  end

  it "fills versions gap with lower versions" do
    header 'Accept', 'text/plain; version=2'
    expect(get('/').body).to eql("Version 1")
  end

end
