#!/bin/bash

DIR=`dirname $0`

keytool -importkeystore \
        -srckeystore $DIR/keystore.jks -srcstorepass changeit \
        -destkeystore glassfish/domains/domain1/config/keystore.jks -deststorepass changeit \
        || exit 1

keytool -importkeystore \
        -srckeystore $DIR/cacerts.jks -srcstorepass changeit \
        -destkeystore glassfish/domains/domain1/config/cacerts.jks -deststorepass changeit \
        || exit 1
