class AddGeoIdToStats < ActiveRecord::Migration
  def change
    add_column :stats, :geo_id, :integer
  end
end
