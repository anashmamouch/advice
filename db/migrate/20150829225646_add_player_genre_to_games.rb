class AddPlayerGenreToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_genre, :string
  end
end
