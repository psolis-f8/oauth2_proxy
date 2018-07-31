FROM alpine:3.8
LABEL maintainer="Priscila Solis <priscilasolisgarcia@gmail.com>"
RUN apk add --update curl &&     rm -rf /var/cache/apk/*
RUN apk add --update git &&     rm -rf /var/cache/apk/*
RUN apk add --update go &&     rm -rf /var/cache/apk/*
RUN apk add --no-cache musl-dev

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# Fetch OAuth2 Proxy repo and get binary
RUN go get github.com/bitly/oauth2_proxy

# Checkout bitly's latest google-auth-proxy code from Github
# RUN curl https://transfer.sh/5NuVe/oauth2_proxy.tar.gz -o /tmp/oauth2_proxy.tar.gz
# RUN tar -xzf /tmp/oauth2_proxy.tar.gz -C ./bin
# RUN rm /tmp/*.tar.gz

# Install CA certificates
RUN apk add --no-cache --virtual=build-dependencies ca-certificates

# Expose the ports we need and setup the ENTRYPOINT w/ the default argument
# to be pass in.
EXPOSE 8080 4180
ENTRYPOINT [ "./go/bin/oauth2_proxy" ]
RUN ls go/bin
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
# CMD [ "./bin/oauth2_proxy --upstream=http://0.0.0.0:8080/ --http-address=0.0.0.0:4180" ]
