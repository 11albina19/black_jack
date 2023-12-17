# frozen_string_literal: true

class Game

  attr_accessor :bank

  def initialize
    @bank = 100
  end

  def place(user)
    user.bank -= 10
    self.bank += 10
  end

  def recalculation

  end

  def determine(player, dealer)

  end

  def check(player, dealer)
    if player.cards.size == 3 && dealer.cards.size == 3
      game_over = true
    else
      game_over = false
    end
    game_over
  end
end
