class CreateContactsTeams < ActiveRecord::Migration
  def change
    create_table :contacts_teams, id: false do |t|
      t.references :team, index: true, foreign_key: true
      t.references :contact, index: true, foreign_key: true
    end
  end
end
