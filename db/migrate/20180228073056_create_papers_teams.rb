class CreatePapersTeams < ActiveRecord::Migration
  def change
    create_table :papers_teams, id: false do |t|
      t.references :team, index: true, foreign_key: true
      t.references :paper, index: true, foreign_key: true
    end
  end
end
