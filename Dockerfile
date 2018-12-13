FROM php:7.0-apache

COPY html/ /www

ENV APACHE_DOCUMENT_ROOT /www

RUN echo "USER www-data" >> /etc/apache2/apache2.conf

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN sed -i.bak 's/Listen\(.*\)80/Listen 8080/' /etc/apache2/ports.conf
RUN sed -i.bak 's/Listen\(.*\)443/Listen 8443/' /etc/apache2/ports.conf

RUN sed -i.bak 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i.bak 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-available/000-default.conf
RUN sed -i.bak 's/<VirtualHost _default_:443>/<VirtualHost _default_:8443>/' /etc/apache2/sites-available/default-ssl.conf

# support running as arbitrary user which belogs to the root group
RUN chmod og+rwx /var/run/apache2 /var/lock/apache2

# Set Workdir
WORKDIR /www

# Expose ports
EXPOSE 8080
#EXPOSE 8443
