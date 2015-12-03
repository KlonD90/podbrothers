class Episode < ActiveRecord::Base
  belongs_to :podcast
  has_attached_file :image, styles: {thumb: "100x100#", medium: "600x600#"}
  validates_attachment :image, content_type: {content_type: /\Aimage/}
  has_attached_file :file
  validates_attachment :file, content_type: {content_type: /\Aaudio/}
  validates_attachment_file_name :file, matches: [/mp3\Z/, /m4a\Z/]
  validates :podcast_id, presence: true

  before_post_process :rename_file

  def rename_file
    #avatar_file_name - important is the first word - avatar - depends on your column in DB table
    extension = File.extname(file_file_name).downcase
    self.file.instance_write :file_name, "#{self['id']}_#{Time.now.to_i.to_s}#{extension}"
  end

  def public_image
    return image unless image.nil?
    return podcast.image
  end
end
        
