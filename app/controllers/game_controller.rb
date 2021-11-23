class GameController < ApplicationController
  def index
    keys = REDIS.keys('match_*')
    @waiting_players = keys.present? ? REDIS.mget(keys) : []
    # values.each
  end

  def crate_a_match
    redirect_to match_path(params[:id])
    Match.create(params[:id])
  end

  def connect_to_match
    redirect_to match_path(params[:match_name])
    # sleep 5
    Match.connect_to_game(params[:id], params[:match_name])
  end
end
