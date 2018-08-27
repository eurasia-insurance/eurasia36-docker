#!/bin/bash

cmd_prefix="echo"

# PUBLIC

create-mysql() {
	local jndi=$1
	local pool=$2
	local host=$3
	local port=$4
	local user=$5
	local pass=$6
	local db=$7
	__create-mysql-pool $pool $host $port $user $pass $db
	__create-jdbc-resource $jndi $pool 
}

drop-mysql() {
	local jndi=$1
	local pool=$2
	__drop-jdbc $jndi $pool
}

create-jms() {
	local jndi=$1
	local pool=$2
	__create-jms-pool $pool
	__create-jms-connector-resource $jndi $pool 
}

drop-jms() {
	local jndi=$1
	local pool=$2
	__drop-jms-connector-resource $jndi
	__drop-jms-pool $pool
}

create-queue() {
	local jndi=$1
	local queue=$2
	__create-jms-resource $jndi javax.jms.Queue "$queue"
}

drop-queue() {
	local jndi=$1
	__drop-jms-resource $jndi
}

create-topic() {
	local jndi=$1
	local topic=$2
	__create-jms-resource $jndi javax.jms.Topic "$topic"
}

drop-topic() {
	local jndi=$1
	__drop-jms-resource $jndi
}

create-mail() {
    local jndi=$1
    local type=$2
    case "$type" in
	"GMAIL")

		local mail_user=$3
		local mail_password=$4
		local mail_from=$5
		local mail_to=$6
		local mail_bcc=$7
		local mail_debug=$8
		local mail_forceto=$9

		local gmail_host=smtp.gmail.com
		local gmail_port=465

		__create-mail "$jndi" "$gmail_host" "$gmail_port" "$mail_user" "$mail_password" "$mail_from" "$mail_to" "$mail_bcc" "$mail_debug" "$mail_forceto" \
			mail.transport.protocol smtps \
			mail.smtps.class com.sun.mail.smtp.SMTPSSLTransport \
			mail.smtps.auth true \
			mail.smtps.host "$gmail_host" \
			mail.smtps.port "$gmail_port" \
			mail.smtps.starttls.enable true

	;;
	"MAIL")

		local mail_user=$3
		local mail_password=$4
		local mail_from=$5
		local mail_to=$6
		local mail_bcc=$7
		local mail_debug=$8
		local mail_forceto=$9

		local mail_host=${10}
		local mail_port=${11}

		__create-mail "$jndi" "$mail_host" "$mail_port" "$mail_user" "$mail_password" "$mail_from" "$mail_to" "$mail_bcc" "$mail_debug" "$mail_forceto" \
			mail.smtp.host "$mail_host" \
			mail.smtp.port "$mail_port"

	;;
    esac
}

drop-mail() {
	local jndi=$1
	__drop-mail $jndi
}

create-properties() {
	local jndi=$1
	shift
	__create-custom $jndi java.util.Properties org.glassfish.resources.custom.factory.PropertiesFactory $@
}

drop-properties() {
	local jndi=$1
	__drop-custom $jndi
}


create-string() {
	local jndi=$1
	local value=$2
	__create-custom $jndi java.lang.String org.glassfish.resources.custom.factory.PrimitivesAndStringFactory value "$value"
}

drop-string() {
	local jndi=$1
	__drop-custom $jndi
}

# PRIVATE

__create-jdbc-pool() {
	local pool=$1
	local datasourceclassname=$2
	local props=$3
	$cmd_prefix create-jdbc-connection-pool \
		$cmd_option \
		--datasourceclassname=$datasourceclassname \
		--restype=javax.sql.XADataSource \
		--property \"$props\" \
		$pool
}

__create-mysql-pool() {
	local pool=$1
	local server=$2
	local port=$3
	local user=$4
	local pass=$5
	local db=$6
	__create-jdbc-pool $pool org.mariadb.jdbc.MySQLDataSource "serverName=$server:portNumber=$port:user=$user:password=$pass:databaseName=$db" 
}

__drop-jdbc-pool() {
	local pool=$1
	$cmd_prefix delete-jdbc-connection-pool \
		$cmd_option \
		$pool
}

