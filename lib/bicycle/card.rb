module Bicycle
  class Card
    include Comparable

    EMOJI = { diamonds: '♦️', clubs: '♣️', hearts: '♥️', spades: '♠️' }.freeze

    attr_reader :rank, :suit, :value

    def initialize(rank, suit, value)
      @rank = rank.respond_to?(:to_sym) ? rank.to_sym : rank
      @suit = suit
      @value = value
    end

    def to_s
      "#{rank} of #{suit}"
    end

    def <=>(other)
      value <=> other.value
    end

    def ===(other)
      value == other.value && suit == other.suit
    end

    def inspect
      "#<#{self.class.name}:#{format('0x00%x', (object_id << 1))} #{rank} of #{suit}>"
    end
  end
end
