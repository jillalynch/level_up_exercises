require 'rspec'
require_relative '../../lib/overlord'

describe 'overlord' do
  let(:overlord) { Overlord.new }

  describe "#valid_code?" do
    let(:valid_code) { "0010" }
    let(:invalid_code) { "12434" }
    let(:invalid_code_alpha) { "FADS" }

    it "is a valid code" do
      expect(overlord.valid_code?(valid_code)).to be true
    end
    it "is an invalid code" do
      expect(overlord.valid_code?(invalid_code)).to be false
      expect(overlord.valid_code?(invalid_code_alpha)).to be false
    end
  end
end
