include ./srcs/.env

all:
	sudo mkdir -p ${DATA_FOLDER}/wordpress_files
	sudo mkdir -p ${DATA_FOLDER}/wordpress_database
	docker compose -f ./srcs/compose.yaml up -d
	docker compose -f ./srcs/compose.yaml ps

up:
	docker compose -f ./srcs/compose.yaml up -d
	docker compose -f ./srcs/compose.yaml ps

re: fclean all

#stops and removes containers, networks, volumes and images created by up
down:
	docker compose -f ./srcs/compose.yaml down

stop_all:
	-docker stop `docker ps -aq`

cclean:
	-docker rm -f `docker ps -aq`

iclean:
	-docker rmi -f `docker images -aq`

vclean:
	-docker volume rm `docker volume ls -q`

fclean: stop_all cclean iclean vclean 
	docker system prune -af --volumes
	sudo rm -rf ${DATA_FOLDER}
