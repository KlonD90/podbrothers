class AddCountToStats < ActiveRecord::Migration
  def change
    add_column :stats, :count, :integer, :default => 1
  end
end
