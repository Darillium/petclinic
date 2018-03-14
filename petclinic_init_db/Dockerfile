FROM mysql
MAINTAINER Maxim Avezbakiev <maxim@darillium.io>

COPY db-init.sh /db-init.sh
RUN mkdir /sql_scripts
COPY ./sql_scripts/schema.sql /sql_scripts/schema.sql
COPY ./sql_scripts/data.sql /sql_scripts/data.sql

CMD /db-init.sh
