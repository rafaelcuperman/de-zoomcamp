# Mage - Workflow orchestration
To update Mage, type `docker pull mageai/mageai:latest`

### Build the container
`docker compose build`

### Start docker container
`docker compose up`

Then, go to http://localhost:6789 to open Mage

### Environment variables
In docker-compose.yml there are many environment variables with the syntax `${ENVIRONMENT_VARIABLE}`. These environment variables are in the `.env` file defined with the syntax `ENVIRONMENT_VARIABLE=value`.

We can include those environment variables on Mage's yml file by doing `"{{ env_var('POSTGRES_DBNAME') }}"`.

### Mount files into Mage
All the files in the current directory will be mounted to the Mage instance in the path defined in the `volumes` parameter in the `docker-compose.yml` file:

```
volumes:
    - .:/home/src/
```
In this case, all the files will be mounted in the directory `/home/src/`

### GCP credentials
The credentials should be specified in the io_config.yaml file in the variable `GOOGLE_SERVICE_ACC_KEY_FILEPATH: "file.json"`. The json file will be located in `/home/src/`, as it was mounted in that directory.

### Schedule workflows
To schedule workflow in Mage, go to Triggers on the left menu and create a trigger.

### Editing blocks
In Mage, if a block is edited in a pipeline, that block is edited everywhere it is used. It can be re-used in several pipelines, so modifying a block in a pipeline will modify that same block in the rest of the pipelines that the block is used.

### Parameters
Parameters can be added in the code using the kwargs argument or even as runtime variables in the triggers.
For example, the execution date of the pipeline can be accessed with `kwargs.get('execution_date')`.

### Backfills
Can be used to reconstruct lost data. To create backfill functionality. This can be done with the Backfill menu on the left tab of a pipeline.

### Homework 
The homework pipeline can be found in the pipeline called "Homework"