class RemoveCountryFromStats < ActiveRecord::Migration
  def change
    remove_column :stats, :country, :string
  end
end
