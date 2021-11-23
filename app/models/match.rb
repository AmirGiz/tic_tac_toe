class Match < ApplicationRecord
  def self.create(current_user)
    REDIS.set("match_#{current_user}", current_user)
    # ActionCable.server.broadcast "player_#{current_user}", { action: 'match_created' }
  end

  def self.connect_to_game(current_user, opponent)
    Game.start(current_user, opponent)
    REDIS.del("match_#{opponent}")
  end

  def self.remove(current_user)
    REDIS.del("match_#{current_user}") if REDIS.get("match_#{current_user}").present?
  end
end
