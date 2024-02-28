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


## DBT
To run a dbt model, simply type `dbt build`. This will run all the models. If we want to run just one particular model, then we need to type `dbt build --select model_name`, being `model_name` the model that we want to run.
If we write, instead `dbt build --select +model_name` (including the plus sign), it will run the model `model_name` and everything that `model_name` needs. This could be some other moder.s

"Functions" (actually called macros) are called with the double curly bracket syntaxis (`{{ }}`).
We can define new macros under the `macros` directory in a new .sql file.

Additionally, we can also use packages (which are prebuilt macros). To do so, we have to create a file called `packages.yml` in the root directory of the project and import the package. Then, we need to execute `dbt deps` to download the package and depedencies. This will create a folder with the name of the package under the directory `dbt_packages`. 

#### Variables
There are two ways to define a variable:
1. Global variables are defined under the project yml file
2. Variables defined in the terminal when the dbt model is run. The variable is set in the terminal by typing `dbt build --m <model.sql> --vars '{"variable": value}'`. This way the variable called `variable` will have value equal to `value` when the dbt model is run. It is important to use the double quotes for the variable and single quotes for the command itself.

To use a variable, we use the `{{ var('...') }}` function

#### Seeds
Seeds are like small csv files with data that will not change often.
After a csv file is created under the seeds directory, run `dbt seed`. With the flag `--full-refresh`, the table is updated as a replace and not as an append.

`dbt run` only runs models, but `dbt build` also runs seeds and tests

#### Tests
In DBT a test is essentially a `select` sql query that will return the amount of failing records.

The tests are defined on a column in the schema.yml file. 

To run the tests, type `dbt test`. 

#### Deployment
A development-deployment workflow will look like this:
1. Develop in a separate user branch
2. Open a Pull Request to merge into the main branch
3. Merge the branch to the main branch
4. Run the new models in the productio environment using the main branch
5. Schedule the models

By default a DBT project comes with a development environment that should be worked on a different Git branch than main. To create the depolyment strategy, we must first create a deployment environment in DBT. Usually this environment targets the main branch in Git, but, if needed, we can choose another branch.