__create-jdbc-resource() {
	local jndi=$1
	local pool=$2
	$cmd_prefix create-jdbc-resource \
		$cmd_option \
		--connectionpoolid $pool \
		--enabled=true \
		$jndi
}

__drop-jdbc-resource() {
	local jndi=$1
	$cmd_prefix delete-jdbc-resource \
		$cmd_option \
		$jndi
}

__drop-jdbc() {
	local jndi=$1
	local pool=$2
	__drop-jdbc-resource $jndi
	__drop-jdbc-pool $pool
}

__create-mail() {
	local jndi=$1
	shift

	local parstr=""

	local mail_host=$1
	shift
	local mail_port=$1
	shift
	local mail_user=$1
	shift
	local mail_password=$1
	test -n "$mail_password" && parstr="$parstr:mail.password=$mail_password"
	shift
	local mail_from=$1
	test -n "$mail_from" && parstr="$parstr:mail.from=$mail_from"
	shift
	local mail_to=$1
	test -n "$mail_to" && parstr="$parstr:mail.to=$mail_to"
	shift
	local mail_bcc=$1
	test -n "$mail_bcc" && parstr="$parstr:mail.bcc=$mail_bcc"
	shift
	local mail_debug=$1
	test -n "$mail_debug" && parstr="$parstr:mail.debug=$mail_debug"
	shift
	local mail_forceto=$1
	test -n "$mail_forceto" && parstr="$parstr:mail.forceto=$mail_forceto"
	shift
	local props=$(__props-str $@)

	test -n "$parstr" && parstr=${parstr:1} # remove first ':'

	$cmd_prefix create-javamail-resource \
		$cmd_option \
		--mailhost=$mail_host \
		--mailuser=$mail_user \
		--debug=$mail_debug \
		--fromaddress=$mail_from \
		--property \"$parstr:$props\" \
		$jndi
}

__drop-mail() {
	local jndi=$1
	$cmd_prefix delete-javamail-resource \
		$cmd_option \
		$jndi
}

__create-jms-pool() {
	local pool=$1
	$cmd_prefix create-connector-connection-pool \
		$cmd_option \
		--raname jmsra \
		--connectiondefinition javax.jms.ConnectionFactory \
		$pool
}

__drop-jms-pool() {
	local pool=$1
	$cmd_prefix delete-connector-connection-pool \
		$cmd_option \
		$pool
}

__create-jms-connector-resource() { 
	local jndi=$1
	local pool=$2
	$cmd_prefix create-connector-resource \
		$cmd_option \
		--poolname $pool \
		--enabled=true \
		$jndi
}

__drop-jms-connector-resource() {
	local jndi=$1
	local pool=$2
	$cmd_prefix delete-connector-resource \
		$cmd_option \
		$jndi
}

## JMS-RESOURCE

__create-jms-resource() {
	local jndi=$1
	local type=$2
	local name=$(__escape-prop "$3")
	$cmd_prefix create-admin-object \
		$cmd_option \
		--restype $type \
		--raname jmsra \
		--enabled=true \
		--property \"Name=$name\" \
		$jndi
}

__drop-jms-resource() {
	local jndi=$1
	$cmd_prefix delete-admin-object \
		$cmd_option \
		$jndi
}

__create-custom() {
	local jndi=$1
	local type=$2
	local factory=$3
	shift
	shift
	shift
	local props=$(__props-str $@)
	$cmd_prefix create-custom-resource \
		 $cmd_option \
		--restype $type \
		--factoryclass $factory \
		--enabled=true \
		--property \"$props\" \
		 $jndi
}

__drop-custom() {
	local jndi=$1
	$cmd_prefix delete-custom-resource \
		 $cmd_option \
		 $jndi
}

__escape-prop() {
	local val=$1
	val=${val//\\/\\\\\\\\}
	val=${val//:/\\:}
	val=${val//=/\\=}
	echo $val
}

__props-str() {
	local ret=""
	while (( $# > 0 ))
	do
		local key=$(__escape-prop "$1")
		shift
		local val=$(__escape-prop "$1")
		ret="$ret$key=$val"
		if (( $# > 1))
		then
			ret="$ret:"
		fi
		shift
	done
	echo $ret
}
