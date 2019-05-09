# glpi

Docker glpi image for production environment


## Build image

docker build -t glpi:9.4.2 .

## Configure 

In docker-compose.yml.

Adapt passwords for vars :

 - MYSQL_ROOT_PASSWORD
 - MYSQL_PASSWORD
 
If you want to store mysql data to local drive uncomment lines below **database:** in ```docker-compose.yml```
 
## Create DB

Run stack with ```docker-compose up -d```.

Now go to http://127.0.0.1 and follow instructions from web ui.

Next, copy config_db.php content to your local file.

```bash
  docker exec -it <yourglpicontainer> cat /var/www/html/config/config_db.php
```

You should have something like this : 

```php
<?php
class DB extends DBmysql {
   public $dbhost     = 'mysql';
   public $dbuser     = 'glpi';
   public $dbpassword = 'mysecretglpipassword';
   public $dbdefault  = 'glpi';
}
```

Copy content to your local empty config_db.php file.

Uncomment volumes lines twice (for both glpi and glpi_cron services) in docker-compose.yml : 

```yml
    image: glpi:9.4.2
    volumes:
      - ./config_db.php:/var/www/html/config/config_db.php
```
 
 
## Run

```bash
docker-compose up -d
```

