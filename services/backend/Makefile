APP?=helloworld
REGISTRY?=registry.hub.docker.com
IMAGE_PATH?=segator
PORT?=8000

clean:
	echo "cleansing..."
	rm -f ${APP}

test: clean
	echo "testing..."
	go test -v -race ./...

build: test
	echo "building..."
	CGO_ENABLED=0 go build -ldflags '-w' -o ${APP}

container: build
	echo "building container..."
	docker build --build-arg APP_NAME="${APP}" -t $(APP) .

run: build
	echo "running application..."
	HELLO_LISTEN_PORT=${PORT} ./${APP}

publish: container
	echo "publishing..."
	docker login "${REGISTRY}"
	docker tag $(APP) ${REGISTRY}/${IMAGE_PATH}/$(APP)
	docker push  ${REGISTRY}/${IMAGE_PATH}/$(APP)


