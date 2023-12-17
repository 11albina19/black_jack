# frozen_string_literal: true

class Deck

  def initialize
    @cards = []
    regenerate_cards
  end

  def take_card
    regenerate_cards if cards.empty?
    random_pop
  end

  def test
    puts cards
    #1. тут сделать, чтобы было видно весь массив
    #3. проверить и удалить этот метод
  end

  private

  attr_reader :cards

  def regenerate_cards

    ranks = (2..10).to_a + %w(В Д К Т)
    suits = %w(♠ ♥ ♦ ♣)
    point = 1
    ranks.each do |rank|
      suits.each do |suit|
        card = Card.new(rank, suit, point)
        #2. тут сделать, чтобы очки присваивались нормально
        puts "#{card.to_s} #{rank.to_s}  #{suit.to_s}  #{point.to_s}" #4. эту строчку тоже удалить
        cards << card
      end
    end
    puts "Колода готова к игре"
  end

  def random_pop
    card = cards.sample
    cards.delete(card)
  end
end
