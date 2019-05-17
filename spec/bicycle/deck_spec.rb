require 'spec_helper'

RSpec.describe Bicycle::Deck do
  subject { described_class.new }

  describe '#build_card' do
    subject { described_class.empty }

    it 'adds a card with a numeric rank' do
      card = subject.build_card(2, :spades)
      expect(card.value).to eq(2)
    end

    it 'adds a card with a string rank' do
      card = subject.build_card('J', :spades)
      expect(card.value).to eq(11)
    end

    it 'adds a card with a symbol rank' do
      card = subject.build_card(:A, :spades)
      expect(card.value).to eq(14)
    end

    it 'raises an error when given an invalid rank' do
      expect { subject.build_card(17, :hearts) }.to raise_error Bicycle::InvalidCardError, '17 is not a valid rank'
    end

    it 'raises an error when given an invalid symbol rank' do
      expect { subject.build_card(:F, :hearts) }.to raise_error Bicycle::InvalidCardError, 'F is not a valid rank'
    end

    it 'raises an error when given an invalid suit' do
      expect { subject.build_card(2, :bears) }.to raise_error Bicycle::InvalidCardError, 'bears is not a valid suit'
    end
  end

  describe '#load' do
    subject { described_class.empty }

    it 'adds all cards to the deck' do
      subject.load
      expect(subject.count).to eq(52)
    end

    it 'does not load cards multiple times' do
      subject.load
      subject.load
      expect(subject.count).to eq(52)
    end
  end

  describe '#shuffle' do
    it 'reorders the cards' do
      expect { subject.shuffle }.to change { subject.cards }
    end
  end

  describe '#take' do
    it 'returns a card off the top of the deck' do
      top_card = subject.first
      expect(subject.take).to eq(top_card)
      expect(subject.count).to eq(51)
    end

    it 'returns multiple cards off the top of the deck' do
      top_cards = subject.first(5)
      expect(subject.take(5)).to eq(top_cards)
      expect(subject.count).to eq(47)
    end

    it "returns false if the deck doesn't have enough cards" do
      deck = described_class.empty
      deck.build_card(:K, :spades)
      expect(deck.take(2)).to eq(false)
    end
  end

  describe '#add' do
    let(:card1) { double('Card') }
    let(:card2) { double('Card') }

    subject { described_class.empty }

    it 'adds a card to the deck' do
      expect { subject.add(card1) }.to change { subject.count }.from(0).to(1)
    end

    it 'adds multiple cards to the deck' do
      expect { subject.add(card1, card2) }.to change { subject.count }.from(0).to(2)
    end

    it 'adds multiple cards to the deck by array' do
      expect { subject.add([card1, card2]) }.to change { subject.count }.from(0).to(2)
    end
  end

  describe '#deal' do
    it 'returns hands of cards' do
      hands = subject.deal(3, 5)
      expect(hands.count).to eq(3)
      expect(hands.map(&:count)).to all(eq(5))
    end

    context 'when there are too few cards' do
      subject { described_class.empty }

      let(:queen) { subject.build_card(:Q, :spades) }
      let(:king) { subject.build_card(:K, :spades) }
      let(:ace) { subject.build_card(:A, :spades) }

      it 'deals what cards there are' do
        subject.add(queen, king, ace)
        hands = subject.deal(2, 4)
        expect(hands[0]).to contain_exactly(queen, ace)
        expect(hands[1]).to contain_exactly(king)
      end

      it 'deals empty hands if necessary' do
        subject.add(queen, king, ace)
        hands = subject.deal(7, 4)
        expect(hands[3..-1]).to all(be_empty)
      end
    end
  end
end
