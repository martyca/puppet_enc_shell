#!/bin/bash

fqdn=$1

signedcertsfolder="/etc/puppetlabs/puppet/ssl/ca/signed/"
Signedcert="${signedcertsfolder}${fqdn}.pem"
opensslcmd="openssl x509 -noout -text -certopt no_subject,no_header,no_version,no_serial,no_signame,no_validity,no_subject,no_issuer,no_pubkey,no_sigdump,no_aux -in"

environment=$(${opensslcmd} ${Signedcert} | awk '/1.3.6.1.4.1.34380.1.1.12:/{x=NR+1;next}{NR<=x}{print}' | tr -d ' |.')

cat << EOF
---
  classes:
    role::${role}:
  environment: ${environment}
EOF

