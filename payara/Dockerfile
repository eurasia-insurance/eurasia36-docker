FROM payara/server-full
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

ADD --chown=payara http://central.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.2.6/mariadb-java-client-2.2.6.jar glassfish/domains/domain1/lib/

COPY --chown=payara ./keys/ /app/keys/
RUN /app/keys/import-keys.sh

COPY --chown=payara ./resources/ /app/resources/
RUN /app/resources/create-resources.sh >> $POSTBOOT_COMMANDS

# esbd
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/esbd/esbd-dao-app/2.2.6/esbd-dao-app-2.2.6.ear $AUTODEPLOY_DIR

# epayment
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-dao-app/1.2.4/epayment-dao-app-1.2.4.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-facade-app/1.2.6/epayment-facade-app-1.2.6.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-notification-daemon-app/2.1/epayment-notification-daemon-app-2.1.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-ws-app/1.2.3/epayment-ws-app-1.2.3.ear $AUTODEPLOY_DIR

# insurance
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-calculation-app/2.3.2/insurance-calculation-app-2.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-dao-app/1.3.2/insurance-dao-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-facade-app/1.4.2/insurance-facade-app-1.4.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-daemon-app/1.3.2/insurance-daemon-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-notification-daemon-app/2.2.2/insurance-notification-daemon-app-2.2.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-ws-app/1.3.2/insurance-ws-app-1.3.2.ear $AUTODEPLOY_DIR
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-crm-app/3.3.3/insurance-crm-app-3.3.3.ear $AUTODEPLOY_DIR

# eurasia36
ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/eurasia36/eurasia36-notification-templates-app/1.1/eurasia36-notification-templates-app-1.1.ear $AUTODEPLOY_DIR
