class Podcast < ActiveRecord::Base
    belongs_to :user
    has_many :episodes
    has_many :categories, through: :category_podcasts
    has_many :category_podcasts
    has_attached_file :image, styles: {thumb: "100x100#", medium: "600x600#"}
    validates_attachment :image, content_type: {content_type: /\Aimage/}
    validates :title, presence: true, length: {maximum: 255, minimum: 2}
    validates :description, presence: true, length: {maximum: 8000}
end
