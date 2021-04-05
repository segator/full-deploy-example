# Backend Service

![GitHub Workflow Status (branch)](https://img.shields.io/github/workflow/status/segator/full-deploy-example/backend/master)
![Docker Pulls](https://img.shields.io/docker/pulls/segator/helloworld)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/segator/helloworld)

This application have a simple endpoint ```/helloworld``` that returns ```{ "hello": "world" }```

It supports standards healthchecks for kubernetes
with ```/healthz``` and ```/readyz```




## Development prerequisites

**1. Linux** 
**2. Golang** *click here for* [install](https://golang.org/doc/install) *instructions*

**3. Docker** *click here for* [install](https://docs.docker.com/get-docker/) *instructions*

**4. make** *linux package*

## Build
You can build it as a singleton application or container
### Singleton
```
make build
```
### Container
```
make container
```

## Test
Execute automated tests
```
make test
```

## Run
You can run the application locally via
```
make run
```
or via docker
```
docker run -d --name helloworld -p 8000:8000 segator/helloworld
```

## Publish image
We can push a generated docker image with
```
make publish IMAGE_PATH=segator REGISTRY=registry.hub.docker.com
```
**remember to configure your docker registry before pushing**

## Configure
We can be configure the listen port using env var ```HELLO_LISTEN_PORT``` *(default 8000)*


## Continuous Integration
a public image is generated every time a commit on branch master happens using github actions.

In case you want to  fork the project, remember
to add the next variables on your github workflows.
```
DOCKERHUB_USERNAME=<docker hub user>
DOCKERHUB_TOKEN<docker hub password or token>
```

you can see the pipeline definition in the file ```.github/workflows/backend.yml```