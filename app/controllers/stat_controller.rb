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
        time_period = params[:time_period] || 'all_time'
        case time_period
            when "last_day"
                end_date = DateTime.now.beginning_of_day.to_time.gmtime.to_i
                start_date = Date.today.prev_day(1).to_time.gmtime.to_i
            when "last_week"
                end_date = DateTime.now.beginning_of_day.to_time.gmtime.to_i
                start_date = Date.today.prev_day(7).to_time.gmtime.to_i
            when "last_month"
                end_date = DateTime.now.beginning_of_day.to_time.gmtime.to_i
                start_date = Date.today.prev_month(1).to_time.gmtime.to_i
            else
                # all time
                start_date = 0
                end_date = DateTime.now.to_time.gmtime.to_i
        end
        binding.pry
        Stat.where("episode_id = :episode_id and timestamp >= :start_date and timestamp <= :end_date",{start_date: start_date, end_date: end_date, episode_id: episode.id}).includes(:geo)
    end

    def show
        render "stat/show"
    end
end
