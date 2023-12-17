# frozen_string_literal: true

class Player

  attr_accessor :name

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
