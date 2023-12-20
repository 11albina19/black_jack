# frozen_string_literal: true
require_relative 'participant'

class Player < Participant

  attr_accessor :name

  def initialize(name = 'demo')
    @name = name
    super()
  end

  def check
    cards.size <= 2 ? true : false
  end
end
