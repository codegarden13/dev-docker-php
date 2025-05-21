## Dockerfile for simple php dev 
- apache
- php
- database (Mariadb for ARM)
  - db named d3_articles
- phpmyadmin

## prerequisites
### create directory "input-data", 

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

Now you can write your php or html to the directories prd or stg, this folders are synced to the webroots of your instances.

## Last but not least ... backup.
**Backup** of your work is crucial. In practise, you work in stg and prd. 
GIT is perfect, but i had cases when GIT messed up imprtant folders, because i used it in a wrong way. Do not rely on the exposed docker mountpoints that sync local folders with the container. `./backup_subfolders.sh stg ` would zip your staging files to an ICloud location which you can define in a `.env` file.

To **connect to the mysql database** from a php file, use `$mysqli = new mysqli("db", "root", "root", "d3_articles");`