class GameController < ApplicationController
  def index
    @created_matches = Match.where(participant: nil).pluck(:owner)
    # @waiting_players = keys.present? ? REDIS.mget(keys) : []
    # values.each
  end

  def crate_a_match
    redirect_to match_path(params[:id])
    # Match.create(params[:id])
    new_match = Match.new(owner: params[:id])
    new_match.save!
  end

  def connect_to_match
    redirect_to match_path(params[:match_name]) and return
    # sleep 5
    # Match.connect_to_game(params[:id], params[:match_name])
    match = Match.find_by(owner: params[:match_name])
    match.update(participant: params[:id])
    Game.start(params[:id], params[:match_name])
  end
end
