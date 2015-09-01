class Game < ActiveRecord::Base
  belongs_to :player

  def self.to_csv

    CSV.generate do |csv|
      csv << ["Nom", "Age", "Genre", "Total", "Ball touche", "Reference", "Date "]
      all.each do |game|

          csv << [game.player_name, game.player_age, game.player_genre, game.total_touches, game.ball_touched, game.first_time, game.created_at]

      end
    end
  end
end
