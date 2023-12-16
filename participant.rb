# frozen_string_literal: true

class Participant

  attr_accessor :bank, :cards
  attr_reader :deck

  def initialize(deck)
    @cards = []
    @bank  = 100
    @deck  = deck
  end

  def points

  end

  def deal
    card = deck.take_card
    cards << card
  end

  def record_cards

  end

end
