# FROM : l'image que vous allez utiliser comme base pour la creation de notre image
FROM debian:buster

# Ensuite, utilisez l'instruction RUN pour exécuter une commande dans votre conteneur.
# Limitez au maximum le nombre d'instructions RUN, afin de limiter le nombre de layers créées, et donc de réduire la taille de notre image Docker.
RUN apt update -yq \
&& apt upgrade -y \
&& apt install nginx -y

# installation TLS / SSL
# 1) get openssl pkg
# 2) .
# 3) generate key and certificate files
#clear apt pkg list
RUN apt install openssl -y \
&& mkdir -p /etc/nginx/ssl \
&& openssl req -x509 -nodes \
    -out /etc/nginx/ssl/nginx-selfsigned.crt \
    -keyout /etc/nginx/ssl/nginx-selfsigned.key \
    -subj "/C=FR/L=Paris/O=42School/CN=vnafissi.42.fr/" \
&& apt-get clean -y 

RUN chmod 755 /etc/nginx/ssl

# l'instruction ADD afin de copier ou de télécharger des fichiers dans l'image.
# Dans notre cas, nous l'utilisons pour ajouter les sources de notre application locale dans le dossier /app/ de l'image.
# ADD . /app/

# Copy conf file in the container created. it replaces the default existing nginx conf file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#modification des droits pour avoir accès au root principal et à l'utilisateur principal)
RUN chmod 755 /var/www/html \
&& chown -R www-data:www-data /var/www/html 

# WORKDIR permet de modifier le répertoire courant, commande équivalente à cd
# L'ensemble des commandes qui suivront seront toutes exécutées depuis le répertoire défini.
# WORKDIR /app

# L'instruction EXPOSE permet d'indiquer le port sur lequel votre application écoute.
# EXPOSE ne rend pas les ports du conteneur accessibles à l'hôte, il expose le port spécifié et le rend disponible uniquement pour la communication entre conteneurs
# Note : Pour que le serveur WordPress puisse communiquer avec le conteneur MariaDB, il est important que les deux conteneurs soient exécutés dans le même réseau docker.
EXPOSE 443

# L'instruction VOLUME permet d'indiquer quel répertoire vous voulez partager avec votre host.
# VOLUME /app/logs

#CMD doit toujours etre present. exécute une commande lors du demarrage du conteneur.
CMD [ "nginx", "-g", "daemon off;" ]




#FROM qui vous permet de définir l'image source ;
#RUN qui vous permet d’exécuter des commandes dans votre conteneur ;
#ADD qui vous permet d'ajouter des fichiers dans votre conteneur ;
#WORKDIR qui vous permet de définir votre répertoire de travail ;
#EXPOSE qui permet de définir les ports d'écoute par défaut ;
#VOLUME qui permet de définir les volumes utilisables ;
#CMD qui permet de définir la commande par défaut lors de l’exécution de vos conteneurs Docker.
