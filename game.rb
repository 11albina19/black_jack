# frozen_string_literal: true
require_relative 'card'
require_relative 'deck'
require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'mechanics'
require_relative 'menu'

class Game
  MENU_FIRST_ITEM = 1
  MENU_LAST_ITEM = 3
  EXIT_ACTION = 99

  attr_reader :exit_action_num

  MENU = [
    {number: 1, message: 'Пропустить', action: :skip },
    {number: 2, message: 'Добавить карту', action: :add },
    {number: 3, message: 'Открыть карты', action: :open },
    {number: 99, message: 'Завершить выполнение программы', action: :show_menu }
  ].freeze

  def initialize
    @menu = MENU
    @exit_action_num = EXIT_ACTION
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
      print 'выполнить команду: '
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
end

game = Game.new
game.menu
#============= main loop ==============
loop do
  action_num = game.action_input
  break if action_num == game.exit_action_num

  action = game.get_action(action_num)
  puts "--- #{game.menu.find { |m| m[:number] == action_num }[:message]} ---"
  game.send(action)
end