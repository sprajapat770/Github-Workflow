# Container image that runs your code
FROM ubuntu
RUN apt-get -y update \
    && apt-get -y install \
    git \
    curl

RUN mkdir /opt/warden \
    && chown $(whoami) /opt/warden \
    && git clone -b master https://github.com/davidalger/warden.git /opt/warden \
    && echo 'export PATH="/opt/warden/bin:$PATH"' >> ~/.bashrc \
    && PATH="/opt/warden/bin:$PATH" \
    && warden svc up

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
