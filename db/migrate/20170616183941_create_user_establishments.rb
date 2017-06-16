class CreateUserEstablishments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_establishments do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :establishment, null: false, index: true
      t.timestamps
    end
  end
end
