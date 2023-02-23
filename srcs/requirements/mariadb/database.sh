# démarrage du service mariaDB
/etc/init.d/mysql start
# service mysql start

# log into the MariaDB command prompt:
# mysql -u <username> -p

# CREATE DATABASE <database_name>;
# -e : Execute statement and quit.
mysql -u root -e "SELECT host, user FROM mysql.user;"
# echo "test"
# echo ${DATABASE_NAME}
# echo "coucou"
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"
mysql -u root -e "SHOW DATABASES;"


# mysql -u root -e "status";

# # MySQL's permissions are based on the host. When you CREATE USER (or GRANT) the user into existence, you provide a host name.
# # It can be '%' (wildcard) or 'localhost' or any other IP or hostname
# mysql -uroot -e "CREATE USER IF NOT EXISTS `${ADMIN_USERNAME}`@'localhost' IDENTIFIED BY '${ADMIN_PASSWORD}';"

# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"
# mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown