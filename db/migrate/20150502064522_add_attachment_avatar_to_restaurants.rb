class AddAttachmentAvatarToRestaurants < ActiveRecord::Migration
  def self.up
    change_table :restaurants do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :restaurants, :avatar
  end
end
