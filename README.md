# Sensor Tower

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Run the application

Steps to run the project.

Pull the application code from the github repo:
```sh
git clone git@github.com
```

Install dependencies:
```sh
bundle install
```

Create .env file and set ENV vars e.g.:
```sh
MONGO_CLIENT_ADDRESS=127.0.0.1:27017
MONGO_DB_NAME=app_seo_development
```

In the root folder of an app run:
```sh
ruby lib/time_series.rb
```

In the command line you should see similar result:
```sh
20170101
20170102
20170103
```

## Running the tests

Testing is implemented using:

- rspec

To run the whole test suite

```sh
bundle exec rspec
```

# Recommendations for Improvement

1. Ensure the aid_1_d_1 index is created. Using the MongoDB Ruby Driver:
```sh
client = Mongo::Client.new([127.0.0.1:27017], database: app_seo_development)
collection = client[:itunes_sales_report_estimates]
collection.indexes.create_one({ aid: 1, d: 1 }, name: "aid_1_d_1", unique: true, background: true)
```
2. If other indexes are not used frequently, consider removing it to reduce maintenance overhead and storage costs.
3. If similar queries are run frequently, ensure they use the same index to avoid excessive plan generation overhead.
4. Modify the query to fetch only indexed fields (aid and d) when possible. This eliminates the need for the FETCH stage, further reducing execution time.

## Rejected ideas

1. Using an in-memory array to filter data. This approach would be slower and inefficient for large datasets.
2. Processing dates after fetching all documents without a query filter.

## Authors

- **Vitalijus Desukas** - [Vitalijus](https://github.com/Vitalijus)
