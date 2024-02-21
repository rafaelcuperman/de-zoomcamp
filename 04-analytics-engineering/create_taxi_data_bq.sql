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
