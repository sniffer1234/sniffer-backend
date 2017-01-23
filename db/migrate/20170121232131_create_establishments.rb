class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string :name, index: true
      t.text :description
      t.string :slug
      t.string :facebook
      t.string :instagram
      t.string :phone
      t.string :site
      t.string :email
      t.boolean :vip, default: false
      t.boolean :visible, default: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
