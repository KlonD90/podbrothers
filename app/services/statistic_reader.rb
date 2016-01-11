class StatisticReader
    def self.read
        list = $redis.get("file_log")
    end
end