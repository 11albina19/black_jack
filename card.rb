# frozen_string_literal: true

class Card

  attr_accessor :suit, :rank, :points #масть, достоинство, очки

  def initialize(suit, rank, points)
    #!Переделывать ли на перечисление, если все равно будет создаваться программно?
    @suit   = suit
    @rank   = rank
    @points = points
  end
end
