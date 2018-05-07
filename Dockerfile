FROM autodoc/php7.1-apache

MAINTAINER haritsrahman <haritzrahman98@gmail.com>

RUN apt-get update -y

RUN apt-get install -y php7.1-mbstring php7.1-xml php7.1-mcrypt php7.1-json

RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2enmod rewrite

ADD 000-laravel.conf /etc/apache2/sites-available/

ADD 001-laravel-ssl.conf /etc/apache2/sites-available/

RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite 000-laravel 001-laravel-ssl

RUN /usr/local/bin/composer create-project laravel/laravel /var/www/laravel --prefer-dist
RUN /bin/chown www-data:www-data -R /var/www/laravel/storage

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
