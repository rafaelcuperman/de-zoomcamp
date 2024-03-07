# Week 5. Batch. Spark
The first thing to do is install Spark and Pyspark. To do so, follow the instructions under the folder [setup](setup/) to install Spark in the selected operating system (MacOS, Windows, or Linux). Then use [pyspark.md](setup/pyspark.md) to configure pyspark.

To import Pyspark and initialize the Spark Session, use the following commands:
``` python
import pyspark
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .master("local[*]") \
    .appName("test") \
    .getOrCreate()
```

The GUI for the master node can be found in [localhost:4040](localhost:4040). Here we can see the jobs that are being executed.

Common commands in Spark:
* Read parquet file: `spark.read.parquet()`
* Show contents of dataframe: `df.show()` 
* Show schema of dataframe (column names and types): `df.printSchema()`
* Rename column: `df.withColumnRenamed(old_column_name, new_column_name)`
* Select subset list of columns in dataframe: `df.select(list_of_columns)`
* Add new column with constant values: `df.withColumn(column_name, pyspark.sql.functions.lit(value))`
* Union of two dataframes: `df_1.unionAll(df_2)`
* Groupby: `df.groupBy()` 
* Create table from dataframe (to then use spark sql): `df.registerTempTable(table_name)`
* SQL query: `spark.sql(query)`
* Partition dataframe: `df.partition(num_partitions)`
* Reduce number of partitions of dataframe: `df.coalesce(num_partitions)`
* Write parquet file: `df.write.parquet()`

## Running Spark in the Cloud

### Connecting to Google Cloud Storage 

Uploading data to GCS:

```bash
gsutil -m cp -r pq/ gs://nyc-tlc/pq
```

Download the jar for connecting to GCS to any location (e.g. the `lib` folder):

```bash
gsutil cp gs://hadoop-lib/gcs/gcs-connector-hadoop3-2.2.5.jar
```

See the notebook with configuration in [09_spark_gcs.ipynb](09_spark_gcs.ipynb)

(Thanks Alvin Do for the instructions!)


### Local Cluster and Spark-Submit

Creating a stand-alone cluster ([docs](https://spark.apache.org/docs/latest/spark-standalone.html)):
This should be done in the spark directory (where it was installed. We can type `echo $SPARK_HOME` to check the path).
```bash
./sbin/start-master.sh
```

To stop the stand-alone cluster:
```bash
./sbin/stop-master.sh
```

This will create Spark master and we can access it in `localhost:8080`. If we go there, we will find the name of the cluster under the URL item (it will look something like `spark://...`). We can use this name when building the SparkSession by giving that name to `.master()` instead of `"local[*]"` under `SparkSession.builder`

Creating a worker:

```bash
URL="spark://MBP-de-Rafael:7077"
./sbin/start-slave.sh ${URL}

# for newer versions of spark use that:
#./sbin/start-worker.sh ${URL}
```

Stopping a worker:
```bash
./sbin/stop-slave.sh

# for newer versions of spark use that:
#./sbin/stop-worker.sh
```

Turn the notebook into a script:

```bash
jupyter nbconvert --to=script 06_spark_sql.ipynb
```

Edit the script and then run it:

```bash 
python 06_spark_sql.py \
    --input_green=data/pq/green/2020/*/ \
    --input_yellow=data/pq/yellow/2020/*/ \
    --output=data/report-2020
```

Use `spark-submit` for running the script on the cluster

```bash
URL="spark://MBP-de-Rafael:7077"

spark-submit \
    --master="${URL}" \
    06_spark_sql.py \
        --input_green=data/pq/green/2021/*/ \
        --input_yellow=data/pq/yellow/2021/*/ \
        --output=data/report-2021
```

### Data Proc
This is used to create a Spark cluster in GCP.\
The first thing to do is look for Dataproc in GCP and create the cluster. This will create a cluster and also a Virtual Machine (under Compute Engine) for the cluster.

Then we can go in the cluster and "Submit Job". In the Job Type we select Pyspark and sekect the python file that will run the job. This python file can be in a GCS Bucket. For this file, it is important to note that, under `SparkSession.builder`, we should not specify `.master()`, because when we submit the job via Data Proc we want it to use the configuration we give to Data Procs to master.

Upload the script to GCS:

```bash
gsutil cp 06_spark_sql.py gs://nyc-tlc/code/06_spark_sql.py 
```

Params (arguments) for the job. They can be specified when creating the job:

* `--input_green=gs://nyc-tlc/pq/green/2021/*/`
* `--input_yellow=gs://nyc-tlc/pq/yellow/2021/*/`
* `--output=gs://nyc-tlc/report-2021`

Then, when we submit the job, it will run the script as defined in Data Procs.

However, there is another way of doing that without using the GCP GUI. We can use the GC SDK to submit the job to Data Proc.
In the GUI, in the Job under Configuration, we can click on the bottom part on "Equivalent Rest". There we can get the info that we need for the following part:

Using Google Cloud SDK for submitting to dataproc
([link](https://cloud.google.com/dataproc/docs/guides/submit-job#dataproc-submit-job-gcloud))

We first need to add Dataproc Admin role in IAM & Admin in our service account, so that the service account has permission to execute Dataproc.

Then run the following in the command line
```bash
gcloud dataproc jobs submit pyspark \
    --cluster=de-zoomcamp-cluster \
    --region=us-east1 \
    gs://nyc-tlc/code/06_spark_sql.py \
    -- \
        --input_green="gs://nyc-tlc/pq/green/2020/*/" \
        --input_yellow="gs://nyc-tlc/pq/yellow/2020/*/" \
        --output="gs://nyc-tlc/report-2020"
```

NOTE: When using zsh and not bash, it is important to use quotes when the arguments have wildcards (such as *)

### Big Query
It is also possible to execute PySpark to save the results directly in BigQuery

Upload the script to GCS:

```bash
gsutil cp 06_spark_sql_big_query.py gs://nyc-tlc/code/06_spark_sql_big_query.py 
```

The only thing that we need to change is in the write command at the end:
```python
df_result.write.format('bigquery') \
    .option('table', output) \
    .save()
```
Where `output` is where the table will be written in BQ.

Write results to big query ([docs](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example#pyspark)):

```bash
gcloud dataproc jobs submit pyspark \
    --cluster=de-zoomcamp-cluster \
    --region=us-east1 \
    --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
    gs://nyc-tlc/code/06_spark_sql_big_query.py \
    -- \
        --input_green="gs://nyc-tlc/pq/green/2020/*/" \
        --input_yellow="gs://nyc-tlc/pq/yellow/2020/*/" \
        --output="nyc_tlc.reports-2020"
```
NOTE: When using zsh and not bash, it is important to use quotes when the arguments have wildcards (such as *)

When this is executed, the table with the results will be created in BQ