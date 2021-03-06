class GamesController < ApplicationController
  def index
    @games = Game.all
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
    if !params[:game].nil?
      params[:game].each do |key, value|
        row, col = key.split('-')
        r = row
        @game.update(row, col, value)
      end
      @game.evaluate(r)
    end

    render show
  end

  def letter_update
    letter = params[:letter]
    id = params[:id]
    row, col = params[:cell].split('-')
    @game = Game.find(params[:id])
    @game.update_letter(row, col, letter)

    render show
  end
end