CREATE TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019` 

CREATE TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019` 

INSERT INTO `de-zoomcamp-rc.nyc_tlc.green_tripdata` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020` 

INSERT INTO `de-zoomcamp-rc.nyc_tlc.yellow_tripdata` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020` 

CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-rc.nyc_tlc.fhv_tripdata` 
OPTIONS (
  format = 'parquet',
  uris = ['gs://nyc-tlc/fhv/fhv_tripdata_2019-*.parquet']
)

-- Fixes yellow table schema
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.yellow_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

-- Fixes green table schema
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `de-zoomcamp-rc.nyc_tlc.green_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;