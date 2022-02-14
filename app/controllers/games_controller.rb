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
    r = ''
    params[:game].each do |key, value|
      row, col = key.split('-')
      r = row
      @game.update(row, col, value)
    end

    @game.evaluate(r)

    render show
  end
end