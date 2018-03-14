FROM mysql
MAINTAINER Maxim Avezbakiev <maxim@darillium.io>

COPY migrate.sh /migrate.sh
RUN mkdir /sql_scripts
COPY ./sql_scripts/schema.sql /sql_scripts/schema.sql
COPY ./sql_scripts/data.sql /sql_scripts/data.sql

CMD /migrate.sh
