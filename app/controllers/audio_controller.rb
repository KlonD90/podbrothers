class AudioController < ApplicationController
  def get_info_from_file
    # Load a file
    require 'taglib'
    puts "#{Rails.application.config.root}/public/system/episodes/files/000/000/011/original/11_1449071561.mp3"
    TagLib::FileRef.open("#{Rails.application.config.root}/public/system/episodes/files/000/000/011/original/11_1449071561.mp3") do |fileref|
      unless fileref.null?
        tag = fileref.tag
        tag.title   #=> "Wake Up"
        tag.artist  #=> "Arcade Fire"
        tag.album   #=> "Funeral"
        tag.year    #=> 2004
        tag.track   #=> 7
        tag.genre   #=> "Indie Rock"
        tag.comment #=> nil

        properties = fileref.audio_properties
        properties.length  #=> 335 (song length in seconds)
        return render json: { 'info' => tag.title}
      end
    end  # File is automatically closed at block end
    render json: {'code' => 'not read'}
  end
end
