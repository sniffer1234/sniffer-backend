class CreateSniffs < ActiveRecord::Migration[5.0]
  def change
    create_table :sniffs do |t|
      t.attachment :img
      t.attachment :video
      t.string :label
      t.integer :duration
      t.references :sniffable, polymorphic: true, index: true
      t.references :user, index: true, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
