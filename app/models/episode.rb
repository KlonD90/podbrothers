class Episode < ActiveRecord::Base
    belongs_to :podcast
    has_attached_file :image, styles: {thumb: "100x100#", medium: "600x600#"}
    validates_attachment :image, content_type: {content_type: /\Aimage/}
    has_attached_file :file
    validates_attachment :file, content_type: {content_type: 'audio/mpeg'}
    validates_attachment_file_name :file, matches: [/mp3\Z/]
end
        