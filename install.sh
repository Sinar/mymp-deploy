#!/bin/sh
# Create user please
# Create sudo please 
echo "setup dependency"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get -y install python g++ make checkinstall ruby rubygems \
    postfix daemontools daemontools-run mongodb
sudo gem install compass pry
mkdir /opt/sinar/
mkdir /opt/sinar/packages/
echo "setup node.js"
chown -R sweemeng:sweemeng /opt/sinar/packages/
wget -N http://nodejs.org/dist/node-latest.tar.gz
cd node-v*
./configure
make
sudo make install 
echo "Setup email"
# The email setup is not proper it will ends up in spam
cp postfix/main.cf /etc/postfix/main.cf
/etc/init.d/postfix reload
cp postfix/virtual /etc/postfix/virtual 
postmap /etc/postfix/virtual
/etc/init.d/postfix reload
echo "create popit user"
adduser popit
echo "now fetch from github"
cd /opt/sinar/
git clone https://github.com/sinar/popit
chown -R popit:popit popit
cd popit 
exec setuidgid popit make
cp production.js /opt/sinar/popit/config/production.js
echo "now create a popit service"
# We might need to run svscan in /etc/services/popit
mkdir /etc/service/popit/
chmod 1755 /etc/service/popit 
cp daemontools/run /etc/service/popit/
sudo chmod +x /etc/service/popit/run
cp nginx/popit /etc/nginx/sites-available/popit
ln -s /etc/nginx/sites-available/popit /etc/nginx/sites-enabled/popit
service nginx restart
