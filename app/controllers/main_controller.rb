class MainController < ApplicationController
  def index
    @last_episodes = Episode.order(created_at: :desc).take(30)
    @last_users = User.order(created_at: :desc).take(10)
    @popular_episodes = Episode.order(download_count: :desc).take(30)
  end
end
