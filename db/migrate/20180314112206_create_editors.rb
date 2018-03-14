class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.string :name
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
