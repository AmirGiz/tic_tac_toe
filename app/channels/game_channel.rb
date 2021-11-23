class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{current_user}"
    # Match.create(current_user)
  end

  def unsubscribed
    if REDIS.get("match_#{current_user}").present?
      Game.withdraw(current_user)
      # Remove yourself from the waiting list
      Match.remove(current_user)
    end
  end

  def take_turn(data)
    Game.take_turn(current_user, data)
  end

  def new_game
    Game.new_game(current_user)
  end

  def new_match
    Match.create(current_user)
  end
end
