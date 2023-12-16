# frozen_string_literal: true

class Participant

  attr_accessor :bank, :cards
  attr_reader :deck

  def initialize(deck)
    @cards = []
    @bank = 100
    @deck = deck
  end

  def points
    summ = 0
    cards.each do |card|
      summ += card.points
    end
    summ
  end

  def deal
    card = deck.take_card
    cards << card
    card
  end
end
