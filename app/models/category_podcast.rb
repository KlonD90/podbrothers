class CategoryPodcast < ActiveRecord::Base
  belongs_to :podcast
  belongs_to :category

end
