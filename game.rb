# frozen_string_literal: true
require_relative 'card'
require_relative 'deck'
require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'mechanics'
require_relative 'menu'

class Game

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
end

game = RailRoad.new
game.menu
#============= main loop ==============
loop do
  action_num = game.action_input
  break if action_num == game.exit_action_num

  action = game.get_action(action_num)
  puts "--- #{game.menu.find { |m| m[:number] == action_num }[:message]} ---"
  game.send(action)
end