FROM lapsatech/payara-template
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

# importing keys and tuneup coonection to ESBD

ENV ESBD_KEY_ALIAS eur-ssl-evsyukovd-2

COPY --chown=payara ./esbd_keys/ /tmp/esbd_keys/
RUN keytool -importkeystore \
        -srckeystore /tmp/esbd_keys/keystore.jks -srcstorepass changeit \
        -destkeystore ${PAYARA_CONFIG_PATH}/keystore.jks -deststorepass changeit && \
    keytool -importkeystore \
        -srckeystore /tmp/esbd_keys/trustedstore.jks -srcstorepass changeit \
        -destkeystore ${PAYARA_CONFIG_PATH}/cacerts.jks -deststorepass changeit && \
    rm -rf /tmp/esbd_keys && \
    ${PAYARA_PATH}/bin/asadmin start-domain ${PAYARA_DOMAIN} && \
    ${PAYARA_PATH}/bin/asadmin --user ${ADMIN_USER} --passwordfile=${PASSWORD_FILE} \
        delete-jvm-options \-Dcom.sun.enterprise.security.httpsOutboundKeyAlias=s1as && \
    ${PAYARA_PATH}/bin/asadmin --user ${ADMIN_USER} --passwordfile=${PASSWORD_FILE} \
        create-jvm-options \-Dcom.sun.enterprise.security.httpsOutboundKeyAlias=${ESBD_KEY_ALIAS} && \
    ${PAYARA_PATH}/bin/asadmin stop-domain ${PAYARA_DOMAIN} && \
    rm -rf ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/osgi-cache \
           ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/logs/server.log


# copy qazom keys 

COPY --chown=payara ./qazkom_keys/* /etc/pki/kkb/

# create resources

COPY --chown=payara ./resources/ /tmp/resources/
RUN ${PAYARA_PATH}/bin/asadmin start-domain ${PAYARA_DOMAIN} && \
    /tmp/resources/create-resources.sh | ${PAYARA_PATH}/bin/asadmin --user ${ADMIN_USER} --passwordfile=${PASSWORD_FILE} && \
    ${PAYARA_PATH}/bin/asadmin stop-domain ${PAYARA_DOMAIN} && \
    rm -rf ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/osgi-cache \
           ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/logs/server.log \
           /tmp/resources

# run-once scripts

COPY --chown=payara ./run-once/ ${PAYARA_RUN_ONCE_PATH}/


# esbd
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/esbd/esbd-dao-app/2.2.6/esbd-dao-app-2.2.6.ear $AUTODEPLOY_DIR

# epayment
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-dao-app/1.2.4/epayment-dao-app-1.2.4.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-facade-app/1.2.6/epayment-facade-app-1.2.6.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-notification-daemon-app/2.1/epayment-notification-daemon-app-2.1.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/epayment/epayment-ws-app/1.2.3/epayment-ws-app-1.2.3.ear $AUTODEPLOY_DIR

# insurance
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-calculation-app/2.3.2/insurance-calculation-app-2.3.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-dao-app/1.3.2/insurance-dao-app-1.3.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-facade-app/1.4.2/insurance-facade-app-1.4.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-daemon-app/1.3.2/insurance-daemon-app-1.3.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-notification-daemon-app/2.2.2/insurance-notification-daemon-app-2.2.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-ws-app/1.3.2/insurance-ws-app-1.3.2.ear $AUTODEPLOY_DIR
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/insurance/insurance-crm-app/3.3.3/insurance-crm-app-3.3.3.ear $AUTODEPLOY_DIR

# eurasia36
#ADD --chown=payara https://artifactory.lapsa.tech/artifactory/libs-release/tech/lapsa/eurasia36/eurasia36-notification-templates-app/1.1/eurasia36-notification-templates-app-1.1.ear $AUTODEPLOY_DIR
