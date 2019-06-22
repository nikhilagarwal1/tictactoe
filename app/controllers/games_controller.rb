class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    game = Game.find_by(id: params[:id])

    render json: game, :include => [
      :moves => { :except => :game_id },
      :players => { :except => :game_id }
    ]
  end

  def create
    game = Game.create({})
    game.save

    render json: game, :except => :updated_at
  end

  def update
    game = Game.find_by(id: params[:id])
    new_move = Move.new(x: params[:x], y: params[:y], game_id: game.id, player_id: params[:player_id])

    begin
      new_move.save

      if new_move.errors.empty? then render json: new_move
      # Handle validation errors
      else render json: { errors: new_move.errors } end

    # Handle already played move exception
    rescue ActiveRecord::RecordNotUnique => e
      render json: { errors: { game: ["Move has already been played."] } }
    end
  end
end
