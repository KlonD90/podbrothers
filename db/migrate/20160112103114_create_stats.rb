class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :episode_id
      t.string :ip
      t.string :country
      t.string :city
      t.integer :timestamp

      t.timestamps null: false
    end
  end
end
