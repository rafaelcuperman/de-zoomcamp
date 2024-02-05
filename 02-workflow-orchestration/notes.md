# Mage - Workflow orchestration
To update Mage, type `docker pull mageai/mageai:latest`

### Build the container
`docker compose build`

### Start docker container
`docker compose -it up`

Then, go to http://localhost:6789 to open Mage

### Environment variables
In docker-compose.yml there are many environment variables with the syntax `${ENVIRONMENT_VARIABLE}`. These environment variables are in the `.env` file defined with the syntax `ENVIRONMENT_VARIABLE=value`.

We can include those environment variables on Mage's yml file by doing `"{{ env_var('POSTGRES_DBNAME') }}"`.
