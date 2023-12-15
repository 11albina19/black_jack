# frozen_string_literal: true

class Deck

  def initialize()

  end

  def take_card
    regenerate_cards if cards.empty?
    cards.random_pop
  end
  
  private
  attr_reader :cards

  def regenerate_cards

  end
  def random_pop

  end

  def delete

  end

end
