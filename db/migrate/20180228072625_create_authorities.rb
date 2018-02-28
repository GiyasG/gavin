class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.string :title
      t.string :name
      t.string :surname
      t.string :position
      t.text :about
      t.date :dob
      t.string :sex

      t.timestamps null: false
    end
  end
end
