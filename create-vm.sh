#!/bin/bash
source .env

gcloud compute instances create $VM_NAME \
  --project=$PROJECT_ID \
  --zone=$REGION-b \
  --machine-type=e2-medium \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --boot-disk-size=30GB \
  --boot-disk-type=pd-standard \
  --tags=http-server,https-server \
  --address=$STATIC_IP \
  --network=$VPC_NAME \
  --metadata=startup-script='#!/bin/bash
sudo apt update && sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER
'

echo "Waiting 10s for VM boot..."
sleep 10

gcloud compute ssh $VM_NAME --zone=$REGION-b
