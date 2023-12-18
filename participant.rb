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
    number = 0
    aces = 0
    summ = 0
    cards.each do |card|
      if card.rank == 'Т'
        aces += 1
        number += 1
      else
        number += card.points
      end
    end
    if aces > 0
      aces.times do
        break if number >= 21
        summ = number
        number += 10
        if number > 21
          summ, number = number, summ # если превышение, берем вариант до
        end
      end
    end
    number
  end

  def deal
    card = deck.take_card
    cards << card
    card
  end

  def show_cards
    cards.each do |card|
      puts "Карта #{card.suit.to_s} #{card.rank.to_s}"
    end
  end
end
