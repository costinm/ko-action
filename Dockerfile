FROM golang:latest AS build
WORKDIR /ws
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOPROXY=https://proxy.golang.org

RUN go mod init tmp; GOFLAGS= go get github.com/google/ko@v0.8.3

FROM golang:latest AS ko

COPY --from=build /go/bin/ko /usr/local/bin/ko

ENV KO_DATA_PATH=/var/run/ko
WORKDIR /
ENTRYPOINT ["/usr/local/bin/ko", "publish", "-B"]

