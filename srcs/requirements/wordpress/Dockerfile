FROM    debian:buster

RUN     apt update -yq \
        && apt upgrade -y \
        && apt install -y php7.3 php-fpm \
        && apt-get clean -y

# Create directory for sock-file:
# -p is short for --parents - it creates the entire directory tree up to the given directory.
RUN     mkdir -p /run/php

COPY    ./tools/config.sh       /etc/wordpress/config.sh
RUN     chmod 775 /etc/wordpress/config.sh

ENTRYPOINT ["/bin/bash", "/etc/wordpress/config.sh"]
# CMD /usr/bin/php-fpm -D;
# CMD /usr/sbin/php-fpm7.3 -F -R
# /usr/sbin/php-fpm7.3 -F