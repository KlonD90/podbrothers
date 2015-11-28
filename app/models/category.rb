class Category < ActiveRecord::Base
  has_many :podcasts, through: :category_podcasts
  has_many :category_podcasts
end
