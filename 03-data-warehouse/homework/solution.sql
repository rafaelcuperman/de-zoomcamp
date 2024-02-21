# Create external table
CREATE OR REPLACE EXTERNAL TABLE de-zoomcamp-rc.homework_3.green_taxi_ny_2022
OPTIONS (
  format = 'parquet',
  uris = ['gs://de-zoomcamp-rc-homework-3/green-taxi-data-2022.parquet']
)

# Question 1: What is count of records for the 2022 Green Taxi Data??
SELECT
  count(*)
FROM
  `homework_3.green_taxi_ny_2022`
# Answer: 840402

#Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
#What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
SELECT
  count(distinct(PULocationID))
FROM
  `homework_3.green_taxi_ny_2022_materialized`
# Answer: 0B for the external table and 6.41MB for the materialized table

# Question 3: How many records have a fare_amount of 0?
SELECT
  count(*)
FROM
  `homework_3.green_taxi_ny_2022`
WHERE
  fare_amount = 0
# Answer: 1622

# Question 4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
CREATE OR REPLACE TABLE de-zoomcamp-rc.homework_3.green_taxi_ny_2022_partitioned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `homework_3.green_taxi_ny_2022`;
# Answer: Partition by lpep_pickup_datetime Cluster on PUlocationID

# Question 5: Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
#Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are these values?
SELECT
  distinct(PULocationID)
FROM
  #`homework_3.green_taxi_ny_2022_materialized`
  `homework_3.green_taxi_ny_2022_partitioned_clustered`
WHERE
  date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30'
# Answer: 12.82 MB for non-partitioned table and 1.12 MB for the partitioned table

# Question 6: Where is the data stored in the External Table you created?
# Answer: GCP Bucket

# Question 7: It is best practice in Big Query to always cluster your data:
# Answer: False
