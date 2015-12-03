class Podcast < ActiveRecord::Base
    belongs_to :user
    has_many :episodes
    has_many :categories, through: :category_podcasts
    has_many :category_podcasts
    validates :title, presence: true
    has_attached_file :image, styles: {thumb: "100x100#", medium: "600x600#"}, default_url: "/images/:style/no_cover.png"
    validates_attachment :image, content_type: {content_type: /\Aimage/}
    validates :title, presence: true, length: {maximum: 255, minimum: 2}
    validates :description, presence: true, length: {maximum: 8000}
    before_save :gen_image_from_title
    before_validation { image.clear if delete_image == '1' }

    attr_accessor :delete_image

    def gen_image_from_title
      unless self.image.exists?
        self.image = TitleRender.render(self.title)
      end
    end
end
