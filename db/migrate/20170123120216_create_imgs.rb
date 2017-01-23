class CreateImgs < ActiveRecord::Migration[5.0]
  def change
    create_table :imgs do |t|
      t.string :label
      t.attachment :src, null: false
      t.integer :position
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
