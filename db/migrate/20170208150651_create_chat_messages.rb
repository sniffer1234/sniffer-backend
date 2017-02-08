class CreateChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.text :content, null: false
      t.boolean :visible, default: true

      t.references :chat, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
