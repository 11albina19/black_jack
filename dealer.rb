# frozen_string_literal: true
require_relative 'participant'

class Dealer < Participant

  def make_move
    points < 17 ? (deal; true) : false
    puts "Дилер завершил ход"
  end
end
