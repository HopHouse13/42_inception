FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y mariadb-server
		# maj de la liste des paquets, maj des paquets existants, installe mariadb-server

COPY	/conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
		# copie du build context (hote) la config dans le container mariadb

COPY	tools/initMariadb.sh /usr/local/bin/initMariadb.sh
		# copie le script du build context (hote) vers bin du container

RUN		chmod 755 /usr/local/bin/initMariadb.sh
		# donne les droits pour que le script soit executable
		# script de parametrage du volume de la base de donnees

CMD		[ "initMariadb.sh" ]
		# lance le fameux script pour configurer et demarrer le container mariadb (en 1er plan)s
