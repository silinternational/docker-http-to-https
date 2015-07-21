FROM silintl/apache2:latest
MAINTAINER "Phillip Shipley" <phillip_shipley@sil.org>

ENV REFRESHED_AT 2015-07-20

RUN apt-get update -y \
    && apt-get clean

COPY redirect.conf /etc/apache2/sites-enabled/
