class AddIndexToStats < ActiveRecord::Migration
  def change
      add_index :stats, [:episode_id, :timestamp, :geo_id], unique: true
      add_index :stats, [:episode_id, :timestamp]
  end
end
