# Dockerfile for building Ansible image for Ubuntu 18.04 (Bionic), with as few additional software as possible.
#
# @see https://launchpad.net/~ansible/+archive/ubuntu/ansible
#
# Version  1.0
#


# pull base image
FROM ubuntu:20.04

LABEL "maintainer"="liksi <ops@liksi.fr>"

ARG ANSIBLE_VERSION=3.0.0

RUN echo "===> Adding Ansible's PPA..."  && \
    apt-get update && \
    apt-get install --no-install-recommends -y python3-pip python3-dev sshpass openssh-client git curl jq build-essential && \
    pip3 install --upgrade ansible==${ANSIBLE_VERSION} && \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    pip3 install --upgrade pycrypto pywinrm && \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible && \
    touch /etc/ansible/hosts && \
    echo 'localhost' > /etc/ansible/hosts && \
    echo "===> Clean up..." && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]



