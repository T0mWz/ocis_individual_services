#!/bin/bash

# Generate Admin Password
#ADMIN_PASS=`cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 20; echo;`
#/opt/jboss/keycloak/bin/add-user-keycloak.sh -r master -u admin -p ${ADMIN_PASS}

# Get master realm
MASTER_REALM=`mysql --host=${DB_ADDR} --user=${DB_USER} --password=${DB_PASSWORD} ${DB_DATABASE} --skip-column-names -e "select DISTINCT REALM_ID from REALM_ATTRIBUTE where REALM_ID != 'owncloud';"`

# Update frontend url 
mysql --host=${DB_ADDR} --user=${DB_USER} --password=${DB_PASSWORD} ${DB_DATABASE} --skip-column-names -e "REPLACE INTO REALM_ATTRIBUTE (NAME,REALM_ID,VALUE) VALUES ('frontendUrl','${MASTER_REALM}','https://${KEYCLOAK_URL}/auth/')"

# Update KeyCloak CSP attribuut
mysql --host=${DB_ADDR} --user=${DB_USER} --password=${DB_PASSWORD} ${DB_DATABASE} --skip-column-names -e "UPDATE REALM_ATTRIBUTE SET VALUE = \"frame-src 'self' http://127.0.0.1 http://localhost *.data.surfsara.nl localhost; frame-ancestors 'self'; object-src 'none';\" where NAME = \"_browser_header.contentSecurityPolicy\" AND REALM_ID = \"${MASTER_REALM}\";"

#echo "KeyCloak Admin password is: " ${ADMIN_PASS}
#echo "Restart KeyCloak now."



