class AddDownloadCountToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :download_count, :integer, default: 0, null: false
  end
end
