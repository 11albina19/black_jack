# frozen_string_literal: true
require_relative 'card'
require_relative 'deck'
require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'game'

require 'pry'

class Menu
  MENU_FIRST_ITEM = 1
  MENU_LAST_ITEM = 3
  EXIT_ACTION = 99

  attr_reader :exit_action_num, :dealer, :game, :deck
  attr_accessor :player

  MENU = [
    { number: 1, message: 'Пропустить', action: :skip },
    { number: 2, message: 'Добавить карту', action: :add },
    { number: 3, message: 'Открыть карты', action: :open_cards },
    { number: 99, message: 'Завершить выполнение программы', action: :show_menu }
  ].freeze

  def initialize
    @game = Game.new
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @menu = MENU
    @exit_action_num = EXIT_ACTION
  end

  def start # показывается только 1 раз
    puts "------------------------------------------------------"
    fill_user
  end

  def replay # показывается каждый раз при повторной игре
    puts "------------------------------------------------------"
    bank
    distribution
    place
    puts "------------------------------------------------------"
  end

  def clear
    self.dealer.cards.clear
    self.player.cards.clear
    self.game.bank = 0
  end

  def show_menu # вывод меню
    @menu.each do |item|
      puts "#{item[:number]}: #{item[:message]}"
    end
  end

  def action_input
    loop do
      print 'Ваш ход. Выберите команду из списка: '
      action_num = gets.chomp.to_i
      return action_num if (action_num >= MENU_FIRST_ITEM && action_num <= MENU_LAST_ITEM) || action_num == EXIT_ACTION
    end
  end

  def get_action(action_num)
    menu_item = @menu.find do |m|
      m[:number] == action_num
    end
    menu_item[:action]
  end

  def skip
    puts "-------------пропуск хода----------------------------"
    puts "Ход переходит дилеру"
    dealers_move
    puts "------------------------------------------------------"
  end

  def add
    puts "-------------добавить карту----------------------------"
    player_move
    puts "------------------------------------------------------"
  end

  def open_cards
    puts "-------------открыть карты----------------------------"
    puts "Начинается подсчет очков"
    champion = self.game.determine(self.player, self.dealer)
    self.game.recalculation(self.player, self.dealer, champion)
    self.game.game_over = true
    bank
    puts "------------------------------------------------------"
  end

  def distribution
    puts "Приступаем к раздаче карт. Ваши карты:"
    2.times do
      card = self.deck.take_card
      self.player.write(card)
      show_card(card)
      card = self.deck.take_card
      self.dealer.write(card)
    end
    points
  end

  def fill_user
    puts "Как вас зовут?"
    name = gets.chomp
    self.player.name = name.to_s
  end

  def place
    puts "Ставка в банк игры - 10$ с каждой стороны"
    self.game.place(self.player)
    self.game.place(self.dealer)
    bank
  end

  def check
    self.game.game_over = self.game.check(self.player, self.dealer)
    if self.game.game_over
      open_cards
      true
    else
      false
    end
  end

  def points
    puts "Сумма ваших очков: #{self.player.points}"
  end

  def dealers_move
    puts "Дилер завершил ход"
    if self.dealer.check
      card = self.deck.take_card
      self.dealer.write(card)
      check
    end
  end

  def player_move
    if self.player.check
      card = self.deck.take_card
      self.player.write(card)
      show_card(card)
      points
      game_over = check
      puts "Ваш ход завершен."
      dealers_move unless game_over
    else
      puts "У вас на руках более 2 карт, добавление не доступно"
    end
  end

  def show_card(card)
    puts "Карта #{card.suit}  #{card.rank}, приносит очков: #{card.points} "
  end

  def bank
    puts "#{self.player.name}, ваш банк: #{self.player.bank}$, банк дилера: #{self.dealer.bank}$"
    puts "Банк игры: #{self.game.bank}$"
  end
end

new_game = Menu.new
new_game.start
new_game.replay
#new_game.show_menu
#============= main loop ==============
loop do
  new_game.show_menu 
  action_num = new_game.action_input
  break if action_num == new_game.exit_action_num
  action = new_game.get_action(action_num)
  new_game.send(action)
  if new_game.game.game_over
    puts "Игра завершена!"
    puts "Хотите сыграть снова? да - 1, нет - любая другая цифра"
    choice = gets.chomp.to_s
    if choice == '1'
      new_game.game.game_over = false
      new_game.clear
      new_game.replay
    else
      break
    end
  end
end

