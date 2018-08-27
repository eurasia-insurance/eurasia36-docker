FROM payara/server-full
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

ADD --chown=payara http://central.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.2.6/mariadb-java-client-2.2.6.jar glassfish/domains/domain1/lib/

COPY --chown=payara ./keys/ /app/keys/
RUN /app/keys/import-keys.sh

COPY --chown=payara ./resources/ /app/resources/
RUN /app/resources/create-resources.sh >> $POSTBOOT_COMMANDS

ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/esbd/esbd-dao-app/2.2.6/esbd-dao-app-2.2.6.ear $AUTODEPLOY_DIR
