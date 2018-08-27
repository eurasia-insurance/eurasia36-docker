#!/bin/bash

DIR=`dirname $0`

. $DIR/functions.sh
. $DIR/setting.conf

echo "delete-jvm-options \-Dcom.sun.enterprise.security.httpsOutboundKeyAlias=s1as"
echo "create-jvm-options \-Dcom.sun.enterprise.security.httpsOutboundKeyAlias=eur-ssl-evsyukovd-2"

MYSQL_CRED="$MYSQL_HOST $MYSQL_PORT $MYSQL_USER $MYSQL_PASS"

# JDBC Resources

create-mysql epayment/jdbc/DataSource JDBCEpaymentPool $MYSQL_CRED $EPAYMENT_DB
create-mysql insurance/jdbc/DataSource JDBCInsurancePool $MYSQL_CRED $INSURANCE_DB
create-mysql eurasia/jdbc/DataSource JDBCEurasiaPool $MYSQL_CRED $EURASIA_DB

# JMS Resources

create-queue epayment/jms/events/notifier/paymentLinkUserEmail epayment.events.notifier.paymentLinkUserEmail
create-queue epayment/jms/events/notifier/paymentSuccessUserEmail epayment.events.notifier.paymentSuccessUserEmail
create-queue insurance/jms/events/notifier/cascoNewCompanyEmail insurance.events.notifier.cascoNewCompanyEmail
create-queue insurance/jms/events/notifier/cascoNewUserEmail insurance.events.notifier.cascoNewUserEmail
create-queue insurance/jms/events/notifier/policyNewCompanyEmail insurance.events.notifier.policyNewCompanyEmail
create-queue insurance/jms/events/notifier/policyNewUserEmail insurance.events.notifier.policyNewUserEmail
create-queue insurance/jms/events/notifier/requestPaidCompanyEmail insurance.events.notifier.requestPaidCompanyEmail
create-queue epayment/jms/events/invoicesHasPaid epayment.events.invoicesHasPaid

# JNDI

create-properties epayment/resource/Configuration \
	default-payment-uri.pattern "$PAYMENT_URI"

create-properties epayment/resource/messaging/Configuration \
	mesenger.instance.verb "$MESSENGER_VERB"

create-properties epayment/resource/qazkom/Configuration \
	merchant.id "$QAZKOM_MERCHANT_ID" \
	merchant.name "$QAZKOM_MERCHANT_NAME" \
	merchant.key.keystore "$QAZKOM_MERCHANT_KEYSTORE" \
	merchant.key.storetype JKS \
	merchant.key.storepass "$QAZKOM_MERCHANT_STOREPASS" \
	merchant.key.alias "$QAZKOM_MERCHANT_ALIAS" \
	merchant.cert.keystore "$QAZKOM_MERCHANT_KEYSTORE" \
	merchant.cert.storetype JKS \
	merchant.cert.storepass "$QAZKOM_MERCHANT_STOREPASS" \
	merchant.cert.alias "$QAZKOM_MERCHANT_ALIAS" \
	bank.cert.keystore "$QAZKOM_BANK_KEYSTORE" \
	bank.cert.storetype JKS \
	bank.cert.storepass "$QAZKOM_BANK_STOREPASS" \
	bank.cert.alias "$QAZKOM_BANK_ALIAS" \
	signature.algorithm SHA1withRSA \
	bank.epay.url "$EPAY_URL" \
	bank.epay.template default.xsl

create-properties esbd/resource/Configuration \
	esbd.user.name EUR.SSL.EVSYUKOVD \
	esbd.user.password 1qazxcvbnm \
	esbd.wsdl-location.1 'https://web1.mkb.kz/IICWebservice.asmx?wsdl' \
	esbd.wsdl-location.2 'https://web2.mkb.kz/IICWebservice.asmx?wsdl' \
	esbd.wsdl-location.3 'https://web3.mkb.kz/IICWebservice.asmx?wsdl'

create-properties insurance/resource/messaging/Configuration \
	mesenger.instance.verb "$MESSENGER_VERB"

create-properties insurance/resource/calculation/MRP \
	"2015-01-01" "1982" \
	"2016-01-01" "2121" \
	"2017-01-01" "2269" \
	"2018-01-01" "2405"

create-properties insurance/resource/crm/Configuration \
	'icon-class.utm-source.google' 'fa____fa-google' \
	'icon-class.utm-source.yandex' 'fa____fa-y-combinator' \
	'icon-class.utm-source.facebook' 'fa____fa-facebook' \
	'icon-class.utm-source.instagram' 'fa____fa-instagram' \
	'icon-class.utm-source.youtube' 'fa____fa-youtube' \
	'icon-class.utm-source.theeurasia' 'fa____fa-home' \
	'icon-class.utm-source.eubank' 'fa____fa-etsy' \
	'bank.bin.405709' 'EUBANK' \
	'bank.bin.429438' 'EUBANK' \
	'bank.bin.429439' 'EUBANK' \
	'bank.bin.429440' 'EUBANK' \
	'bank.bin.403259' 'EUBANK' \
	'bank.bin.412464' 'EUBANK' \
	'bank.bin.526994' 'EUBANK' \
	'bank.bin.529818' 'EUBANK' \
	'bank.bin.530496' 'EUBANK' \
	'icon-class.bank.EUBANK' 'fa____fa-trophy____icon-attention'

create-string jsf/ProjectStage $PROJECT_STAGE

# JavaMail Sessions

create-mail epayment/mail/AdminNotification \
    "$ADMIN_MAIL_TYPE" \
    "$ADMIN_MAIL_USER" \
    "$ADMIN_MAIL_PASS" \
    "$ADMIN_MAIL_FROM" \
    "$ADMIN_MAIL_TO" \
    "$ADMIN_MAIL_BCC" \
    true \
    "$ADMIN_MAIL_FORCE" \
    "$ADMIN_MAIL_HOST" \
    "$ADMIN_MAIL_PORT"

create-mail epayment/mail/messaging/UserNotification \
    "$USER_MAIL_TYPE" \
    "$USER_MAIL_USER" \
    "$USER_MAIL_PASS" \
    "$USER_MAIL_FROM" \
    "$USER_MAIL_TO" \
    "$USER_MAIL_BCC" \
    true \
    "$USER_MAIL_FORCE" \
    "$USER_MAIL_HOST" \
    "$USER_MAIL_PORT"

create-mail insurance/mail/messaging/CompanyNotification \
    "$COMPANY_MAIL_TYPE" \
    "$COMPANY_MAIL_USER" \
    "$COMPANY_MAIL_PASS" \
    "$COMPANY_MAIL_FROM" \
    "$COMPANY_MAIL_TO" \
    "$COMPANY_MAIL_BCC" \
    true \
    "$COMPANY_MAIL_FORCE" \
    "$COMPANY_MAIL_HOST" \
    "$COMPANY_MAIL_PORT"

create-mail insurance/mail/messaging/UserNotification \
    "$USER_MAIL_TYPE" \
    "$USER_MAIL_USER" \
    "$USER_MAIL_PASS" \
    "$USER_MAIL_FROM" \
    "$USER_MAIL_TO" \
    "$USER_MAIL_BCC" \
    true \
    "$USER_MAIL_FORCE" \
    "$USER_MAIL_HOST" \
    "$USER_MAIL_PORT"
