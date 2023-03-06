# FROM : l'image que vous allez utiliser comme base pour la creation de notre image
FROM debian:buster

# Ensuite, utilisez l'instruction RUN pour exécuter une commande dans votre conteneur.
# Limitez au maximum le nombre d'instructions RUN, afin de limiter le nombre de layers créées, et donc de réduire la taille de notre image Docker.
RUN     apt update -yq \
        && apt upgrade -y \
        && apt install nginx -y

# installation TLS / SSL
# 1) get openssl pkg
# 2) .
# 3) generate key and certificate files
#clear apt pkg list
RUN     apt install openssl -y \
        && mkdir -p /etc/nginx/ssl \
        && openssl req -x509 -nodes \
            -out /etc/nginx/ssl/nginx-selfsigned.crt \
            -keyout /etc/nginx/ssl/nginx-selfsigned.key \
            -subj "/C=FR/L=Paris/O=42School/CN=vnafissi.42.fr/" \
        && apt-get clean -y 

RUN     chmod 755 /etc/nginx/ssl

# modification des droits pour avoir accès au root principal et à l'utilisateur principal)
#on va déclarer l'utilisateur www-data comme propriétaire de ce dossier. Il s'agit de l'utilisateur par défaut de Nginx 
RUN     chmod 755 /var/www/html \
        && chown -R www-data:www-data /var/www/html

# Copy conf file in the container created. it replaces the default existing nginx conf file
COPY    ./conf/nginx.conf /etc/nginx/nginx.conf

# create softlink so that nginx logs are visible in docker logs
RUN     ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# L'instruction EXPOSE permet d'indiquer le port sur lequel votre application écoute.
# EXPOSE ne rend pas les ports du conteneur accessibles à l'hôte, il expose le port spécifié et le rend disponible uniquement pour la communication entre conteneurs
# Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB, il est important que les deux conteneurs soient exécutés dans le même réseau docker.
EXPOSE  443

#CMD ou ENTRYPOINT doit toujours etre present. exécute une commande lors du demarrage du conteneur.
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
