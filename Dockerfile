﻿FROM php:7.2.17-apache-stretch

﻿ENV VERSION 9.4.2

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y zlib1g-dev libpng-dev libc-client-dev libkrb5-dev libicu-dev libpcre3-dev libcurl4-openssl-dev y libldap2-dev libxml2 libxml2-dev libxpm-dev libxslt1-dev wget jq && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl

RUN a2enmod rewrite && \
docker-php-ext-install mysqli gd imap intl curl ﻿ldap xmlrpc exif

RUN pecl install apcu-5.1.5

RUN docker-php-ext-enable apcu opcache

RUN wget -O /tmp/glpi.tar.gz $(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${VERSION} | jq .assets[0].browser_download_url | tr -d \") && \
tar -xzf /tmp/glpi.tar.gz -C /var/www && \
rm -rf /tmp/glpi.tar.gz /var/www/html && \
mv /var/www/glpi /var/www/html && \
chown -R www-data:www-data /var/www/html

RUN echo "nerror_reporting = E_ALL\nerror_log = /var/log/apache2/php_errors.log\n" > /usr/local/etc/php/php.ini
