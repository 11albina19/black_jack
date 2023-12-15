# frozen_string_literal: true

class Deck

  def initialize()
    @cards = []
    regenerate_cards
  end

  def take_card
    regenerate_cards if cards.empty?
    random_pop
  end

  def test
    puts cards
  end

  private

  attr_reader :cards

  def regenerate_cards

    ranks = (2..10).to_a + %w(В Д К Т)
    suits = %w(♠ ♥ ♦ ♣)

    ranks.each do |rank|
      suits.each do |suit|
        card = Card.new(rank, suit, 1)
        puts card.to_s + " " + rank.to_s + " " + suit.to_s
        cards << card
      end
    end

    #c1 = Card.new('Черви', 'Десятка', 10)
    #cards << c1

    #c2 = Card.new('Черви', 'Дама', 10)
    #cards << c2

    #c3 = Card.new('Пики', 'Тройка', 3)
    #cards << c3
  end

  def random_pop
    card = cards.sample
    cards.delete(card)
  end
end
