class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string :name, index: true, null: false
      t.attachment :avatar
      t.attachment :cover

      t.text :suggestion_message
      t.text :description
      t.text :small_description

      t.string :slug
      t.string :facebook
      t.string :instagram
      t.string :phone
      t.string :site
      t.string :email

      t.boolean :vip, default: false
      t.boolean :aprooved, default: true
      t.boolean :visible, default: true

      t.references :user, index: true

      t.timestamps
    end
  end
end
