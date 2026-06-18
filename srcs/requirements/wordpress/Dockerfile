FROM		debian:bookworm

RUN			apt-get update \
			&& apt-get upgrade -y

RUN			apt-get install -y wget\
			php \
			php-fpm \
			php-mysql \
			mariadb-client
			# maj de la liste des paquets, maj des paquets existants
			# wget: intalle wget, utilitaire pour telecharger du contenu via une ligne de commande
			# php: installe l'interpreteur php (langage interpreteur)
			# php-fpm: installe le gestionnaire des processus php qui gerent les requetes php
			# php-mysql: installe librairie de php pour communiquer avec le serveur MariaDB (php-mysql -> connecteur reseau)
			# mariadb-client: installe du client (mysql) pour envoyer des requetes au serveur MariaDB

RUN			wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www \
			&& cd /var/www \
			&& tar -xzf wordpress-6.8.2-fr_FR.tar.gz \
			&& rm wordpress-6.8.2-fr_FR.tar.gz \
			&& chown -R root:root /var/www/wordpress
			# telecharge wordpress 6-8-2 et le stock l'archive dans /var/www
			# decompresse le dossier et le supprime
			# modifie le proprietaire le dossier decompresse pour root
			# wordpress est un CRM (Customer Relationship Management) gestionnaire de contenu

COPY		conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
			# copie du fichier php.conf dans le repertoire pool.d (repertoire qui stock les config des processus php de gestionnaire php-fpm)

RUN			wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			&& chmod 755 wp-cli.phar \
			&& mv wp-cli.phar /usr/local/bin/wp
			# telecharge a la racine du prog de configuration de wordpress en CLI: Commendes Line Interface
			# changement des droits sur le fichier
			# deplace le fichier dans le repertoire des binaries (repertoire des executables du user)

COPY		/conf/autoConfig.sh /usr/local/bin/autoConfig.sh

RUN			chmod 755 /usr/local/bin/autoConfig.sh

ENTRYPOINT	[ "autoConfig.sh" ]
