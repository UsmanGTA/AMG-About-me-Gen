# installation instructions

# Requires typical webserver installation
# with php installed and the php-curl module enabled
# and Python/flask/sqlalchemy/CORS installed for the backend api

#
# cd to /var/www and git clone the repo
cd /var/www/
git clone https://github.com/UsmanGTA/AMG-About-me-Gen.git

#
# Move html to html_dist and link webroot to html
# chown both folders to nginx user (assuming www-data)

mv html html_dist
ln -s AMG-About-me-Gen/webroot html
chown -R www-data AMG-About-me-Gen/webroot AMG-About-me-Gen/api

#
# assuming sites-available/default is a symlink, 
# copy the config, remove the symlink, and link the new config 

rm /etc/nginx/sites-available/default
cp AMG-About-me-Gen/sites-available.default /etc/nginx/sites-enabled/amg
ln -s /etc/nginx/sites-enabled/amg /etc/nginx/sites-available/default

#
# install nginx, php-fpm, php-curl, and start services

apt install nginx
apt install php7.4-fpm
apt install php-curl
service php7.4-fpm start
service nginx start

# install python, pip3, sqlalchemy and cors,
# then launch the api

#  python install example missing

cd /var/www/AMG-About-me-Gen/api
flask run

#
#setup authentication

# add user
sudo sh -c "echo -n 'usman:' >> /etc/nginx/.htpasswd"
# add password (openssl will prompt twice):
sudo sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd"

# load your page, and enjoy!