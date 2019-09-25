#!/bin/bash

ocspd_dir="/usr/local/ocspd"
cd ${ocspd_dir}
mountCertDir="/data/ocspd"
file_cacert="ca.crt"
file_cert="ocspd.crt"
file_certkey="ocspd.key"
file_cacrl="crl.crl"
msg_addVolume="please add volume \`${mountCertDir}\` with \`${file_cacert}\`, \`${file_cert}\`, \`${file_certkey}\` and \`${file_cacrl}\` to container"

if [ -f "${mountCertDir}/${file_cacert}" ]
then
	if [ ! -f "${ocspd_dir}/etc/ocspd/certs/${file_cacert}" ]
	then
		ln -s ${mountCertDir}/${file_cacert}  ${ocspd_dir}/etc/ocspd/certs/${file_cacert}
	fi
else
	echo "\`${mountCertDir}/${file_cacert}\` not found: ${msg_addVolume}"
	exit 1
fi

if [ -f "${mountCertDir}/${file_cert}" ]
then
	if [ ! -f "${ocspd_dir}/etc/ocspd/certs/${file_cert}" ]
	then
		ln -s ${mountCertDir}/${file_cert}  ${ocspd_dir}/etc/ocspd/certs/${file_cert}
	fi
else
	echo "\`${mountCertDir}/${file_cert}\` not found: ${msg_addVolume}"
	exit 1
fi

if [ -f "${mountCertDir}/${file_certkey}" ]
then
	if [ ! -f "${ocspd_dir}/etc/ocspd/private/${file_certkey}" ]
	then
		ln -s ${mountCertDir}/${file_certkey}  ${ocspd_dir}/etc/ocspd/private/${file_certkey}
	fi
else
	echo "\`${mountCertDir}/${file_certkey}\` not found: ${msg_addVolume}"
	exit 1
fi

if [ -f "${mountCertDir}/${file_cacrl}" ]
then
	if [ ! -f "${ocspd_dir}/etc/ocspd/crls/${file_cacrl}" ]
	then
		ln -s ${mountCertDir}/${file_cacrl}  ${ocspd_dir}/etc/ocspd/crls/${file_cacrl}
	fi
else
	echo "\`${mountCertDir}/${file_cacrl}\` not found: ${msg_addVolume}"
	exit 1
fi

mkdir -p ${ocspd_dir}/var/log
chown -R ocspd:ocspd ${ocspd_dir}/

sleep 1

${ocspd_dir}/sbin/ocspd -stdout -c ${ocspd_dir}/etc/ocspd/ocspd.xml -v -debug 2>&1 | tee -a ${ocspd_dir}/var/log/ocspd.log
