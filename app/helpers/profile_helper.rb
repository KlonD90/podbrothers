module ProfileHelper
  def podcast_path(podcast)
    url_for action: 'show', controller: 'podcast', id: podcast.id
  end
end
