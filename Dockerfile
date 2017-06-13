FROM ubuntu:14.04

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y libgc-dev libboost1.55-all-dev libxerces-c2-dev wget

RUN mkdir -p /root/phc
COPY . /root/phc
RUN cd /root/phc
RUN touch Makefile.in configure Makefile
RUN touch libltdl/aclocal.m4 libltdl/configure libltdl/Makefile.in libltdl/Makefile

RUN wget http://museum.php.net/php5/php-5.5.10.tar.gz
RUN tar zxvf php-5.5.10.tar.gz
RUN cd php-5.5.10 && CFLAGS="-O0 -ggdb3" ./configure --enable-debug --enable-maintainer-zts --enable-embed
RUN make -j 4
  
RUN ./configure --with-xerces --disable-static --prefix=`pwd`/install_dir --with-php=`pwd`/php.5.5.10
RUN make -j 4
RUN make install
