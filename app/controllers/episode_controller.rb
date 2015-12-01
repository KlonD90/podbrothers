class EpisodeController < ApplicationController
  # def create
  #   @last_episodes = Episode.order(:created_at).take(50)
  #   @last_users = User.order(:created_at).take(10)
  # end
  before_action :authenticate_user!

  def create
    @episode = Episode.new(episode_params)
    # @episode.user_id = current_user.id
    @action = 'create'
    if @episode.save
      redirect_to @episode
    else
      render "podcast/#{params[:podcast_id]}/episode/create"
    end
  end

  def form
    @action = 'create'
    @podcast = Podcast.new
    render "episode/create"
  end

  def edit
    @episode = Episode.find(params[:id])
    @action = 'update'
    if @episode.user_id == current_user.id
      render "episode/edit"
    else
      raise 'Not owner of episode'
    end
  end

  def update
    @episode = Episode.find(params[:id])
    @action = 'update'
    if @episode.user_id == current_user.id
      if @episode.update_attributes(episode_params)
        redirect_to @episode
      else
        render "episode/edit"
        # format.html { render :action => "edit" }
        # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    else
      raise 'Not owner of podcast'
    end
  end
  def show
    @podcast = Episode.find(params[:id])
    if @podcast.blank?
      raise 'no episode'
    end
    render "episode/show"
  end
  def list
    @podcasts = Episode.all.where(user_id: current_user.id).order(:created_at)
    render "episode/list"
  end

  private

  def episode_params
    params.require(:episode).permit!
  end

  def episode_url(record)
    url_for(action: 'show', controller: 'episode ', :id => record.id)
  end
end
