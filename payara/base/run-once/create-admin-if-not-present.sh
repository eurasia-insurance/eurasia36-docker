#!/bin/bash

cp ${PASSWORD_FILE} /tmp/adminuserpwd.txt && \
echo "AS_ADMIN_USERPASSWORD=admin" >> /tmp/adminuserpwd.txt && \
${PAYARA_PATH}/bin/asadmin start-domain ${PAYARA_DOMAIN} && \
    { test -z $(${PAYARA_PATH}/bin/asadmin --user ${ADMIN_USER} --passwordfile=/tmp/adminuserpwd.txt list-file-users | grep "^admin") && \
        ${PAYARA_PATH}/bin/asadmin --user ${ADMIN_USER} --passwordfile=/tmp/adminuserpwd.txt \
            create-file-user --groups insurance-admin:epayment-admin admin; } && \
${PAYARA_PATH}/bin/asadmin stop-domain ${PAYARA_DOMAIN} && \
rm -rf ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/osgi-cache \
       ${PAYARA_PATH}/glassfish/domains/${PAYARA_DOMAIN}/logs/server.log \
       /tmp/adminuserpwd.txt
