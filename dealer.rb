# frozen_string_literal: true

class Dealer

  def make_move
    points < 17 ? (deal; true) : false
    puts "Дилер завершил ход"
  end
end
