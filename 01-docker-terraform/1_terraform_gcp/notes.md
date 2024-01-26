https://medium.com/google-cloud/how-to-use-multiple-accounts-with-gcloud-848fdb53a39a

### Refresh service-account's auth-token for this session
gcloud auth application-default login

### Create new gcloud configuration
gcloud init

### Show gcloud configurations
gcloud config configurations list

### Activate gcloud configuration
gcloud config configurations activate [configuration_name]

### Format .tf file
terraform fmt

### Get terraform provider
terraform init

### Get terraform plan of what will be
terraform plan

### Activate terraform plan
terraform apply

### Turn off the resources (de-activate terraform plan)
terraform destroy