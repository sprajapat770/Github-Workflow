# Container image that runs your code
FROM ubuntu
# Create a user group 'xyzgroup'
RUN addgroup -S xyzgroup

# Create a user 'appuser' under 'xyzgroup'
RUN adduser -S -D -h /usr/app/src appuser xyzgroup
USER appuser

RUN sudo apt-get -y update \
    && sudo apt-get -y install \
    git \
    curl
RUN sudo apt-get install docker-compose -y
RUN sudo mkdir /opt/warden \
    && sudo chown $(whoami) /opt/warden \
    && git clone -b master https://github.com/davidalger/warden.git /opt/warden \
    && echo 'export PATH="/opt/warden/bin:$PATH"' >> ~/.bashrc \
    && PATH="/opt/warden/bin:$PATH" \
    && warden svc up

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
