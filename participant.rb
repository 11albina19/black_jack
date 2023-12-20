# frozen_string_literal: true

class Participant

  attr_accessor :bank, :cards, :cards_test#удалить!!!!!
  attr_reader :deck

  def initialize(deck)
    @cards = []
    @cards_test = []#удалить!!!!!
    @bank = 100
    @deck = deck
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
    aces_count.times{ points -= 10 if points > 21 }
    points
  end

  def deal
    card = deck.take_card
    cards << card
    test_test_test#подставлены нужные данные
    card
  end

  def test_test_test
    c1 = Card.new('♥', '4', 4)
    cards_test << c1

    c2 = Card.new('♥', '7', 7)
    cards_test << c2

    c3 = Card.new('♥', 'Т', 11)
    cards_test << c3

    cards.clear
    cards.concat(cards_test)
  end

  def show_cards
    cards.each do |card|
      puts "Карта #{card.suit.to_s} #{card.rank.to_s}"
    end
  end
end
