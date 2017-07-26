class AddAttachmentAvatarToTags < ActiveRecord::Migration
  def self.up
    change_table :tags do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :tags, :avatar
  end
end
