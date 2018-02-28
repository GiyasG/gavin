class CreatePhotosTeams < ActiveRecord::Migration
  def change
    create_table :photos_teams do |t|
      t.references :team, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
    end
  end
end
