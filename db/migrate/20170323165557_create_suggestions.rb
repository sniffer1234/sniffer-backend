class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.text :content, null: false
      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
