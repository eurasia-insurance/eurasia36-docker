FROM mariadb
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

VOLUME /var/lib/mysql

ENV MYSQL_ROOT_PASSWORD changeit
ENV MYSQL_USER eurasia36
ENV MYSQL_PASSWORD eurasia36

COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
