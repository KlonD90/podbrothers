class StatController < ApplicationController
    def list
        episode_id = params[:episode_id]
        time_period = params[:time_period]
        if episode_id.nil?
            raise "wrong input data"
        end
        episode = Episode.find(episode_id)
        if episode.nil?
            raise 'no exist episode'
        end
        case time_period
            when "last_week"
                d = Date.today
                prev_day = d.prev_day(7)
                # sum count
            when "last_day"
                d = Date.today
                prev_day = d.prev_day(1)
            when "last_month"
                d = Date.today
                prev_month = d.prev_month(1)
            else
                # all time
        end
    end

    def show
        render "stat/show"
    end
end
