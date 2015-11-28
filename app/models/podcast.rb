class Podcast < ActiveRecord::Base
    belongs_to :user
    has_many :episodes
    has_attached_file :image, styles: {thumb: "100x100#", medium: "600x600#"}
    validates_attachment :image, content_type: {content_type: /\Aimage/}
end
