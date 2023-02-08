# FROM : l'image que vous allez utiliser comme base pour la creation de notre image
FROM debian:9

# Ensuite, utilisez l'instruction RUN pour exécuter une commande dans votre conteneur.
# Limitez au maximum le nombre d'instructions RUN, afin de limiter le nombre de layers créées, et donc de réduire la taille de notre image Docker.
#RUN

# l'instruction ADD afin de copier ou de télécharger des fichiers dans l'image.
# Dans notre cas, nous l'utilisons pour ajouter les sources de notre application locale dans le dossier /app/ de l'image.
ADD . /app/


# WORKDIR permet de modifier le répertoire courant, commande équivalente à cd
# L'ensemble des commandes qui suivront seront toutes exécutées depuis le répertoire défini.
WORKDIR /app

# L'instruction EXPOSE permet d'indiquer le port sur lequel votre application écoute.
EXPOSE 2368

# L'instruction VOLUME permet d'indiquer quel répertoire vous voulez partager avec votre host.
VOLUME /app/logs

#CMD doit toujours etre present. exécute une commande lors du demarrage du conteneur.
CMD npm run start




#FROM qui vous permet de définir l'image source ;
#RUN qui vous permet d’exécuter des commandes dans votre conteneur ;
#ADD qui vous permet d'ajouter des fichiers dans votre conteneur ;
#WORKDIR qui vous permet de définir votre répertoire de travail ;
#EXPOSE qui permet de définir les ports d'écoute par défaut ;
#VOLUME qui permet de définir les volumes utilisables ;
#CMD qui permet de définir la commande par défaut lors de l’exécution de vos conteneurs Docker.
