FROM php:7.3-apache
RUN apt-get update \
  	&& apt-get install -y zlib1g-dev libicu-dev g++ zip unzip git \
  		libc-client-dev libkrb5-dev \
  		libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev sendmail \
 	&& rm -r /var/lib/apt/lists/* \
 	&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
 	&& docker-php-ext-install imap \
    && docker-php-ext-install gd mysqli intl opcache \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install apcu \
    && docker-php-ext-enable apcu imap
RUN a2enmod rewrite
