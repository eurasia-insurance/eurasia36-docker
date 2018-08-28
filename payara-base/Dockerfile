FROM lapsatech/payara-template
MAINTAINER "Vadim Isaev" <vadim.o.isaev@gmail.com>

# importing keys and tuneup coonection to ESBD

ENV ESBD_KEY_ALIAS eur-ssl-evsyukovd-2

COPY --chown=payara ./esbd_keys/ /tmp/esbd_keys/
RUN keytool -importkeystore \
        -srckeystore /tmp/esbd_keys/keystore.jks -srcstorepass changeit \
        -destkeystore ${CONFIG_DIR}/keystore.jks -deststorepass changeit && \
    keytool -importkeystore \
        -srckeystore /tmp/esbd_keys/trustedstore.jks -srcstorepass changeit \
        -destkeystore ${CONFIG_DIR}/cacerts.jks -deststorepass changeit && \
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
