# create databases
CREATE DATABASE keycloak;
CREATE USER 'keycloak'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON keycloak.* TO 'keycloak'@'%';

CREATE DATABASE oc10;
CREATE USER 'oc10'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON oc10.* TO 'oc10'@'%';

