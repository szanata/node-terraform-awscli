FROM node:12.18.2-alpine

RUN apk add --update

# Basic tools
RUN apk add \
  git \
  openssh \
  make \
  musl-dev \
  openssl \
  bash

# Python
RUN apk --update add \
  python \
  python-dev \
  py-pip \
  build-base

# Parallel
RUN apk add parallel

# Terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip -O /tmp/terraform.zip && \
  unzip -d /usr/local/bin/ /tmp/terraform.zip

# aws cli 2
# https://stackoverflow.com/a/61268529/486387
ENV GLIBC_VER=2.31-r0

RUN apk --no-cache add \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
        curl \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

RUN aws --version

CMD ["/bin/sh"]
