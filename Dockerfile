# Commentaire
FROM ubuntu:latest
MAINTAINER Nicolas Maire <trexmaster@trexmaster.fr>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update 

RUN apt-get -y install php5 php5-fpm php5-common php5-apcu \
                       php5-cli php-pear php5-mysql php5-pgsql php5-mongo \
                       php5-memcache php5-memcached php5-gd php5-mcrypt \
                       php-soap php5-common php5-curl php5-geoip php5-gmp \
                       php5-gnupg php5-imagick php5-imap php5-intl php5-json \
                       php5-ldap php5-oauth php5-odbc php5-pspell php5-readline \
                       php5-redis php5-rrd php5-sasl php5-snmp php5-sqlite \
                       php5-xsl php5-ming php5-ps php5-recode php5-tidy \
                       php5-xmlrpc
                   
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/listen = \/var\/run\/php5-fpm\.sock/listen=0.0.0.0:9000/" /etc/php5/fpm/pool.d/www.conf && \
    find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

VOLUME ["/usr/share/nginx/html"]

EXPOSE 9000

WORKDIR /usr/share/nginx/html

CMD ["/usr/sbin/php5-fpm"]
