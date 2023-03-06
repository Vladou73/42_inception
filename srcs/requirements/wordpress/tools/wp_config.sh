set -x #debug mode

cat /etc/hosts

echo "---------- wait for MariaDB container script to be executed -----------"
sleep 15

# check connexion and mysql server are up with statut and ping. 
mysqladmin -u ${DB_USER_USERNAME} -p${DB_USER_PASSWORD} -h ${DB_HOST} status
mysqladmin -u ${DB_USER_USERNAME} -p${DB_USER_PASSWORD} -h ${DB_HOST} ping

#download wordpress in path directory as root user
wp core download --locale=fr_FR --path="/var/www/html" --allow-root

#generate wp-config.php and adds to it the database credentials
wp config create    --path="/var/www/html" \
                    --dbhost=$DB_HOST \
                    --dbname=$DB_NAME \
                    --dbuser=$DB_USER_USERNAME \
                    --dbpass=$DB_USER_PASSWORD \
                    --allow-root

#Creates the WordPress tables in the database using the URL, title, 
#and default admin user details provided.
wp core install     --path="/var/www/html" \
                    --title=$WP_TITLE \
                    --url=$WP_URL \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --locale=fr_FR \
                    --allow-root
                    
#Install and use a theme
wp theme install twentytwentyone --allow-root --activate #--force
# wp theme activate twentytwentyone --allow-root 

# run php-fpm7.3 listening for CGI request/ as a FastCGI process
exec /usr/sbin/php-fpm7.3 -F -R #Les flags servent à run en foreground, nécessaire dans le container docker






#TESTS without variables
# wp config create    --dbhost=localhost \
#                     --dbname=DB_NAME \
#                     --dbuser=DB_USER_USERNAME \
#                     --dbpass=DB_USER_PASSWORD \
#                     --allow-root
# wp core install     --title=WP_TITLE \
#                     --url=WP_URL \
#                     --admin_user=WP_ADMIN_USER \
#                     --admin_password=WP_ADMIN_PASSWORD \
#                     --locale=fr_FR \
#                     --allow-root
                    # --admin_email=WP_ADMIN_EMAIL \