## Dockerfile for simple php dev 
- apache
- php
- database (Mariadb for ARM)
  - db named d3_articles
- phpmyadmin

## prereqisites
1. Before running Docker `compose up -v`, create input-data and put the vhost configuration for apache with the ports like in docker-compose.yml

```
└── 📁input-data
    └── prd.conf
    └── stg.conf
```
2. create an .env file for the variables that are used in docker-compose.yml
3. create a folder init-db where you may put a sql file to create a database structure for your project. 
4. create folders 

run `docker compose up -v`

Now you can write your php or html to the directories prd or stg, this folders are synced to the webroots of your instances.
