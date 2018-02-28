class AddTeamsIndexes < ActiveRecord::Migration
  def change
    add_index :projects_teams, [:project_id, :team_id], unique: true
    add_index :papers_teams, [:paper_id, :team_id], unique: true
    add_index :contacts_teams, [:contact_id, :team_id], unique: true
    add_index :photos_teams, [:photo_id, :team_id], unique: true 
  end
end
