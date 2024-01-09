FROM silintl/ubuntu:22.04
LABEL maintainer="devon_mccarty@sil.org"

ENV REFRESHED_AT 2024-01-09
ENV HTTPD_PREFIX /etc/apache2

# Install apache2
RUN apt-get update -y \
	&& apt-get install -y \
        openssl \
		apache2 \
    && apt-get clean

# Remove default site, configs, and mods not needed
WORKDIR $HTTPD_PREFIX
RUN a2dissite 000-default \
    && a2disconf serve-cgi-bin.conf \
    && a2enmod expires \
    && a2enmod headers \
    && a2enmod rewrite \
    && a2dismod -f autoindex \
    && service apache2 restart

COPY redirect.conf /etc/apache2/sites-enabled/

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
