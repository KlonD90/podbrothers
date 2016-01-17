class CreateGeos < ActiveRecord::Migration
  def change
    create_table :geos do |t|
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
