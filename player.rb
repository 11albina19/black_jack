# frozen_string_literal: true

class Player

  attr_accessor :name

  def make_move
    #deal unless cards.size > 2
    cards.size <= 2 ? (deal; true) : false
  end
end
