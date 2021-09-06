FROM golang:latest
WORKDIR /go/src/github.com/xulei1931/syudy_ci
ADD . /go/src/github.com/xulei1931/syudy_ci
RUN go env -w GOPROXY=https://goproxy.cn,direct

ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
#RUN  go build -o user
# RUN apk add --no-cache gcc musl-dev git && go build -I -v
RUN CGO_ENABLED=0 GOOS=linux go build -o main -a -tags netgo -ldflags '-s -w' .
EXPOSE 9090
ENTRYPOINT ./main 
#/go/src/syudy_ci/Dockerfile