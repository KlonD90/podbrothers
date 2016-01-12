class StatisticReader
    def self.read
        while !(element = $redis.lpop("file_log")).nil? do
            arr = element.split(',')
            gmtime = DateTime.parse(arr[0])
            # day = gmtime.day
            # month = gmtime.month
            # year = gmtime.year
            # hour = gmtime.hour
            min = gmtime.minute
            minute = (min-min%5).round
            # newdate = DateTime.new(gmtime.year, gmtime.month, gmtime.day, gmtime.hour, minute)
            new_date = gmtime.change(:min => minute).to_i #timestamp
            stat = Stats.new
            fileName = arr[1].split('/')
            stat.episode_id = (fileName[4]+fileName[5]+fileName[6]).to_i
            stat.timestamp = new_date
            stat.ip = arr[2]
            stat.city = arr[4]
            stat.country = arr[3]
            stat.save!
        end
    end
end
