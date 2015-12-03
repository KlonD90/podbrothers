class ProfileController < ApplicationController
  before_action :get_user

  def get_user
    @user = User.find params[:user_id]
    if @user.blank?
      raise 'no user'
    end
  end


  def index
    @podcasts = @user.podcasts
    @episodes = @user.episodes
    render 'profile/index'
  end

  def podcasts
  end

  def episodes
  end

  def podcast_path
    url_for action: 'show', controller: 'podcast'
  end
end
