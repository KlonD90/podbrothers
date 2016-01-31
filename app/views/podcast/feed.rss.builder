title = @podcast.title
author = ""
description = @podcast.description
keywords = "podcasts"
prefix_url = if request.ssl? then "https" else "http" end
prefix_url = prefix_url + '://'+ request.host_with_port
image = prefix_url + @podcast.image.url(:thumb)
ext = 'mp3'

xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do
    xml.title title
    xml.link prefix_url + url_for(@podcast)
    xml.description description
    xml.language 'ru'
    xml.pubDate @podcast.created_at.to_s(:rfc822)
    xml.lastBuildDate @podcast.updated_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, :href => image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'admin@podbrothers.ru'
    end
    xml.itunes :block, 'no'
    @categories.each do |category|
      xml.itunes :category, :text => category.title do
        xml.itunes :category, :text => category.title
      end
    end

    @episodes.each do  |episode|
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.enclosure :url => prefix_url + episode.file.url, :length => episode.file.size, :type => 'audio/mp3'
        xml.link prefix_url+episode.file.url
        xml.guid({:isPermaLink => "false"}, prefix_url+episode.file.url)
        xml.itunes :author, author
        xml.itunes :link, prefix_url + url_for(action: 'show', controller: 'episode', :id => episode.id)
        xml.itunes :subtitle, truncate(episode.description, :length => 150)
        xml.itunes :summary, episode.description
        xml.itunes :explicit, 'no'
        xml.itunes :duration, 12323
      end
    end
  end
end