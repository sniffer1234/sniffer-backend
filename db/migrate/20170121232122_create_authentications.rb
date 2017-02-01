class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :token, null: false, index: true
      t.datetime :expiration, null: false
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
