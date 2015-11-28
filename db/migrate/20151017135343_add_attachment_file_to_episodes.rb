class AddAttachmentFileToEpisodes < ActiveRecord::Migration
  def self.up
    change_table :episodes do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :episodes, :file
  end
end
