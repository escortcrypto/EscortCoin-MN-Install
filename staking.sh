#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/guapcrypto/Guapcoin/releases/download/1.0.0/guapcoin-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf guapcoin-1.0.0-x86_64-linux-gnu.tar.gz
rm -rf guapcoin-1.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 9633/tcp
  
cd
mkdir -p .guapcoin
echo "staking=1" >> guapcoin.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> guapcoin.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> guapcoin.conf
echo "rpcallowip=127.0.0.1" >> guapcoin.conf
echo "listen=1" >> guapcoin.conf
echo "server=1" >> guapcoin.conf
echo "daemon=1" >> guapcoin.conf
echo "logtimestamps=1" >> guapcoin.conf
echo "maxconnections=256" >> guapcoin.conf
echo "addnode=159.65.221.180" >> guapcoin.conf
echo "addnode=165.227.192.223" >> guapcoin.conf
echo "addnode=159.65.217.114" >> guapcoin.conf
echo "addnode=165.227.83.244" >> guapcoin.conf
echo "port=9633" >> guapcoin.conf
mv guapcoin.conf .guapcoin

  
cd
./guapcoind -daemon
sleep 30
./guapcoin-cli getinfo
sleep 5
./guapcoin-cli getnewaddress
echo "Use the address above to send your GUAP coins to this server"

