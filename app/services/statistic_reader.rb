class StatisticReader
    def self.read
       
        while !(element = $redis.lpop("file_log")).nil? do
            arr = element.split('!')
            gmtime = DateTime.parse(arr[0])
            # day = gmtime.day
            # month = gmtime.month
            # year = gmtime.year
            # hour = gmtime.hour
            min = gmtime.minute
            minute = (min-min%5).round
            # newdate = DateTime.new(gmtime.year, gmtime.month, gmtime.day, gmtime.hour, minute)
            new_date = gmtime.change(:min => minute).to_i #timestamp
            
           
            fileName = arr[1].split('/')
            episode_id = (fileName[4]+fileName[5]+fileName[6]).to_i
            timestamp = new_date
            ip = arr[2]
            city = arr[4]
            country = arr[3]
            latitude = arr[5].to_f
            longitude = arr[6].to_f
            geo = Geo.find_by city: city, country: country
            if geo.nil?
               geo = Geo.new
               geo.city = city
               geo.country = country
               geo.latitude = latitude
               geo.longitude = longitude
               binding.pry
               geo.save!                  
            end    
            stat_existed = Stat.find_by(episode_id: episode_id, geo: geo, timestamp: timestamp)
            if !stat_existed.nil?
                stat_existed.increment!(:count)
            else
                stat = Stat.new
                stat.episode_id = episode_id
                stat.ip = ip
                stat.geo = geo
                stat.timestamp = timestamp
                stat.save!
                    
            end    
        end
    end
end
