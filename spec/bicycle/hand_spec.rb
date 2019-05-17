require 'spec_helper'

RSpec.describe Bicycle::Hand do
  subject { described_class.new }

  describe '#add' do
    let(:card1) { double('Card') }
    let(:card2) { double('Card') }

    subject { described_class.new }

    it 'adds a card to the deck' do
      expect { subject.add(card1) }.to change { subject.count }.from(0).to(1)
    end

    it 'adds multiple cards to the deck' do
      expect { subject.add(card1, card2) }.to change { subject.count }.from(0).to(2)
    end

    it 'adds multiple cards to the deck by array' do
      expect { subject.add([card1, card2]) }.to change { subject.count }.from(0).to(2)
    end

    it 'ignores nils' do
      expect { subject.add(nil) }.to_not change { subject.count }
    end
  end
end
