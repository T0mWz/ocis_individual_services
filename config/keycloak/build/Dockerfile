# Version     : 0.1
# Purpose     : Create OpenLDAP server for ownCloud
# Description : Create OpenLDAP server for ownCloud
# Usage       : This file is used by the ci street

# Keycloak WildFly distribution, Quarkus is not ready yet for automatic setup https://github.com/keycloak/keycloak/issues/10216
FROM quay.io/keycloak/keycloak:18.0.0-legacy

#######################################
# Install extra packages

USER root
RUN microdnf install -y gzip openssl xz zstd findutils ; microdnf clean all
RUN key='859BE8D7C586F538430B19C2467B942D3A79BD29'; export GNUPGHOME="$(mktemp -d)"; gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; gpg --batch --export --armor "$key" > /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql; rm -rf "$GNUPGHOME"

RUN . /etc/os-release; 	{ echo '[mysql8.0-server-minimal]'; echo 'name=MySQL 8.0 Server Minimal'; echo 'enabled=1'; echo "baseurl=https://repo.mysql.com/yum/mysql-8.0-community/el/${VERSION_ID%%[.-]*}/\$basearch/"; echo 'gpgcheck=1'; echo 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql'; echo 'module_hotfixes=true'; } | tee /etc/yum.repos.d/mysql-community-minimal.repo
RUN microdnf install -y "mysql-community-client"; microdnf clean all

# change the user back to jboss
USER jboss

#######################################
# Copy own Realm config
COPY docker-entrypoint-override.sh /opt/jboss/tools/docker-entrypoint-override.sh
COPY owncloud-realm.dist.json /opt/jboss/keycloak/owncloud-realm.dist.json
COPY keycloak_init.sh /opt/jboss/keycloak/bin/keycloak_init.sh

#######################################
# Work
ENTRYPOINT ["/bin/sh", "/opt/jboss/tools/docker-entrypoint-override.sh"]
