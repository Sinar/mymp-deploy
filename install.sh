#!/bin/sh

# Based on provision.sh on popit. But we going to remove a few thing. 
# Update package index before we start
apt-get update -y

# Add extra repos
echo "##############################"
echo "Adding neccessary repos for Node.js and MongoDB"
echo "##############################"
# Instructions from: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
apt-get install -y python-software-properties
add-apt-repository -y ppa:chris-lea/node.js
# Instructions from: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/10gen.list
apt-get update -y
	
# Install packages
echo "##############################"
echo "Installing Packages"
echo "##############################"
apt-get install -yqq nodejs mongodb-10gen build-essential ruby1.9.1 ruby1.9.1-dev git daemontools daemontools-run
gem install compass pry

adduser popit

mkdir /opt/sinar/
cd /opt/sinar/
# Give only read access

git clone https://github.com/Sinar/popit 
chown -R popit:popit popit
sudo -u popit make
mkdir /etc/service/popit/
# run popit as a different user 
echo "#!/bin/sh" > /etc/service/popit/run
echo "cd /opt/sinar/popit/" >> /etc/service/popit/run
echo "exec setuidgid popit  node ./server.js" >> /etc/service/popit/run
chmod 1775 /etc/service/popit
chmod +x /etc/service/popit/run
svc -u /etc/service/popit/


