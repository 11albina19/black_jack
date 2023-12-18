# frozen_string_literal: true
require_relative 'participant'

class Player < Participant

  attr_accessor :name

  def initialize(name, deck)
    @name = name
    super(deck)
  end

  def make_move
    if cards.size <= 2
      card = deal
      puts "Получена карта #{card.suit}  #{card.rank}, приносит очков: #{card.points} "
      true
    else
      false
    end
  end
end
