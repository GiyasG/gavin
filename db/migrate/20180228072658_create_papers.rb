class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title
      t.text :description
      t.string :url
      t.date :published
      t.references :authority, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
