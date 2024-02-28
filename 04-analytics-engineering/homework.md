# Homework week 4. DBT

### Question 1

Q: What happens when we execute `dbt build --vars '{'is_test_run':'true'}`? \
A: It applies a limit 100 only to our staging models

### Question 2
Q: What is the code that our CI job will run? Where is this code coming from? \
A: The code from the development branch we are requesting to merge to main

### Question 3
Q: What is the count of records in the model fact_fhv_trips after running all dependencies with the test run variable disabled (:false)?\
To solve this question, we must first do the following:\
Create a staging model for the fhv data, similar to the ones made for yellow and green data. Add an additional filter for keeping only records with pickup time in year 2019. Do not add a deduplication step. Run this models without limits (is_test_run: false).\
Create a core model similar to fact trips, but selecting from stg_fhv_tripdata and joining with dim_zones. Similar to what we've done in fact_trips, keep only records with known pickup and dropoff locations entries for pickup and dropoff locations. Run the dbt model without limits (is_test_run: false).

To do so, the `schema.yml` file was modified to include the new table. Then, the file `stg_fhv_data.sql` was created with the staging model for that table. And finally, the model `fhv_trips.sql` was created in the core directory.

Finally, the core model was run by typing `dbt build --select +fhv_trips --vars '{"is_test_run": false}'` so that the limit is not included in the model. The final table will be created and we can query that table to answer the question.\
A: 22998722

### Question 4
Q: What is the service that had the most rides during the month of July 2019 month with the biggest amount of rides after building a tile for the fact_fhv_trips table and the fact_trips tile as seen in the videos?\
A: Yellow