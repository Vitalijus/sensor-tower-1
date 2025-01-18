require 'mongo'
require 'dotenv/load'
require 'time'

class TimeSeries
  def initialize(client)
    @collection = client[:itunes_sales_report_estimates]
  end

  # Function to get time series data
  def get_time_series(app_id, start_date, end_date)

    # Start benchmarking
    start_time = Time.now

    result = @collection.find(
      {
        aid: app_id,
        d: { '$gte' => start_date, '$lte' => end_date }
      }
    ).map{|doc| doc['ir']}

    # End benchmarking
    end_time = Time.now
    puts "Query executed in #{(end_time - start_time).round(3)} seconds."

    result
  end
end

# Establish MongoDB connection
client = Mongo::Client.new([ENV['MONGO_CLIENT_ADDRESS']], database: ENV['MONGO_DB_NAME'])

ts = TimeSeries.new(client)

start_date = Time.parse('2017-01-01 00:00:00 UTC')
end_date = Time.parse('2017-01-03 00:00:00 UTC')
app_id = 7118

puts ts.get_time_series(app_id, start_date, end_date)
