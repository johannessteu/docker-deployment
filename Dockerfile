# DOCKER-VERSION 1.2.0

FROM ubuntu
MAINTAINER Johannes Steu <js@johannessteu.de>

RUN apt-get update && apt-get -y install git apache2 php5 curl && apt-get clean

RUN echo 'date.timezone = "Europe/Berlin"' >> /etc/php5/cli/php.ini

RUN mkdir -p /root/.ssh
ADD SSH/known_hosts /root/.ssh/known_hosts
ADD SSH/docker /root/.ssh/id_rsa
ADD SSH/docker.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa
RUN cd /var/www && git clone ssh://git@johannessteu.de:10022/essentials/deployment.git
RUN curl -s https://getcomposer.org/installer | php &&  mv composer.phar /usr/local/bin/composer
RUN cd /var/www/deployment && composer install