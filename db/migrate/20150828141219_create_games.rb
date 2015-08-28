class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :ball_touched
      t.integer :total_touches
      t.boolean :first_time
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
