FROM    debian:buster

RUN     apt update -yq \
        && apt upgrade -y \
        && apt install mariadb-server -y \
        && apt install mariadb-client -y

COPY    ./conf/mariadb.cnf      /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY    ./tools/database.sh     /etc/mysql/database.sh

RUN     chmod -R 755 /etc/mysql/database.sh

# Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB
# il est important que les deux conteneurs soient exécutés dans le même réseau docker.
EXPOSE  3306

CMD     [ "/bin/bash", "/etc/mysql/database.sh" ]