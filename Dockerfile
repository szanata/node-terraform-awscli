FROM node:10.16-alpine

# Basic tools
RUN apk --update add \
  git \
  openssh \
  openssl

# Python
RUN apk --update add \
  python \
  python-dev \
  py-pip \
  build-base

# Upgrade pip
RUN pip install --upgrade pip

# AWScli
RUN pip install --upgrade awscli

# Terraform
RUN wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip -O /tmp/terraform.zip && \
  unzip -d /usr/local/bin/ /tmp/terraform.zip

# Parallel
RUN apk add parallel

RUN aws --version

CMD ["/bin/sh"]
