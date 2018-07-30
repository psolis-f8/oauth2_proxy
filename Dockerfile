FROM alpine:3.8
LABEL maintainer="Priscila Solis <priscilasolisgarcia@gmail.com>"

# When this Dockerfile was last refreshed (year/month/day)
ENV REFRESHED_AT 2018-07-30
ENV OAUTH2_PROXY_VERSION 2.2.1

# Checkout bitly's latest google-auth-proxy code from Github
RUN curl https://transfer.sh/b3NAb/oauth2-proxy.tar.gz -o tmp/oauth2-proxy.tar.gz 
RUN tar -xf /tmp/oauth2-proxy.tar.gz -C ./bin --strip-components=1 && rm /tmp/*.tar.gz

# Install CA certificates
RUN apk add --no-cache --virtual=build-dependencies ca-certificates

# Expose the ports we need and setup the ENTRYPOINT w/ the default argument
# to be pass in.
EXPOSE 8080 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
