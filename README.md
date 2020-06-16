# Simple Hello World by Spring on GKE

Hello World App by Spring Boot deployed to GKE with Cloud Build

## Description

This project describes how to deploy Spring App to GKE using CI/CD pipeline by Cloud Build.

- [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/docs)
- [Cloud Build](https://cloud.google.com/cloud-build/docs)

## Demo
### 1. Build Container Image

#### Multi-Stage Build
- [Dockerfile](spring/Dockerfile)

```dockerfile
FROM gradle:6.5.0-jdk11 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle assemble --no-daemon

FROM openjdk:11.0.5-jre-slim-buster
COPY --from=build /home/gradle/src/build/libs/*.jar /app.jar
:
:
```

### 2. Containerize with Cloud Build
**hello-gke** is app-name and repository-name.

- [Script](script/cloud-build.fish)

#### Get your Google Cloud project ID

```shell script
$ gcloud config get-value project
```

#### Build your container image using Cloud Build

```shell script
$ gcloud builds submit --tag gcr.io/<GOOGLE_PROJECT_ID>/hello-gke <DOCKERFILE_DIRECTORY>
```

### 3. Create GKE Cluster

#### Create GKE Cluster as Cloud Platform Scope
```shell script
$   gcloud container clusters create <GKE_CLUSTER_NAME> \
    --num-nodes 1 \
    --scopes cloud-platform \
    --enable-stackdriver-kubernetes \
    --enable-ip-alias \
    --zone us-central1-c
```

- [OAuth 2.0 Scopes](https://developers.google.com/identity/protocols/oauth2/scopes?_ga=2.239518464.2020385847.1592291923-533680975.1592291923)

#### Generate `kubeconfig` entry

```shell script
$ gcloud container clusters get-credentials <CLUSTER_NAME>
```


## Features

- feature:1
- feature:2

## Requirement

## Usage

## Installation

## Licence

Released under the [MIT license](https://gist.githubusercontent.com/shinyay/56e54ee4c0e22db8211e05e70a63247e/raw/34c6fdd50d54aa8e23560c296424aeb61599aa71/LICENSE)

## Author

[shinyay](https://github.com/shinyay)
