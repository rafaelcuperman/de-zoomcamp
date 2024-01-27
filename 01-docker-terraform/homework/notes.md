### Docker
1. Build docker container: `docker build -t homework:v001 .`
2. Run docker container:  `docker run -it homework:v001`

### Postgres
1. Run postgres container
```
docker run -it \                                                                                        
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v  $(pwd)/taxi_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13
```

2. Populate dataset with `ingest_data.ipynb`
3. Run postgres and pgadmin with `docker-compose up`. This runs `docker-compose.yml`
4. Pgadmin will be available at localhost:8080
5. Deactivate postgres and pgadmin with `docker-compose down`

### Terraform
Prerequisite: get service account key
1. Create `main.tf`, which has the instructions for terraform and `variables.tf`, which has the variables connected to `main.tf`.
2. (Optional) Format files with `terraform fmt`
3. Initialize and get terraform provider with `terraform init`
4. Check terraform plan (what will be built) with `terraform plan`
5. Activate terraform plan with `terraform apply`
6. Turn off resources (deactivate terraform plan) with `terraform destroy`
