##################### DEBUG / LOGS #####################
set -x #Turns on debugging for the current shell session : interprétation dans le terminal de toutes les commandes, boucles, variables
# mysql -u root -e "status";
# mysql -u root -e "SELECT host, user, password FROM mysql.user;"
# mysql -u root -e "SHOW DATABASES;"
# mysql -u root -e "SHOW GRANTS;" #shows grants for current user
# mysql -u root -e "SHOW GRANTS FOR '${DB_USER_USERNAME}'@'localhost';"

# cat /etc/hosts

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]
then
    echo "create database and users"

    ##################### DEMARRAGE #####################
    # démarrage du service mariaDB
    # /etc/init.d/mysql start
    service mysql start

    ##################### CREATION USER, DATABASE  #####################
    # -e : Execute statement and quit.
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

    # MySQL's permissions are based on the host. When you CREATE USER (or GRANT) the user into existence, you provide a host name.
    # It can be '%' (wildcard) or 'localhost' or any other IP or hostname
    # '%' (wildcard) : autorise l'accès pour n'importe quel host.
    # En l'occurence le host du conteneur wordpress pourra s'y connecter aussi !
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"

    mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    #mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
    mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('$DB_ROOT_PASSWORD');"

    #mysql -u root -e "FLUSH PRIVILEGES;" #Needed after altering user ?
    #mysql -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;" #Needed after altering user ?

    # mysql -u root -p${DB_ROOT_PASSWORD} -e "SELECT host, user, password FROM mysql.user;"

    ##################### SHUTDOWN #####################
    sleep 3
    # mysqladmin -u root shutdown
    mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
    # /etc/init.d/mysql stop
fi

##################### REDEMARRAGE POUR LAISSER TOURNER #####################
exec mysqld_safe #recommended way to start a mysqld server on Unix
