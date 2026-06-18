#!/bin/bash

# attend que Mariadb soit pret avant la configuration de WP
sleep 10

# si le fichier wp-config.php n'existe pas -> generation de celui-ci + creation des deux users
if [ ! -f /var/www/wordpress/wp-config.php ]; then # creation de wp-config.php (config de WP)

	# allow-root: autorise wp-CLI a s'executer en tant que root
	# dbname: indique le nom de la base de donnees (Mariadb)
	# dbuser: indique le nom du user avec le quel WP va se connecter a Mariadb
	# dbpass: indique le mdp de ce user (connection Mariadb)
	# dbhost: indique l'adresse (nom du conteneur Mariadb + son port sur le reseau docker)
	# path: indique a wp-cli ou trouver les fichiers de WP(il en a besoin)
	wp config create \
		--allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress'
	
	# installation de WP + creation du user admin (avec la config. que l'on vient de generer
	
	# url: indique l'url du site
	# title: indique le titre du site
	# admin_user: indique le nom du user admin
	# admin_password: indique son mdp
	# admin_email: indique son mail
	wp core install \
		--allow-root \
		--url=$DOMAIN_NAME \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--path='/var/www/wordpress'

	# creation du 2eme user (non admin)
	# avec son nom/mail
	# role: donne un "role" au user (author-> crer/edite ses posts)
	# usr_pass: indique son mdp
	wp user create $WP_USER $WP_USER_EMAIL \
		--allow-root \
		--role=author \
		--user_pass=$WP_USER_PASSWORD \
		--path='/var/www/wordpress'
fi

# lance le gestionnaire de processus de php -> php-fpm
# -F -> Foreground (force le processus de php_fpm a rester sur le processus principale)
exec php-fpm8.2 -F


