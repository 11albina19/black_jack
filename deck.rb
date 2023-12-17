# frozen_string_literal: true

class Deck

  MATCHING = {
    '2': 2, '3': 3, '4': 4, '5': 5,
    '6': 6, '7': 7, '8': 8, '9': 9, '10': 10,
    'В': 10, 'Д': 10, 'К': 10, 'Т': [1, 11]
  }.freeze

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
    # 1. тут сделать, чтобы было видно весь массив
    # 3. проверить и удалить этот метод
  end

  private

  attr_reader :cards

  def regenerate_cards
    ranks = (2..10).to_a + %w(В Д К Т)
    suits = %w(♠ ♥ ♦ ♣)
    ranks.each do |rank|
      suits.each do |suit|
        point = MATCHING[rank.to_s.to_sym]
        puts point.to_s
        card = Card.new(rank, suit, point)
        puts "#{card.to_s} #{rank.to_s}  #{suit.to_s} #{point.to_s}" # 4. эту строчку тоже удалить
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
