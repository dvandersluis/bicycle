module Bicycle
  class Hand
    include Enumerable
    extend Forwardable

    def_delegator :@cards, :each
    def_delegator :@cards, :empty?

    attr_reader :cards

    def initialize
      @cards = []
    end

    def add(*new_cards)
      cards.concat(new_cards.flatten.reject(&:!))
    end
  end
end
