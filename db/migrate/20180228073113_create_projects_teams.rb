class CreateProjectsTeams < ActiveRecord::Migration
  def change
    create_table :projects_teams, id: false do |t|
      t.references :team, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
