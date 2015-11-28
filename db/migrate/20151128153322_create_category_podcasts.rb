class CreateCategoryPodcasts < ActiveRecord::Migration
  def change
    create_table :category_podcasts do |t|
      t.integer :category_id
      t.integer :podcast_id

      t.timestamps null: false
    end
  end
end
