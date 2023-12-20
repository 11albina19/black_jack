# frozen_string_literal: true

class Participant

  attr_accessor :bank, :cards

  def initialize
    @cards = []
    @bank = 100
  end

  def aces_count
    count = 0
    cards.each do |card|
      count += 1 if card.rank == 'Т'
    end
    count
  end

  def points
    points = cards.sum(&:points)
    aces_count.times { points -= 10 if points > 21 }
    points
  end

  def write(card)
    cards << card
  end

  def show_cards
    cards.each do |card|
      puts "Карта #{card.suit.to_s} #{card.rank.to_s}"
    end
  end
end
