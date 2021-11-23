class GameController < ApplicationController
  def index
    keys = REDIS.keys('match_*')
    @waiting_players = keys.present? ? REDIS.mget(keys) : []
  end

  def crate_a_match
    Match.create(params[:id])
    redirect_to match_path(params[:id])
  end

  def connect_to_match
    Match.connect_to_game(params[:id], params[:match_name])
    redirect_to match_path(params[:match_name])
  end
end
