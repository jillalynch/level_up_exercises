require 'rspec'
require_relative "../../lib/bomb"

describe 'bomb' do
  let(:bomb) { Bomb.new }

  describe "#initialize" do
    it "starts disarmed" do
      expect(bomb.state).to eql(:disarmed)
    end
  end

  describe "#enter_code" do
    let(:activation_code) { "1234" }
    let(:deactivation_code) { "0000" }

    context "When bomb is inactive," do
      it "arms when the activation code is entered" do
        bomb.enter_code(activation_code)
        expect(bomb.state).to eq(:armed)
      end
    end
    context "When bomb is active," do
      let(:active_bomb) do
        bomb = Bomb.new
        bomb.enter_code(activation_code)
        bomb
      end
      it "is an active bomb" do
        expect(active_bomb.state).to eq(:armed)
      end
      it "disarms when the deactivation code is entered" do
        active_bomb.enter_code(deactivation_code)
        expect(active_bomb.state).to eq(:disarmed)
      end
      it "detonates after 3 failed disarmaments" do
        3.times { active_bomb.enter_code("3333") }
        expect(active_bomb.state).to eq(:detonated)
      end
    end
  end


end
