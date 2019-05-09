# glpi

Docker glpi image for production environment


## Build image

docker build -t glpi:9.4.2 .

## Configure 

In docker-compose.yml.

Adapt passwords for vars :

 - MYSQL_ROOT_PASSWORD
 - MYSQL_PASSWORD

Adapt preserve data :

 - device : your local path 
 

## Run

docker-compose up -d


