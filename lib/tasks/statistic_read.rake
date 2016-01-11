desc 'statistic read'
task statistic_read: :environment do
    StatisticReader.read
end    
