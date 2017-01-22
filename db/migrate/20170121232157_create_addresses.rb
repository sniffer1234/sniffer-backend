class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :completed
      t.string :zipcode
      t.string :neighborhood
      t.float :latitude
      t.float :longitude
      t.references :city, null: false, index: true
      t.references :local, null: false, index: true

      t.timestamps
    end
  end
end
