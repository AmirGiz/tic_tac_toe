class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{uuid}"
    Match.create(uuid)
  end

  def unsubscribed
    Game.withdraw(uuid)
    # Remove yourself from the waiting list
    Match.remove(uuid)
  end

  def take_turn(data)
    Game.take_turn(uuid, data)
  end

  def new_game
    Game.new_game(uuid)
  end
end
