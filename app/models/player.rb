class Player < ActiveRecord::Base
  has_many :games

  def self.to_csv

    CSV.generate do |csv|
      csv << [:username, :age, :genre]
      all.each do |player|
        if( !player.username.blank? || !player.age.blank? || !player.genre.blank?)
          csv << [player.username, player.age, player.genre]
        end
      end
    end
  end

end
