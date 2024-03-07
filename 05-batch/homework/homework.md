# Homework week 5. Spark

## Question 1
- Install Spark
- Run PySpark
- Create a local spark session
- Execute spark.version.

What's the output?

A: '3.5.1'

## Question 2
Read the October 2019 FHV into a Spark Dataframe with a schema as we did in the lessons.

Repartition the Dataframe to 6 partitions and save it to parquet.

What is the average size of the Parquet (ending with .parquet extension) Files that were created (in MB)? Select the answer which most closely matches.

A: 6MB

## Question 3
How many taxi trips were there on the 15th of October?

Consider only trips that started on the 15th of October.

A: 62610

## Question 4

What is the length of the longest trip in the dataset in hours?

A: 631152

## Question 5
Spark’s User Interface which shows the application's dashboard runs on which local port?

A: 4040

## Question 6

Load the zone lookup data into a temp view in Spark</br>
[Zone Data](https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv)

Using the zone lookup data and the FHV October 2019 data, what is the name of the LEAST frequent pickup location Zone?

A: Jamaica Bay

