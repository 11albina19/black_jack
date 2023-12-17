# frozen_string_literal: true
require_relative 'card'
require_relative 'deck'
require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'mechanics'

class Game
  MENU_FIRST_ITEM = 1
  MENU_LAST_ITEM = 3
  EXIT_ACTION = 99

  attr_reader :exit_action_num, :dealer
  attr_accessor :user

  MENU = [
    {number: 1, message: 'Пропустить', action: :skip },
    {number: 2, message: 'Добавить карту', action: :add },
    {number: 3, message: 'Открыть карты', action: :open_cards },
    {number: 99, message: 'Завершить выполнение программы', action: :show_menu }
  ].freeze

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new(@deck)
    @menu = MENU
    @exit_action_num = EXIT_ACTION
  end

  def menu
    create_user
    puts "#{self.user.name}, ваш банк: #{self.user.bank}$, банк дилера #{self.dealer.bank}$"
    distribution
    puts "Сумма ваших очков: " #ДОДЕЛАТЬ
    puts "Ставка в банк игры - 10$ с каждой стороны" #ДОДЕЛАТЬ
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
    puts "Выбран пропуск хода. Ход переходит дилеру"
  end

  def add
    puts "Выбрано добавить карту. "
    puts "Важно: доступно, только если у вас на руках 2 карты"
  end

  def open_cards
    puts "Выбрано вскрыть карты. Начинается подсчет очков"
  end

  def distribution
    puts "Приступаем к раздаче карт. Ваши карты:"
    2.times do
      self.user.make_move
      self.dealer.deal
    end
  end

  def create_user
    puts "Как вас зовут?"
    name = gets.chomp
    #!!!Тут нужно проверку прописать - если введено не корректное значение
    self.user = Player.new(name.to_s, @deck)
  end
end

game = Game.new
game.menu
#============= main loop ==============
loop do
  action_num = game.action_input
  break if action_num == game.exit_action_num

  action = game.get_action(action_num)
  game.send(action)
  puts "--- #{game.menu.find { |m| m[:number] == action_num }[:message]} ---"
end