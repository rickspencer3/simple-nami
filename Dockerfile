## BUILDING
##   (from project root directory)
##   $ docker build -t node-js-6-2-2-on-debian .
##
## RUNNING
##   $ docker run -p 3000:3000 node-js-6-2-2-on-debian
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/debian-buildpack:wheezy-r07

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="kw2g147" \
    STACKSMITH_STACK_NAME="Node.js 6.2.2 on Debian" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install node-6.2.2-0 --checksum 6316e916fe82832aeee6137ea9b7b9d2328f156ed7f60205e2b1dbe83b6b564b

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

# Node base template


CMD ["/bin/bash"]
