class EpisodesManipulateController < ApplicationController
  def create
    @action = 'create'
  end

  def create_form
    @action = 'create'
    @podcast = Podcast.find(params[:id])
    @episode = Episode.new
  end

  def edit

  end

  def update

  end
end
