# learning-prolog
Liguagem de programação vista nas matérias:
 - Paradigmas da computação
 - Sistemas inteligentes
 
 
 # Install
 ### Prerequisites for Debian based systems 
 `sudo apt-get install \`
 
        `build-essential autoconf curl chrpath pkg-config \       
        ncurses-dev libreadline-dev libedit-dev \        
        libunwind-dev \        
        libgmp-dev \        
        libssl-dev \        
        unixodbc-dev \ 
        zlib1g-dev libarchive-dev \
        libossp-uuid-dev \
        libxext-dev libice-dev libjpeg-dev libxinerama-dev libxft-dev \
        libxpm-dev libxt-dev \
        libdb-dev \
        libpcre3-dev \
        libyaml-dev \
        openjdk-8-jdk junit`
        
### Preparing the source 

`git clone https://github.com/SWI-Prolog/swipl-devel.git`

`cd swipl-devel`

`./prepare`

### 

`cd swipl-<version>/src
./configure			# see bellow
make
sudo
make install`
