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
end
