#!/bin/bash

# replace owncloud domain in keycloak realm import
cp /opt/jboss/keycloak/owncloud-realm.dist.json /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/cloud.owncloud.test/${CLOUD_DOMAIN}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/oc10-oidc-secret/${OC10_OIDC_CLIENT_SECRET}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/ldap-bind-host/${LDAP_HOSTNAME}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/ldap-bind-userdn/${LDAP_ADMIN_USERDN}/g" /opt/jboss/keycloak/owncloud-realm.json #cn=admin,dc=owncloud,dc=com
sed -i "s/ldap-bind-credential/${LDAP_ADMIN_PASSWORD}/g" /opt/jboss/keycloak/owncloud-realm.json #admin

# Overwrite SURFconext attributes
sed -i "s/SURFCONEXT_ENABLED/${SURFCONEXT_ENABLED}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s+SURFCONEXT_USERINFO_URL+${SURFCONEXT_USERINFO_URL}+g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/SURFCONEXT_CLIENTID/${SURFCONEXT_CLIENTID}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s/SURFCONEXT_SECRET/${SURFCONEXT_SECRET}/g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s+SURFCONEXT_TOKENURL+${SURFCONEXT_TOKENURL}+g" /opt/jboss/keycloak/owncloud-realm.json
sed -i "s+SURFCONEXT_AUTHURL+${SURFCONEXT_AUTHURL}+g" /opt/jboss/keycloak/owncloud-realm.json


# Fix
# REPLACE INTO REALM_ATTRIBUTE (NAME,REALM_ID,VALUE) VALUES ('frontendUrl','a25d3e23-67bf-437f-9d7e-3ec3d5ed9838','https://keycloak-rd-app-acc.data.surfsara.nl/auth/')
# update REALM_ATTRIBUTE set VALUE = "frame-src 'self' http://127.0.0.1 http://localhost *.data.surfsara.nl http://keycloak-rd-app-acc.data.surfsara.nl localhost; frame-ancestors 'self'; object-src 'none';" where NAME = "_browser_header.contentSecurityPolicy";


# run original docker-entrypoint
/opt/jboss/tools/docker-entrypoint.sh
#tail -f /dev/null
