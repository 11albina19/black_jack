# frozen_string_literal: true
require_relative 'participant'

class Dealer < Participant

  def check
    points < 17 ? true : false
  end
end
