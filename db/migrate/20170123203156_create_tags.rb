class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.integer :alias, null: false
      t.references :establishment, null: false, index: true
      
      t.timestamps
    end
  end
end
