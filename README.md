# Wordpress Alpine based project

90MB image for Wordpress 

A- Components:

  1 Alpine:
  
    A minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size!
    
  2- Nginx:
  
     The high‑performance application delivery platform, load balancer, and web server.
     
  3- PHP-FPM:
  
     Is an alternative PHP FastCGI implementation with some additional features useful for sites of any size, especially busier sites.
     
  4- Mariadb:
  
     Is a community-developed fork of MySQL intended to remain free under the GNU GPL.
     
  5- Wordpress:
  
     Is a content management system based on PHP and MySQL that is usually used with the MySQL or MariaDB database servers but can also use the SQLite database engine.
     
  
B- Configuration:

   - conf/db.env:
    
     Modify this file wit database configuration to modify `wp-config.php` and configure mariadb container.
     
   - conf/.my.cnf:
   
     Modify this file to configure mariadb container to access `root` user without password
     

C- Start the project:

  - Clone this project on your host:
  
    `git clone https://github.com/Ahmed-M-Arafa/nginx-php-mariadb-alpine.git`
    
  - Build and start the project:
  
    `sudo docker-compose up --build -d`
    
    
D- Enjoy :)
