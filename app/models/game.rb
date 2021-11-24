class Game < ApplicationRecord
  def self.start(player1, player2)
    # Рандомно определяется очередь
    cross, nought = [player1, player2].shuffle

    # Броадкаст пользователям и старт игры
    ActionCable.server.broadcast "player_#{cross}", { action: 'game_start', msg: 'cross' }
    ActionCable.server.broadcast "player_#{nought}", { action: 'game_start', msg: 'nought' }

    REDIS.set("opponent_for:#{cross}", nought)
    REDIS.set("opponent_for:#{nought}", cross)
  end

  def self.withdraw(current_user)
    winner = opponent_for(current_user)
    ActionCable.server.broadcast "player_#{winner}", { action: 'opponent_withdraw' } if winner
  end

  def self.opponent_for(current_user)
    REDIS.get("opponent_for:#{current_user}")
  end

  def self.take_turn(current_user, move)
    opponent = opponent_for(current_user)
    ActionCable.server.broadcast "player_#{opponent}", { action: 'take_turn', move: move['data'] }
  end

  def self.new_game(current_user)
    opponent = opponent_for(current_user)
    ActionCable.server.broadcast "player_#{opponent}", { action: 'new_game' }
  end
end
