FROM node:8.10-alpine

RUN apk add --update 

# Basic tools
RUN apk add \
  git \
  openssh \
  openssl

# Python
RUN apk add \
  python \
  python-dev \
  py-pip \
  build-base

# AWScli
RUN pip install --upgrade awscli

# Terraform
RUN wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip -O /tmp/terraform.zip && \
  unzip -d /usr/local/bin/ /tmp/terraform.zip

# Parallel
RUN apk add parallel

CMD ["/bin/bash"]
