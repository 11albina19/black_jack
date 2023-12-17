# frozen_string_literal: true

class Card

  attr_accessor :suit, :rank, :points

  def initialize(suit, rank, points)
    @suit   = suit
    @rank   = rank
    @points = points
  end
end
