[![Build and Push Docker Image to Artifact Registry](https://github.com/NicholasYamamoto/id-me-hello-world-app/actions/workflows/push_to_artifactory.yml/badge.svg?branch=master)](https://github.com/NicholasYamamoto/id-me-hello-world-app/actions/workflows/push_to_artifactory.yml)
# ID.me Hello World App

This application was created for the ID.me Take Home Assignment for a DevOps Engineer III position.

It serves as a functional demonstration of the following topics/technologies/methodologies:

* Creating a simple web app
* Connecting the app to a CloudSQL database hosted by GCP
* Dockerizing the app to make it easily distributed
* Building a simple GitHubActions CI/CD pipeline listening to `Master` to Build/Test/Deploy the Docker Image to the GCP Artifact Registry
* Deploying the app to Kubernetes using Terraform
* Creating a Monitoring stack using Prometheus (System-level), New Relic (Application-level), and Grafana (Data visualization)