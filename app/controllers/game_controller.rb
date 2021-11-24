class GameController < ApplicationController

  def index
    @created_matches = Match.where(participant: nil).pluck(:owner)
  end

  def crate_a_match
    new_match = Match.new(owner: params[:id])
    new_match.save!
    redirect_to match_path(params[:id])
  end

  def connect_to_match
    match = Match.find_by(owner: params[:match_name])
    match.update(participant: params[:id])
    redirect_to match_path(params[:match_name])
  end

  private

  def redirect_to_match
    redirect_to match_path(params[:match_name])
  end
end
