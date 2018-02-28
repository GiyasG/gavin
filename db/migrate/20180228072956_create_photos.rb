class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.text :description
      t.references :authority, index: true, foreign_key: true
      t.references :paper, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
