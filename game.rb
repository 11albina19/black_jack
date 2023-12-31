# frozen_string_literal: true

class Game

  attr_accessor :bank, :game_over

  def initialize
    @bank = 0
    @game_over = false
  end

  def place(user)
    user.bank -= 10
    self.bank += 10
  end

  def recalculation (player, dealer, champion)
    if champion == 1
      player.bank += self.bank
      self.bank  -= 20
      puts "Вы победили!"
    elsif champion == 2
      dealer.bank += self.bank
      self.bank  -= 20
      puts "Вы проиграли."
    elsif champion == 3
      player.bank += 10
      dealer.bank += 10
      self.bank  -= 20
      puts "Игра закончилась ничьей"
    end
    self.game_over = true
  end

  def determine(player, dealer)
    show(player, dealer)
    number_player = player.points
    number_dealer = dealer.points
    champion = 0
    if number_dealer > 21 && number_player > 21
      champion = 3 #ничья
    elsif number_dealer > 21
      champion = 1 #у дилера > 21, победитель игрок
    elsif number_player > 21
      champion = 2 #у игрока > 21, победитель дилер
    elsif number_player == number_dealer
      champion = 3 #ничья
    elsif number_player > number_dealer
      champion = 1 #игрок набрал больше очков, победитель игрок
    elsif number_dealer > number_player
      champion = 2 #дилер набрал больше очков, победитель дилер
    else
      champion = 4 #что-то странное
    end
    champion
  end

  def check(player, dealer)
    if player.cards.size == 3 && dealer.cards.size == 3
      game_finish = true
    else
      game_finish = false
    end
    game_finish
  end

  def show(player, dealer)
    puts 'Ваши карты:'
    player.show_cards
    puts "Ваши очки: #{player.points}"
    puts 'Карты дилера:'
    dealer.show_cards
    puts "Очки дилера: #{dealer.points}"
  end
end
