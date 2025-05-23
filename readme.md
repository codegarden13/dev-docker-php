## Dockerfile for simple php dev 
- Apache
- PHP 8.1
- Database (Mariadb for ARM)
  - Example DB "d3_articles"
- phpmyadmin (not really needed, maybe just inject "adminer" as a replacement)

## prerequisites

## (My) folder structure

```
└── 📁xviz-static-portal
    └── 📁init-db
        └── db.sql                  (example database)
    └── 📁input-data
        └── prd.conf
        └── stg.conf
    └── 📁logs
    └── .env                        (Variables for docker-compose and bash scripts)
    └── backup_subfolders.sh
    └── container-uninstall.sh
    └── docker-compose.yml
    └── dockerfile                  (enhanced php configuration)
    └── readme.md
```

### Fill directory "input-data" /vhost

put the vhost configuration for apache with the ports like in docker-compose.yml

```
└── 📁input-data
    └── prd.conf
    └── stg.conf
```

### stg.conf

```
Listen 8182
<VirtualHost *:8182>
    ServerName localhost
    DocumentRoot /var/www/stg
    <Directory /var/www/stg>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

### prd.conf

```
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot /var/www/prd
    <Directory /var/www/prd>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

## ... proceed.

1. create file .env for the variables that are used in docker-compose.yml
2. create a folder init-db where you may put a sql file to create a database structure for your project. 
3. run `docker-compose up --build` so that the dockerfile is respected
4. run `docker compose up -v` after a previous `./container-uninstall.sh`

Now you can write php/html to the webroot directories prd or stg, which are synced to the webroots of your instances. If you are good with your results, save it local using the backup function below.

## Tips
If something is messed up, rebuild from scratch: 

```bash
docker-compose down -v
docker-compose up --build
```

The -v removes volumes and triggers full reinitialization (including init-db SQL execution).



## ... backup.
**Backup** of your work is crucial. In practise, you work in stg and prd. 
GIT is perfect, but i had cases when GIT messed up folders, because i used Git wrong. 
Do not rely on the exposed docker mountpoints that sync local folders with the container.
Instead, use  `./backup_subfolders.sh stg ` to zip your staging files to a (ICloud?) location that you can define in a `.env` file.

To **connect to the mysql database** from a php file, use `$mysqli = new mysqli("db", "root", "root", "d3_articles");`

**Dump** the database with `backup_sql.sh` to the defined backup location, if you want to save database work.

## Security
- make the scripts executable chmod 755 filename.sh
- Change passwords, use the .env file !

