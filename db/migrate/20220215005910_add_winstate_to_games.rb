class AddWinstateToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :winstate, :string
  end
end
