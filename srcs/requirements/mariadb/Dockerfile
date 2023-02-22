# FROM : l'image que vous allez utiliser comme base pour la creation de notre image
FROM    debian:buster

# Release date of latest stable mariadb version: 6 Feb 2023
RUN     apt update -yq \
        && apt upgrade -y \
        && apt install mariadb-server -y \
        && apt install mariadb-client -y

COPY    ./conf/mariadb.cnf  /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY    ./database.sh       /etc/mysql/database.sh

RUN     chmod 755 /etc/mysql/database.sh

# Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB, il est important que les deux conteneurs soient exécutés dans le même réseau docker.
EXPOSE  3306

CMD     [ "/bin/bash", "/etc/mysql/database.sh" ]
# CMD     [ "/etc/init.d/mysql" ,"start" ]


# CMD ["mysqld" "--print-defaults"]