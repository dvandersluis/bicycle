require 'spec_helper'

RSpec.describe Bicycle::Card do
  let(:queen_of_hearts) { described_class.new(:Q, :hearts, 12) }
  let(:king_of_spades) { described_class.new(:K, :spades, 13) }
  let(:king_of_diamonds) { described_class.new(:K, :diamonds, 13) }

  describe '<=>' do
    it 'returns 0 if the cards have the same value' do
      expect(king_of_spades).to eq(king_of_diamonds)
    end

    it 'returns 1 if when the value is greater' do
      expect(king_of_spades).to be > queen_of_hearts
    end

    it 'returns -1 if the value is lesser' do
      expect(queen_of_hearts).to be < king_of_spades
    end
  end

  describe '#===' do
    it 'returns false if the cards have the same value but different suits' do
      expect(king_of_spades).to_not be === king_of_diamonds
    end

    it 'returns true if the cards have the same value and suit' do
      expect(king_of_spades).to be === described_class.new(:K, :spades, 13)
    end
  end
end
