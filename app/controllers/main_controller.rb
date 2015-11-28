class MainController < ApplicationController
    def index
        @last_episodes = Episode.order(:created_at).take(50)
        @last_users = User.order(:created_at).take(10)
    end
end
