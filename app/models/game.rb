class Game < ApplicationRecord
  def self.start(player1, player2)
    # Randomly choses who gets to be noughts or crosses
    cross, nought = [player1, player2].shuffle

    # Broadcast back to the players subscribed to the channel that the game has started
    ActionCable.server.broadcast "player_#{cross}", { action: 'game_start', msg: 'cross' }
    ActionCable.server.broadcast "player_#{nought}", { action: 'game_start', msg: 'nought' }

    # Store the details of each opponent
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
