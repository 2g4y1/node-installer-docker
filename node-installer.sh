#!/bin/bash

VRSN="0.3.2"

VAR_CERTIFICATE=0
VAR_NETWORK=0
VAR_HOST=''

DockerShimmerMainnet="https://github.com/iotaledger/hornet/releases/download/v2.0.0-alpha.22/HORNET-2.0.0-alpha.22-docker-example.tar.gz"
DockerIotaBee="https://dlt.green/downloads/iota-bee.tar.gz"

if [ -f "node-installer.sh" ]; then rm node-installer.sh; fi

CheckCertificate() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                      Check Let's Encrypt Certificate                        ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ -f "/etc/letsencrypt/live/$VAR_HOST/fullchain.pem" ] 
	then 
		clear
		echo ""
		echo "╔═════════════════════════════════════════════════════════════════════════════╗"
		echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
		echo "║                                    $VRSN                                    ║"
		echo "║                                                                             ║"
		echo "║                            1. Use existing Certificate (recommend)          ║"
		echo "║                            X. Get new Certificate (don't use with SWARM)    ║"
		echo "║                                                                             ║"
		echo "╚═════════════════════════════════════════════════════════════════════════════╝"
		echo "select: "
		echo ""

		read n
		case $n in
		1) VAR_CERT=1 ;;
		*) echo "No existing Let's Encrypt Certificate found, generate a new one... "
		   VAR_CERT=0 ;;
		esac
	else 
		echo "No existing Let's Encrypt Certificate found, generate a new one... "
		VAR_CERT=0
	fi 
}

MainMenu() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
	echo "║                                    $VRSN                                    ║"
	echo "║                                                                             ║"
	echo "║                              1. System Updates                              ║"
	echo "║                              2. Docker Installation                         ║"
	echo "║                              3. IOTA Mainnet                                ║"
	echo "║                              4. IOTA Devnet                                 ║"
	echo "║                              5. Shimmer Mainnet                             ║"
	echo "║                              6. Shimmer EVM                                 ║"
	echo "║                              X. Abort Installer                             ║"
	echo "║                                                                             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo "select: "
	echo ""

	read n
	case $n in
	1) SystemUpdates ;;
	2) Docker ;;
	3) SubMenuIotaMainnet ;;
	4) SubMenuIotaDevnet ;;
	5) SubMenuShimmerMainnet ;;
	6) MainMenu ;;
	*) exit ;;
	esac
}

SubMenuIotaMainnet() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
	echo "║                                    $VRSN                                    ║"
	echo "║                                                                             ║"
	echo "║                              1. IOTA Hornet Mainnet                         ║"
	echo "║                              2. IOTA Bee Mainnet                            ║"
	echo "║                              X. Main Menu                                   ║"
	echo "║                                                                             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo "select: "
	echo ""

	read n
	case $n in
	1) MainMenu ;;
	2) VAR_NETWORK=3
	   IotaBee ;;
	*) MainMenu ;;
	esac
}

SubMenuIotaDevnet() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
	echo "║                                    $VRSN                                    ║"
	echo "║                                                                             ║"
	echo "║                              1. IOTA Hornet Devnet                          ║"
	echo "║                              2. IOTA Bee Devnet                             ║"
	echo "║                              3. IOTA Goshimmer                              ║"
	echo "║                              4. IOTA Wasp                                   ║"	
	echo "║                              X. Main Menu                                   ║"
	echo "║                                                                             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo "select: "
	echo ""

	read n
	case $n in
	1) MainMenu ;;
	2) VAR_NETWORK=4
	   IotaBee ;;
	3) MainMenu ;;
	4) MainMenu ;;
	*) MainMenu ;;
	esac
}

SubMenuShimmerMainnet() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
	echo "║                                    $VRSN                                    ║"
	echo "║                                                                             ║"
	echo "║                              1. Shimmer Hornet Mainnet                      ║"
	echo "║                              2. Shimmer Bee Mainnet                         ║"
	echo "║                              X. Main Menu                                   ║"
	echo "║                                                                             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo "select: "
	echo ""

	read n
	case $n in
	1) ShimmerHornet ;;
	2) MainMenu ;;
	*) MainMenu ;;
	esac
}

