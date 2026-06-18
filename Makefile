# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pbret <pbret@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/06/15 12:41:37 by pbret             #+#    #+#              #
#    Updated: 2026/06/18 20:01:19 by pbret            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	cp /home/pbret/data/.env ./srcs/
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start
	
stop:
	$(COMPOSE) stop

re: down up

clean: down
	docker system prune -af
	docker volume rm srcs_mariadbVol
	docker volume rm srcs_wordpressVol
	sudo rm -rf /home/pbret/data/mariadb/*
	sudo rm -rf /home/pbret/data/wordpress/*

.PHONY: all up down start stop re clean