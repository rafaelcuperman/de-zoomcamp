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