SystemUpdates() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                     DLT.GREEN AUTOMATIC SYSTEM UPDATES                      ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	clear
	sudo apt-get update && apt-get upgrade -y
	sudo apt-get dist-upgrade -y
	sudo apt upgrade -y
	sudo apt-get autoremove -y

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	clear
	
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║               DLT.GREEN AUTOMATIC NODE-INSTALLER WITH DOCKER                ║"
	echo "║                                    $VRSN                                    ║"
	echo "║                                                                             ║"
	echo "║                            1. System Reboot (recommend)                     ║"
	echo "║                            X. Main Menu                                     ║"
	echo "║                                                                             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo "select: "
	echo ""
	
	read n
	case $n in
	1) sudo reboot ;;
	*) MainMenu ;;
	esac
}

Docker() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                   DLT.GREEN AUTOMATIC DOCKER INSTALLATION                   ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	dir='/var/lib/shimmer-hornet'
	if [ -d $dir ]; then cd $dir || exit; docker-compose down; fi

	dir='/var/lib/iota-bee'
	if [ -d $dir ]; then cd $dir || exit; docker-compose down; fi

	sudo apt-get install jq -y
	sudo apt-get install expect -y
	
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║   Update and install packages to allow apt to use a repository over HTTPS   ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	sudo apt-get update

	sudo apt-get install \
		ca-certificates \
		curl \
		gnupg \
		lsb-release

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                        Add dockers official GPG key                         ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                          Now set up the repository                          ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                            Install docker engine                            ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	MainMenu
}

IotaBee() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║              DLT.GREEN AUTOMATIC BEE INSTALLATION WITH DOCKER               ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	dir='/var/lib/iota-bee'
	if [ -d $dir ]; then cd $dir || exit; docker-compose down; fi

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                     Create bee directory /var/lib/iota-bee                  ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then mkdir $dir || exit; cd $dir || exit; fi

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                   Pull installer from dlt.green/iota-bee                    ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	wget -cO - "$DockerIotaBee" > install.tar.gz

	echo "unpack:"
	tar -xzf install.tar.gz

	echo "remove tar.gz:"
	rm -r install.tar.gz

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W
	
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Set Parameters                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Set domain-name: ' VAR_HOST
	read -p 'Set domain-port: ' VAR_BEE_HTTPS_PORT	
	read -p 'Set dashboard username: ' VAR_USERNAME
	read -p 'Set password (blank): ' VAR_PASSWORD
	
	CheckCertificate

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                              Write Parameters                               ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi
	if [ -f .env ]; then rm .env; fi

	echo "BEE_VERSION=0.3.1" >> .env

	if [ $VAR_NETWORK = 3 ]; then echo "BEE_NETWORK=mainnet" >> .env; fi
	if [ $VAR_NETWORK = 4 ]; then echo "BEE_NETWORK=devnet" >> .env; fi
	
	echo "BEE_HOST=$VAR_HOST" >> .env
	echo "BEE_HTTPS_PORT=$VAR_BEE_HTTPS_PORT" >> .env
	echo "BEE_GOSSIP_PORT=15601" >> .env
	echo "BEE_AUTOPEERING_PORT=14636" >> .env
	
	if [ $VAR_CERT = 0 ]
	then
		echo "BEE_HTTP_PORT=80" >> .env
		read -p 'Set mail for certificat renewal: ' VAR_ACME_EMAIL
		echo "ACME_EMAIL=$VAR_ACME_EMAIL" >> .env
	else
		echo "BEE_HTTP_PORT=8082" >> .env
		echo "SSL_CONFIG=certs" >> .env
		echo "BEE_SSL_CERT=/etc/letsencrypt/live/$VAR_HOST/fullchain.pem" >> .env
		echo "BEE_SSL_KEY=/etc/letsencrypt/live/$VAR_HOST/privkey.pem" >> .env
	fi

	read -p 'Press [Enter] key to continue...' W

	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                                 Pull Data                                   ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	docker-compose pull
	
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Set Creditials                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	credentials=$(./password.sh "$VAR_PASSWORD" | sed -e 's/\r//g')

	VAR_DASHBOARD_PASSWORD=$(echo "$credentials" | jq -r '.passwordHash')
	VAR_DASHBOARD_SALT=$(echo "$credentials" | jq -r '.passwordSalt')

	echo "DASHBOARD_USERNAME=$VAR_USERNAME" >> .env
	echo "DASHBOARD_PASSWORD=$VAR_DASHBOARD_PASSWORD" >> .env
	echo "DASHBOARD_SALT=$VAR_DASHBOARD_SALT" >> .env

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Prepare Docker                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi
	./prepare_docker.sh

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                                 Start Bee                                   ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi

	docker-compose up -d
	docker container rename iota-bee_bee_1 iota-bee
	docker container rename iota-bee_traefik_1 iota-bee.traefik
	docker container rename iota-bee_traefik-certs-dumper_1 iota-bee.traefik-certs-dumper

	echo ""
	echo "═══════════════════════════════════════════════════════════════════════════════"
	echo " Bee Dashboard: https://$VAR_HOST:$VAR_BEE_HTTPS_PORT/dashboard"
	echo " Bee Username: $VAR_USERNAME"
	echo " Bee Password: <set during install>"
	echo " API: https://$VAR_HOST:$VAR_BEE_HTTPS_PORT/api/v1/info"
	echo "═══════════════════════════════════════════════════════════════════════════════"
	echo ""

	read -p 'Press [Enter] key to continue...' W

	MainMenu
}

