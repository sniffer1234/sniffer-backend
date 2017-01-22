class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name, index: true
      t.references :state, index: true, null: false

      t.timestamps
    end
  end
end
