FROM golang:1.12.9

RUN apt-get update && \
    apt-get -y install git unzip build-essential autoconf libtool
RUN git clone https://github.com/google/protobuf.git pb && \
    cd pb && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig && \   
    make clean && \
    cd .. && \
    rm -r pb

# NOTE: for now, this docker image always builds the current HEAD version of
# gRPC.  After gRPC's beta release, the Dockerfile versions will be updated to
# build a specific version.

ENV GOPATH /go

# gRPC libraries
RUN go get google.golang.org/grpc
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN go get -u github.com/mwitkow/go-proto-validators

