#! /bin/bash
# copy the kibana package to ./files folder inside this folder - else change the script to do a wget prior

# Set variables
FILES=/vagrant/provisioning/files
if [ "$1" == "64" ]; then
	KIBANA="kibana-4.0.0-linux-x64.tar.gz"
else
	KIBANA="kibana-4.0.0-linux-x86.tar.gz"
fi

if [ ! -f /srv/kibana/bin/kibana ]; then
	# Install kibana
	echo "Installing Kibana from ${KIBANA}..."
	mkdir -p /srv/kibana
	tar -C /srv/kibana -zxf ${FILES}/${KIBANA} --strip 1
fi

if [ ! -f /etc/init.d/kibana ]; then
	cp /vagrant/provisioning/files/kibana /etc/init.d/kibana
	chmod +x /etc/init.d/kibana
	update-rc.d kibana defaults 99 10
fi

/etc/init.d/kibana start