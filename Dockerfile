FROM alpine:3.8
LABEL maintainer="Priscila Solis <priscilasolisgarcia@gmail.com>"
RUN apk add --update curl &&     rm -rf /var/cache/apk/*


# Checkout bitly's latest google-auth-proxy code from Github
RUN curl https://transfer.sh/SfRAW/oauth2_proxy.tar.gz -o /tmp/oauth2_proxy.tar.gz
RUN tar -xzf /tmp/oauth2_proxy.tar.gz -C ./bin
RUN rm /tmp/*.tar.gz

# Install CA certificates
RUN apk add --no-cache --virtual=build-dependencies ca-certificates

# Expose the ports we need and setup the ENTRYPOINT w/ the default argument
# to be pass in.
EXPOSE 8080 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
RUN ls
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
