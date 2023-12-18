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

  attr_reader :exit_action_num, :dealer, :game
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
    @dealer = Dealer.new(@deck)
    @menu = MENU
    @exit_action_num = EXIT_ACTION
    binding.pry
  end

  def start
    if self.player == nil
      create_user
      puts "#{self.player.name}, ваш банк: #{self.player.bank}$, банк дилера #{self.dealer.bank}$"
      distribution
      points
      place
    end
  end

  def menu
    show_menu
  end

  def show_menu
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
    puts "-----------------------------------------"
    puts "Выбран пропуск хода. Ход переходит дилеру"
    self.dealer.make_move
    check(self.player, self.dealer)
  end

  def add
    puts "-----------------------------------------"
    puts "Выбрано добавить карту. "
    puts "Важно: доступно, только если у вас на руках 2 карты"
    done = self.player.make_move
    check(self.player, self.dealer)
    if done
      puts "Ваш ход завершен. Ход переходит дилеру"
      self.dealer.make_move
      check(self.player, self.dealer)
    else
      puts "У вас на руках более 2 карт, добавление не доступно"
    end
  end

  def open_cards
    puts "-----------------------------------------"
    puts "Начинается подсчет очков"
    champion = self.game.determine(self.player, self.dealer)
    self.game.recalculation(self.player, self.dealer, champion)
    self.game.game_over = true
  end

  def distribution
    puts "Приступаем к раздаче карт. Ваши карты:"
    2.times do
      self.player.make_move
      self.dealer.deal
    end
  end

  def create_user
    puts "Как вас зовут?"
    name = gets.chomp
    name = "demo" if name == nil
    self.player = Player.new(name.to_s, @deck)
  end

  def place
    puts "Ставка в банк игры - 10$ с каждой стороны"
    self.game.place(self.player)
    self.game.place(self.dealer)
    puts "#{self.player.name}, ваш банк: #{self.player.bank}$, банк дилера #{self.dealer.bank}$"
    puts "Банк игры: #{self.game.bank}$"
  end

  def check(player, dealer)
    self.game.game_over = self.game.check(player, dealer)
    open_cards if self.game.game_over == true
  end

  def points
    puts "Сумма ваших очков: #{self.player.points}"
  end
end

new_game = Menu.new
new_game.start
#============= main loop ==============
loop do
  new_game.show_menu if new_game.game.game_over == false
  action_num = new_game.action_input
  break if action_num == new_game.exit_action_num
  action = new_game.get_action(action_num)
  puts "--- #{new_game.menu.find { |m| m[:number] == action_num }[:message]} ---"
  new_game.send(action)
  if new_game.game.game_over == true
    puts "Игра завершена!"
    puts "Хотите сыграть снова? да - 1, нет - любая другая цифра"
    choice = gets.chomp.to_s
    if choice == '1'
      new_game.game.game_over = false
      new_game.start
      #new_game = Menu.new
      #new_game.menu
    else
      break
    end
  end
end

