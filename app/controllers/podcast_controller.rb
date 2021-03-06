class PodcastController < ApplicationController
  before_action :authenticate_user!, except: [:show, :feed]

  def create
    @podcast = Podcast.new(podcast_params)
    @podcast.user_id = current_user.id
    @action = 'create'
    if @podcast.save
      redirect_to @podcast
    else
      render "podcast/create"
    end
  end

  def form
    @action = 'create'
    @podcast = Podcast.new
    render "podcast/create"
  end

  def edit
    @podcast = Podcast.find(params[:id])
    @action = 'update'
    if @podcast.user_id == current_user.id
      render "podcast/edit"
    else
      raise 'Not owner of podcast'
    end
  end

  def update
    @podcast = Podcast.find(params[:id])
    @action = 'update'
    if @podcast.user_id == current_user.id
      if @podcast.update_attributes(podcast_params)
        redirect_to @podcast
      else
        render "podcast/edit"
        # format.html { render :action => "edit" }
        # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    else
      raise 'Not owner of podcast'
    end
  end
  def show
    @podcast = Podcast.find(params[:id])
    if @podcast.blank?
      raise 'no podcast'
    end
    render "podcast/show"
  end
  def list
    @podcasts = Podcast.all.where(user_id: current_user.id)
    render "podcast/list"
  end
  def feed
    @prefix_url = if request.ssl? then "https" else "http" end
    @prefix_url = @prefix_url + '://'+ request.host_with_port
    @podcast_id = params[:podcast_id]
    @podcast = Podcast.find(@podcast_id)
    if @podcast.blank?
      raise 'no exist podcast'
    end
    @category_title = ''
    @categories = CategoryPodcast.where(podcast_id:@podcast_id).includes(:category)
    # @categories.each do |cat|
    #   if @category_title = ''
    #     @category_title = cat.title
    #   else
    #     @category_title = @category_title + ',' +cat.title
    #   end
    # end
    @episodes = Episode.where(podcast_id: @podcast_id).order(created_at: :desc)
    if @episodes.blank?
      raise 'no episodes'
    end
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private

  def podcast_params
    params.require(:podcast).permit!
  end

  def podcast_url(record)
    url_for(action: 'show', controller: 'podcast', :id => record.id)
  end
  def episode_url(record)
    url_for(action: 'show', controller: 'episode', :id => record.id)
  end
end
