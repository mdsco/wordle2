class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    redirect_to Game.create
  end

  def update
    @game = Game.find(params[:id])

    params[:game].each do |key, value|
      row, col = key.split('-')
      @game.evaluate(row, col, value)
    end

    render show
    
  end
end
