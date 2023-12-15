# frozen_string_literal: true

class Deck

  def initialize()
    regenerate_cards
  end

  def take_card
    regenerate_cards if cards.empty?
    cards.random_pop
  end

  private
  attr_reader :cards

  def regenerate_cards
    c1 = Card.new('Черви', 'Десятка', 10)
    cards << c1

    c2 = Card.new('Черви', 'Дама', 10)
    cards << c2

    c3 = Card.new('Пики', 'Тройка', 3)
    cards << c3
  end
  def random_pop
    card = cards.sample
  end

  def delete

  end

end
