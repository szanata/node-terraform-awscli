FROM node:8.10-alpine

RUN apk add --update 

RUN apk add \
  git \
  openssh

RUN apk add \
  python \
  python-dev \
  py-pip \
  build-base

RUN pip install --upgrade awscli

RUN apk add \
  openssl

RUN wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip -O /tmp/terraform.zip && \
  unzip -d /usr/local/bin/ /tmp/terraform.zip

CMD ["/bin/bash"]
