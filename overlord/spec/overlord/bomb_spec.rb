require 'rspec'
require_relative "../../lib/bomb"

describe 'bomb' do
  let(:bomb) { Bomb.new }

  describe "#initialize" do
    it "starts disarmed" do
      expect(bomb.state).to eql(:disarmed)
    end
  end

  describe "#default_activation_code" do
    it "is 1234" do
      expect(bomb.default_activation_code).to eql("1234")
    end
  end

  describe "#default_deactivation_code" do
    it "is 0000" do
      expect(bomb.default_deactivation_code).to eql("0000")
    end
  end

  describe "#enter_code" do
    context "When bomb is inactive," do
      it "arms when the activation code is entered" do
        bomb.enter_code(bomb.default_activation_code)
        expect(bomb.state).to eq(:armed)
      end
    end

    context "When bomb is active," do
      let(:active_bomb) do
        bomb2 = Bomb.new
        bomb2.enter_code("0000")
      end
      it "disarms when the deactivation code is entered" do
        require 'pry'; binding.pry
        active_bomb.enter_code("0000")
        expect(active_bomb.state).to eq(:disarmed)
      end
      # it "detonates after 3 failed disarmaments" do
      #   2.times { active_bomb.enter_code("3333") }
      #
      #   active_bomb.enter_code("3333")
      #   expect(active_bomb.state).to eq(:detonated)
      # end
    end
  end

  describe "#arm" do
    it "is armed" do
      bomb.arm
      expect(bomb).to be_armed
    end
  end

  describe "#disarm" do
    it "is disarmed" do
      bomb.disarm
      expect(bomb).to be_disarmed
    end
  end

  describe "#detonate" do
    it "is detonated" do
      bomb.detonate
      expect(bomb).to be_detonated
    end
  end

  describe "#attempt_deactivation" do
    it "records failed attempt to deactivate" do
      bomb.attempt_deactivation
      expect { bomb.attempt_deactivation }.to change { bomb.count }.by(1)
    end
  end

  describe "#action" do
    it "deactivates when code is 2222" do
      expect(bomb)
    end
  end

  it "deactivates when code is 1111" do
    # pending
  end

  describe "#valid_code?" do
    context "when code is valid" do
      # pending
    end
    context "when code is invalid" do
      # pending
    end
  end
end