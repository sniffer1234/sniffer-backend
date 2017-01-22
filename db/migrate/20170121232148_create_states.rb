class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name, index: true
      t.string :short_name
      t.string :region
      t.string :abbr

      t.timestamps
    end
  end
end
