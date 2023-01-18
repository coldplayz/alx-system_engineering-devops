#!/usr/bin/env bash
# Install nginx on web server; Nginx should be listening on port 80
# Querying Nginx at its root (/) with a GET request (requesting a page)
# 	   curl http://34.198.248.145/   --> returns string "Holberton School"
#	   curl http://34.198.248.145/   --> returns header info
# Configures an Nginx server so that /redirect_me is redirecting to another page.
# Configures an Nginx server to have a custom 404 page that contains the string Ceci n'est pas une page.
# configures Nginx so that its HTTP response contains a custom header (on web-01 and web-02) - X-Served-By.


host=$(hostname)
ERR='\terror_page 404 /404.html;'
ERR_LOC='\tlocation = /404.html {\n\t\troot /var/www/html;\n\t\tinternal;\n\t}'
ADD_HDR_XSB='\tadd_header X-Served-By '"$host"

# See if the redirect location block exists
location=$(sudo grep "	location = /redirect_me {" cfg)
# See if error handling is defined
errdef=$(sudo grep "	error_page 404 /404.html" cfg)
# Check header
xsb=$(sudo grep "	add_header X-Served-By" cfg)

if [ -z "$location" ]
then

	# Append a location block for 301 redirection
	sudo sed -i '/server_name _/a\\n\tlocation = /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n\t}' cfg
else
	sudo sed -i 's!https://www.google.com!https://www.youtube.com/watch?v=QH2-TGUlwu4!' cfg
fi

if [ -z "$errdef" ]
then
	# Error handling not defined yet
	sudo sed -i '/server_name _/a\\n'"$ERR"'\n\n'"$ERR_LOC" cfg
fi

if [ -z "$xsb" ]
then
	# No X-Served-By header yet
	sudo sed -i '/server_name _/a\\n'"$ADD_HDR_XSB" cfg
fi