ShimmerHornet() {
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║            DLT.GREEN AUTOMATIC SHIMMER INSTALLATION WITH DOCKER             ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W

	dir='/var/lib/shimmer-hornet'
	if [ -d $dir ]; then cd $dir || exit; docker-compose down; fi

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                   Create hornet directory /var/lib/shimmer-hornet           ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then mkdir $dir || exit; cd $dir || exit; fi

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                   Pull repo from iotaledger/hornet:develop                  ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	wget -cO - "$DockerShimmerMainnet" > install.tar.gz

	echo "unpack:"
	tar -xzf install.tar.gz

	echo "remove tar.gz:"
	rm -r install.tar.gz

	read -p 'Press [Enter] key to continue... Press [STRG+C] to cancel...' W
	
	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Set Parameters                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	read -p 'Set domain-name: ' VAR_HOST
	read -p 'Set dashboard username: ' VAR_USERNAME
	read -p 'Set password (blank): ' VAR_PASSWORD
	read -p 'Set mail for certificat renewal: ' VAR_ACME_EMAIL

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                              Write Parameters                               ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi
	if [ -f .env ]; then rm .env; fi

	echo "HORNET_HOST=$VAR_HOST" >> .env
	echo "GRAFANA_HOST=grafana.$VAR_HORNET_HOST" >> .env

	read -p 'Press [Enter] key to continue...' W

	clear
	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                                 Pull Data                                   ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	docker-compose pull

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Set Creditials                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	credentials=$(docker-compose run --rm hornet tool pwd-hash --json --password "$VAR_PASSWORD" | sed -e 's/\r//g')

	VAR_DASHBOARD_PASSWORD=$(echo "$credentials" | jq -r '.passwordHash')
	VAR_DASHBOARD_SALT=$(echo "$credentials" | jq -r '.passwordSalt')
	
	echo "DASHBOARD_USERNAME=$VAR_USERNAME" >> .env
	echo "DASHBOARD_PASSWORD=$VAR_DASHBOARD_PASSWORD" >> .env
	echo "DASHBOARD_SALT=$VAR_DASHBOARD_SALT" >> .env

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                               Prepare Docker                                ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi
	./prepare_docker.sh

	echo ""
	echo "╔═════════════════════════════════════════════════════════════════════════════╗"
	echo "║                                Start Hornet                                 ║"
	echo "╚═════════════════════════════════════════════════════════════════════════════╝"
	echo ""

	if [ ! -d $dir ]; then exit; cd $dir || exit; fi

	docker-compose up -d
	docker container rename shimmer-hornet_hornet_1 shimmer-hornet
	docker container rename shimmer-hornet_traefik_1 shimmer-hornet.traefik
	docker container rename shimmer-hornet_inx-participation_1 shimmer-hornet.inx-participation
	docker container rename shimmer-hornet_inx-dashboard_1 shimmer-hornet.inx-dashboard
	docker container rename shimmer-hornet_inx-indexer_1 shimmer-hornet.inx-indexer
	docker container rename shimmer-hornet_inx-poi_1 shimmer-hornet.inx-poi
	docker container rename shimmer-hornet_inx-spammer_1 shimmer-hornet.inx-spammer
	docker container rename shimmer-hornet_inx-mqtt_1 shimmer-hornet.inx-mqtt
	
	docker exec -it grafana grafana-cli admin reset-admin-password "$VAR_PASSWORD"

	echo ""
	echo "═══════════════════════════════════════════════════════════════════════════════"
	echo " Hornet Dashboard: https://$VAR_HOST/dashboard"
	echo " Hornet Username: $VAR_USERNAME"
	echo " Hornet Password: <set during install>"
	echo " Grafana Dashboard: https://$VAR_HOST/grafana"
	echo " Grafana Username: admin"
	echo " Grafana Password: <same as hornet password>"
	echo " API: https://$VAR_HOST/api/core/v2/info"
	echo "═══════════════════════════════════════════════════════════════════════════════"
	echo ""

	read -p 'Press [Enter] key to continue...' W

	MainMenu
}

MainMenu