#!/usr/bin/env bash
# Installs and configure HAproxy on your lb-01 server.

fend=$(grep -xi "frontend web" hacfg)
bend=$(grep -xi "backend web-backend" hacfg)

FRONTEND='frontend web\n\tbind *:80\n\tmode http\n\tdefault_backend web-backend'
BACKEND='backend web-backend\n\tbalance rounrobin\n\tmode http\n\tserver s1 54.146.64.105:80 check\n\tserver s2 54.90.28.253:80 check'

if [ -z "$fend" ]
then
	# Add frontend configuration
	echo -e "\n$FRONTEND" >> hacfg
fi

if [ -z "$bend" ]
then
	# Add backend configuration
	echo -e "\n$BACKEND" >> hacfg
fi
