FROM ubuntu:14.04
MAINTAINER Soumith Chintala <soumith@gmail.com>
RUN apt-get update
###############################
#### Install dependencies for torch
###############################
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get -y dist-upgrade
RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-add-repository ppa:chris-lea/zeromq
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y gcc g++
RUN apt-get install -y cmake
RUN apt-get install -y curl
RUN apt-get install -y libreadline-dev
RUN apt-get install -y git-core
RUN apt-get install -y libqt4-core libqt4-gui libqt4-dev
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y ncurses-dev
RUN apt-get install -y imagemagick
RUN apt-get install -y libzmq-dev
RUN apt-get install -y gfortran
RUN apt-get install -y unzip
RUN apt-get install -y gnuplot
RUN apt-get install -y gnuplot-x11
RUN apt-get update
RUN git clone https://github.com/xianyi/OpenBLAS.git /tmp/OpenBLAS
RUN cd /tmp/OpenBLAS && make NO_AFFINITY=1 USE_OPENMP=1 && make install
###########################################
### Now install torch
###########################################
ENV CMAKE_LIBRARY_PATH /opt/OpenBLAS/include:/opt/OpenBLAS/lib:$CMAKE_LIBRARY_PATH
ENV PATH /usr/local/bin:$PATH
RUN git clone https://github.com/torch/luajit-rocks.git /tmp/luajit-rocks
WORKDIR /tmp/luajit-rocks
RUN mkdir build; 
WORKDIR /tmp/luajit-rocks/build
RUN git checkout master; 
RUN git pull
RUN rm -f CMakeCache.txt
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release
RUN make
RUN make install
RUN luarocks install sundown       
RUN luarocks install cwrap 
RUN luarocks install paths 
RUN luarocks install torch 
RUN luarocks install nn    
RUN luarocks install dok   
RUN luarocks install gnuplot 
RUN luarocks install qtlua 
RUN luarocks install qttorch 
RUN luarocks install luafilesystem
RUN luarocks install penlight
RUN luarocks install sys        
RUN luarocks install xlua       
RUN luarocks install image      
RUN luarocks install optim      
RUN luarocks install lua-cjson  
RUN luarocks install trepl      
RUN luarocks install nnx
