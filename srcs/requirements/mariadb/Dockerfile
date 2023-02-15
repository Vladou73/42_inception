# FROM : l'image que vous allez utiliser comme base pour la creation de notre image
FROM debian:buster

# Release date of latest stable mariadb version: 6 Feb 2023
RUN apt update -yq \
&& apt upgrade -y \
&& apt install mariadb-server -y

# Copy conf file in the container created. it replaces the default existing nginx conf file
COPY  ./conf/mariadb.cnf	/etc/mysql/mariadb.conf.d/mariadb.cnf

# L'instruction EXPOSE permet d'indiquer le port sur lequel votre application écoute.
# EXPOSE ne rend pas les ports du conteneur accessibles à l'hôte, il expose le port spécifié et le rend disponible uniquement pour la communication entre conteneurs
# Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB, il est important que les deux conteneurs soient exécutés dans le même réseau docker.
EXPOSE 3306

#CMD doit toujours etre present. exécute une commande lors du demarrage du conteneur.
# CMD [ "nginx", "-g", "daemon off;" ]