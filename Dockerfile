FROM centos:centos7
MAINTAINER david.siaw@mobingi.com

RUN yum -y update

RUN yum install -y python pip wget tar

RUN wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
RUN tar -xvf setuptools-1.4.2.tar.gz
RUN cd setuptools-1.4.2 && python2.7 setup.py install

RUN easy_install supervisor
RUN mkdir -p /var/log/supervisor

RUN yum install -y openssh-server
RUN mkdir -p /var/run/sshd

RUN yum -y update
RUN yum install -y gcc make

RUN yum install -y httpd
RUN mkdir -p /var/lock/apache2 /var/run/apache2

RUN yum install -y php-devel php-mysql php-pdo
RUN yum install -y php-pear php-mbstring
RUN yum install -y php

COPY supervisord.conf /etc/supervisord.conf           
COPY config /config
COPY httpd /etc/sysconfig/httpd


EXPOSE 22 80
CMD ["/usr/bin/supervisord -c /etc/supervisord.conf"]

