class EpisodeController < ApplicationController
  # def create
  #   @last_episodes = Episode.order(:created_at).take(50)
  #   @last_users = User.order(:created_at).take(10)
  # end
  before_action :authenticate_user!
  before_action :get_podcast

  def get_podcast
    @podcast = Podcast.find params[:podcast_id]
    if @podcast.blank?
      raise 'no podcast'
    end
  end

  def create
    @episode = Episode.new(episode_params)
    @episode.podcast_id = @podcast.id
    # @episode.user_id = current_user.id
    @action = 'create'
    if @episode.save
      redirect_to @episode
    else
      render "episode/create"
    end
  end

  def form
    @action = 'create'
    @episode = Episode.new
    render "episode/create"
  end

  def edit
    @episode = Episode.find params[:id]
    @action = 'update'
    if @episode.blank?
      raise "not exist episode"
    else
      render "episode/edit"
    end
  end

  def update
    @episode = Episode.find(params[:id])
    @action = 'update'
    if @episode.update_attributes(episode_params)
      redirect_to @episode
    else
      render "episode/edit"
      # format.html { render :action => "edit" }
      # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
    end
  end
  def show
    @episode = Episode.find(params[:id])
    if @episode.blank?
      raise 'no episode'
    end
    render "episode/show"
  end
  def list
    @episodes = Episode.all.where podcast_id: @podcast.id
    render "episode/list"
  end

  private

  def episode_params
    params.require(:episode).permit!
  end

  def episode_url(record)
    url_for(action: 'show', controller: 'episode', :id => record.id)
  end
end
