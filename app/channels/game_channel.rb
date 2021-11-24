class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{current_user}"
  end

  def unsubscribed
    match = Match.find_by(owner: current_user)
    if match.present?
      Game.withdraw(current_user)
      match.destroy
    elsif Match.find_by(participant: current_user).present?
      Game.withdraw(current_user)
    end
  end

  def take_turn(data)
    Game.take_turn(current_user, data)
  end

  def new_game
    Game.new_game(current_user)
  end
end
