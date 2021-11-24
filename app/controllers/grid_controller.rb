class GridController < ApplicationController
  after_action :start_game

  def index; end

  private

  def start_game
    match = Match.find_by(owner: params[:id])
    Game.start(match.participant, params[:id]) if match.present?
  end
end
