class StatController < ApplicationController
    def episode
        episode_id = params[:episode_id]
        if episode_id.nil?
            raise "wrong input data"
        end
        if !Episode.exists?(episode_id)
            raise 'no exist episode'
        end
        @time_period = params[:time_period] || 'all_time'
        case @time_period
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
        # Stat.where("episode_id = :episode_id and timestamp >= :start_date and timestamp <= :end_date",{start_date: start_date, end_date: end_date, episode_id: episode_id}).includes(:geo)
        puts start_date, end_date

        query = 'SELECT geos.city, geos.country, geos.latitude, geos.longitude, SUM(stats.count) AS sum_count FROM stats as stats INNER JOIN geos ON geos.id = stats.geo_id WHERE stats.episode_id = ? and stats.timestamp >= ? and stats.timestamp <= ? GROUP BY geo_id'
        a = ActiveRecord::Base.connection.raw_connection.prepare(query)
        render json: a.execute(episode_id, start_date, end_date)
    end
    def show
        @episode_id = params[:episode_id]
        if @episode_id.nil?
            raise "wrong input data"
        end
        if !Episode.exists?(@episode_id)
            raise 'no exist episode'
        end
        @time_period = params[:time_period] || 'all_time'
        render 'stat/show'
    end
end
