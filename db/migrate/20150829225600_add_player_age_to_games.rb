class AddPlayerAgeToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_age, :string
  end
end
