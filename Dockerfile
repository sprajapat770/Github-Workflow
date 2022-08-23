# Container image that runs your code
FROM wardenenv/php-fpm:7.4

RUN warden env exec php-fpm php -v

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
