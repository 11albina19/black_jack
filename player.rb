# frozen_string_literal: true

class Player < Participant

  attr_accessor :name

  def initialize(name, deck)
    @name = name
    super(deck)
  end

  def make_move
    if cards.size <= 2
      card = deal
      puts "Получена карта #{card}"
      true
    else
      false
    end
  end
end
