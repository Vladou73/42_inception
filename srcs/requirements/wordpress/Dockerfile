FROM    debian:buster

RUN     apt update -yq \
        && apt upgrade -y \
        && apt install -y php-fpm php-mysql mariadb-client \
        # && apt install -y php7.3 php-fpm \
        && apt-get clean -y

# Create directory for php sock-file:
# -p is short for --parents - it creates the entire directory tree up to the given directory.
RUN     mkdir -p /run/php

#download wordpress with wget and unzip it in /var/www
#wget is a Linux based free and open source utility used for retrieving contents from Web Server
RUN     apt install wget -y \ 
        && wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
        && cd /var/www \
        && tar -xzf wordpress-6.0-fr_FR.tar.gz \
        && rm wordpress-6.0-fr_FR.tar.gz

#download wordpress CLI for automatic configuration
RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        && chmod +x wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp

RUN     mkdir -p /var/www/html
RUN     chown -R root:root /var/www/html

#copying the config file for php 
COPY    conf/www.conf   /etc/php/7.3/fpm/pool.d/www.conf
RUN     chmod 755       /etc/php/7.3/fpm/pool.d/www.conf

#copying script for wp and launching php-fpm
COPY    ./tools/config.sh       /etc/wordpress/config.sh
RUN     chmod 775               /etc/wordpress/config.sh


EXPOSE 9000

ENTRYPOINT ["/bin/bash", "/etc/wordpress/config.sh"]
# CMD /usr/bin/php-fpm -D;
# CMD /usr/sbin/php-fpm7.3 -F -R
# /usr/sbin/php-fpm7.3 -F