FROM ubuntu:latest
RUN apt-get update -y && apt-get install -y apache2
COPY . /var/www/html/

EXPOSE 80

ENTRYPOINT apachectl -D FOREGROUND
