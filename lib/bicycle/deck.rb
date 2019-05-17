require 'forwardable'

module Bicycle
  class Deck
    include Enumerable
    extend Forwardable

    RANKS = ((2..10).to_a + %i(J Q K A)).zip(2..14).to_h.freeze
    SUITS = %i(diamonds clubs hearts spades).freeze

    def_delegator :@cards, :each
    def_delegator :@cards, :empty?

    attr_reader :cards, :loaded
    alias_method :loaded?, :loaded

    def self.empty
      new(load: false)
    end

    def initialize(load: true)
      @cards = []
      self.load if load
    end

    def build_card(rank, suit)
      rank = rank.to_sym if rank.respond_to?(:to_sym)

      raise InvalidCardError, "#{rank} is not a valid rank" unless RANKS.include?(rank)
      raise InvalidCardError, "#{suit} is not a valid suit" unless SUITS.include?(suit)

      Card.new(rank, suit, RANKS[rank])
    end

    def load
      return self if loaded?

      add(SUITS.product(RANKS.keys).map do |suit, rank|
        build_card(rank, suit)
      end)

      @loaded = true
      self
    end

    def shuffle
      cards.shuffle!
      self
    end

    def take(num = 1)
      return false if num > count

      num == 1 ? cards.shift : cards.shift(num)
    end

    def add(*new_cards)
      cards.concat(new_cards.flatten)
    end

    def deal(hand_count, card_count)
      Array.new(hand_count) { Hand.new }.tap do |hands|
        card_count.times do
          hands.each { |h| h.add(take) }
        end
      end
    end
  end
end
