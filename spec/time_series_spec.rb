require './lib/time_series.rb'
require 'pry'

RSpec.describe TimeSeries do
  let(:client) { double('Mongo::Client') }
  let(:collection) { double('Mongo::Collection') }
  let(:time_series) { TimeSeries.new(client) }

  before do
    # Stub the collection
    allow(client).to receive(:[]).with(:itunes_sales_report_estimates).and_return(collection)
  end

  describe '#get_time_series' do
    it 'returns the correct array of revenue data within the date range' do
      start_date = Time.parse('2017-01-01 00:00:00 UTC')
      end_date = Time.parse('2017-01-03 00:00:00 UTC')
      app_id = 7118

      # Mock data from the collection
      mocked_data = [
        { 'ir' => 20170101 },
        { 'ir' => 20170102 },
        { 'ir' => 20170103 }
      ]

      # Stub the find method
      allow(collection).to receive(:find).with(
        { aid: app_id, d: { '$gte' => start_date, '$lte' => end_date } }
      ).and_return(mocked_data)

      # Call the method
      result = time_series.get_time_series(app_id, start_date, end_date)

      # Assert the result
      expect(result).to eq([20170101, 20170102, 20170103])

      # Verify the interaction with the collection
      expect(collection).to have_received(:find).with(
        { aid: app_id, d: { '$gte' => start_date, '$lte' => end_date } }
      )
    end

    it 'returns an empty array when no data matches the query' do
      start_date = Time.parse('2020-01-01 00:00:00 UTC')
      end_date = Time.parse('2020-01-03 00:00:00 UTC')
      app_id = 7118

      # Stub the find method to return an empty array
      allow(collection).to receive(:find).with(
        { aid: app_id, d: { '$gte' => start_date, '$lte' => end_date } }
      ).and_return([])

      # Call the method
      result = time_series.get_time_series(app_id, start_date, end_date)

      # Assert the result
      expect(result).to eq([])

      # Verify the interaction with the collection
      expect(collection).to have_received(:find).with(
        { aid: app_id, d: { '$gte' => start_date, '$lte' => end_date } }
      )
    end
  end
end
