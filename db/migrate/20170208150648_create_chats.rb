class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :establishment, null: false, index: true
      t.integer :chat_messages_count, default: 0

      t.timestamps
    end
  end
end
