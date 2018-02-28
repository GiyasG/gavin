class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :about
      t.date :started
      t.date :finished
      t.string :url
      t.references :authority, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
