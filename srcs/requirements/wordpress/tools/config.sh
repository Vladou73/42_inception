



# run php-fpm7.3 listening for CGI request/ as a FastCGI process
exec /usr/sbin/php-fpm7.3 -F -R #Les flags servent à run en foreground, nécessaire dans le container docker