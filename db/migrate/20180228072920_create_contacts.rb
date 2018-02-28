class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :country
      t.string :city
      t.string :postcode
      t.string :street
      t.integer, :phone
      t.8 :limit
      t.string :email
      t.references :authority, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
