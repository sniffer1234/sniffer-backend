class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, index: true, null: false
      t.date :when, null: false
      t.string :from, null: false
      t.string :to, null: false
      t.text :description, null: false
      t.string :slug

      t.boolean :vip, default: false
      t.boolean :aprooved, default: true
      t.boolean :visible, default: true

      t.references :establishment, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
