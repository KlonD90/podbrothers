class StatisticReader
    def self.read
        while !(element = $redis.lpop("file_log")).nil? do
            puts element
        end
    end
end
