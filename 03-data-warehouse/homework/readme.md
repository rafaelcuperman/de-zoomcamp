# Homework solution
The homework consists of uploading a dataset to a bucket in Google Cloud Storage, creating tables in Google Bigquery based on that dataset, and then computing some queries in BigQuery.

To do so, the first thing to do is to upload the dataset to Google Cloud Storage. This can be easily done manually, but to make it more programatically, I will use Terraform to create the bucket and then upload the dataset to the bucket using Mage.

### Terraform (create the GCS bucket)
To create the bucket in GCS with Terraform, type
`terraform init`
`terraform apply`
This will create the GCS bucket via Terraform.
After finished, the bucket can be destroyed by typing
`terraform destroy` 

### Mage (upload dataset to GCS bucket)

After the bucket is created, Mage can be started by typing
`docker compose build` 
`docker compose up -d`
Then, Mage can be accessed in `localhost:6789`
The GCP credentials were mounted in Mage (as defined in the docker-compose.yml file), so they now appear in Mage in the directory `/home/src/creds.json`. So, to use those credentials in Mage, it is needed to set 
`GOOGLE_SERVICE_ACC_KEY_FILEPATH: "/home/src/creds.json"` in the file `io_config.yaml`.

Then, we can use the pipeline called `homework-3` to upload the parquet file into GCP. 

### Queries and questions
The queries to solve the questions and problems of the homework are in the file `solution.sql`