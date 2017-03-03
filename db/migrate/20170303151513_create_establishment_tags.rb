class CreateEstablishmentTags < ActiveRecord::Migration[5.0]
  def change
    create_table :establishments_tags, id: false do |t|
      t.belongs_to :establishment
      t.belongs_to :tag
    end
  end
end
