FROM gliderlabs/alpine:latest
MAINTAINER ntk1000

# docker:latest based on alpinelinux

# install awscli
RUN apk add --no-cache python \
	py-pip && \
	pip install awscli

# install terraform
ENV TERRA_VERSION=0.6.14
ENV TERRA_SHA256=6d93290f980df15a453e907ea9a2ca8f8fed41143c220953c911b5174c3e3ab0

ADD https://releases.hashicorp.com/terraform/${TERRA_VERSION}/terraform_${TERRA_VERSION}_linux_amd64.zip /tmp/terraform.zip

RUN echo "${TERRA_SHA256} /tmp/terraform.zip" > /tmp/terraform.sha256 \
#	&& sha256sum -c /tmp/terraform.sha256 \
	&& cd /bin \
	&& unzip /tmp/terraform.zip \
	&& chmod +x /bin/terraform \
	&& rm /tmp/terraform.zip

# install fleet
ENV FLEET_VERSION=0.11.5

ADD https://github.com/coreos/fleet/releases/download/v${FLEET_VERSION}/fleet-v${FLEET_VERSION}-linux-amd64.tar.gz /tmp/fleet.tar.gz

RUN cd /bin \
	&& tar zxvf /tmp/fleet.tar.gz \
	&& mv ./fleet-v${FLEET_VERSION}-linux-amd64/* ./ \
	&& chmod +x /bin/fleetctl \
	&& rm /tmp/fleet.tar.gz \
	&& rm -rf ./fleet-v${FLEET_VERSION}-linux-amd64

