#!/bin/bash

service mariadb start

# Creer la base de donnees si elle n'existe pas
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"

# Creer le user (SQL_USER) avec un mdp (SQL_PASSWORD) on retrouve toutes ces variables dans le .env
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`$SQL_USER\`@'%' IDENTIFIED BY '$SQL_PASSWORD';"

# Donner les droits a cet user pour la base
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO \`$SQL_USER\`@'%';"

# Definie que le root doit etre avec un mot de passe
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"

# Met a jour les modifications du dessus dans la base de donnees mariadb avec de l'eteindre
mariadb -h localhost -u root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Eteint proprement le service Mariadb
mysqladmin -h localhost -u root -p$SQL_ROOT_PASSWORD shutdown

# Relance mariadb au 1er plan pour maintenir le container vivant (un seul proccessus)
exec mysqld
