require 'mongo'
require 'time'

# Establish MongoDB connection
client = Mongo::Client.new(['127.0.0.1:27017'], database: 'your_database_name')

# Define the collection
collection = client[:itunes_app_sales_report_estimates]

# Function to get time series data
def get_time_series(app_id, start_date, end_date)
  # Query the MongoDB collection
  result = collection.find(
    {
      app_id: app_id,
      date: { '$gte' => start_date.to_i, '$lte' => end_date.to_i }
    },
    projection: { _id: 0, date: 1 }
  ).sort(date: 1).map { |doc| doc['date'] }

  result
end

# Example usage
start_date = Time.parse('2017-01-01')
end_date = Time.parse('2017-01-03')
app_id = 7118

puts get_time_series(app_id, start_date, end_date)
