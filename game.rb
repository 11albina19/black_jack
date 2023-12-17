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


end
