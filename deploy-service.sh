gcloud auth configure-docker
docker-compose build
docker-compose push

cd Infrastructure
terraform init
terraform apply -auto-approve