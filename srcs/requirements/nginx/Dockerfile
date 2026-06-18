FROM	debian:bookworm

RUN		apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y nginx \
		openssl \
		nano \
		curl

RUN		mkdir -p etc/nginx/ssl \
		&& mkdir -p /var/run/nginx \
		&& openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
		-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pbret.42.fr/UID=pbret"
		# Génère un certificat SSL auto-signé (clé privée + certificat) pour activer le HTTPS sur nginx

COPY	conf/nginx.conf etc/nginx/nginx.conf		
		# instruction pour copier nginx.conf de la racine dans le container nginx

RUN		chmod 755 /var/www/html \
		&& chown -R www-data:www-data /var/www/html
		# assure que les droits sont ok
		# change le proprietaire de path -> user www-data/groupe www-data deviennent proprietaire
		# www-data est le user systeme sous lequel tournent les serveur web

CMD		[ "nginx", "-g", "daemon off;" ]
		# cmd pour demarrer le serveur - deamon off empeche que le processus serveur passe en arriere plan.
		# Il reste dans le proccessus principal (PID 1).
		# Si ce proccessus (PID 1) se termine docker fermera le container. c'est le fonctionnement de docker.
