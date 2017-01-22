class CreateEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
