require 'mongo'
require 'time'
require 'pry'

class TimeSeries
  def initialize(client)
    @collection = client[:itunes_sales_report_estimates]
  end

  # Function to get time series data
  def get_time_series(app_id, start_date, end_date)
    result = @collection.find(
      {
        aid: app_id,
        d: { '$gte' => start_date, '$lte' => end_date }
      }
    ).map{|doc| doc['ir']}

    result
  end

end

# Establish MongoDB connection
client = Mongo::Client.new(['127.0.0.1:27017'], database: 'app_seo_development')

ts = TimeSeries.new(client)

start_date = Time.parse('2017-01-01 00:00:00 UTC')
end_date = Time.parse('2017-01-03 00:00:00 UTC')
app_id = 7118

puts ts.get_time_series(app_id, start_date, end_date)
