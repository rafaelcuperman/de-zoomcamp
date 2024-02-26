# Week 4. Analytics Engineering. DBT

## Pre requisites
The following are needed:
1. A running warehouse. BigQuery in this case
2. The following [datasets](https://github.com/DataTalksClub/nyc-tlc-data/) already injested into BQ
    * Yellow taxi data - Years 2019 and 2020
    * Green taxi data - Years 2019 and 2020
    * fhv data - Year 2019

To do so, I will first use Terraform to create the bucket and the bigquery dataset

### Terraform (create the GCS bucket and BQ dataset)
To create the bucket in GCS and dataset in BQ with Terraform, type
`terraform init`
`terraform apply`
This will create the GCS bucket and BQ dataset via Terraform.
After finished, the bucket and dataset can be destroyed by typing
`terraform destroy` 

### Load datasets to BQ
The file `load_datasets.ipynb` can be used to load the datasets into GCP. However, this will only be used to load the FHV 2019 data to GCS and then BQ using an external table.

The Yellow and Green taxi data files are too big (specially Yellow), so it was taking too long to upload it via python. So, instead, I will follow the hack presented [here](https://www.youtube.com/watch?v=Mork172sK_c&t=22s&ab_channel=Victoria). The SQL statements to do so can be found in the file `create_taxi_data_bq.sql`. The last part of that file consists of the creation of the external table for the FHV 2019 data. 
