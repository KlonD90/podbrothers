class RemoveCityFromStats < ActiveRecord::Migration
  def change
    remove_column :stats, :city, :string
  end
end
