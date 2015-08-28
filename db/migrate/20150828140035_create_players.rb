class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.string :age
      t.string :genre

      t.timestamps null: false
    end
  end
end
