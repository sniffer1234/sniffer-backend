class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :when
      t.text :description
      t.string :slug

      t.boolean :vip, default: false
      t.boolean :aprooved, default: true
      t.boolean :visible, default: true
      t.boolean :active, default: true

      t.references :establishment, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
