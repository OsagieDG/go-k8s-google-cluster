PROJECT_ID = sample-cluster-403202
CLUSTER_NAME = go-k8s-google-cluster
LOCATION = europe-west2
IMAGE_NAME = europe-west2-docker.pkg.dev/$(PROJECT_ID)/intro-repo/go-k8s-google-cluster
DEPLOYMENT_FILE := deployment.yaml
SERVICE_FILE := service.yaml

.PHONY: create-cluster delete-cluster create-image build-image delete-image

create-cluster:
	gcloud container clusters create-auto $(CLUSTER_NAME) --location $(LOCATION)

delete-cluster:
	gcloud container clusters delete $(CLUSTER_NAME) --location $(LOCATION)

create-image:
	gcloud artifacts repositories create intro-repo --project=$(PROJECT_ID) --repository-format=docker --location=$(LOCATION) --description="Docker repository"

build-image:
	gcloud builds submit --tag $(IMAGE_NAME) . 

delete-image:
	gcloud artifacts docker images delete $(IMAGE_NAME)

apply:
	kubectl apply -f $(DEPLOYMENT_FILE)
	kubectl apply -f $(SERVICE_FILE)


# Fetching deployment, pods, and services
get-deployments:
	kubectl get deployments

get-pods:
	kubectl get pods

get-services:
	kubectl get services

# Combining all get commands
get: get-deployments get-pods get-services

