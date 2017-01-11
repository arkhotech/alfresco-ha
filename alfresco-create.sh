#!/bin/bash

IMAGE=arkhotech:alfresco-ha

if [ -z ${ALFRESCO_STORE} ];
then
        ALFRESCO_STORE=$HOME
fi

ROOT_DATA=$ALFRESCO_STORE
ROOT_CONTENT=$ALFRESCO_STORE


docker run --name='alfresco' -it -d  -p 445:445 -p 7070:7070 -p 8080:8080 -p 8009:8009 \
    -v $ROOT_CONTENT/alfcontent:/content \
    -v $ROOT_DATA/alfdata:/alfresco/alf_data \
    -e JVMROUTE_NAME=alf2 \
    -e CONTENT_STORE=/content \
    -e LDAP_ENABLED=true \
    -e LDAP_AUTH_USERNAMEFORMAT=uid=%s,cn=People,dc=arkhotech,dc=com \
    -e LDAP_URL=ldap://dev3.arkho.tech:389 \
    -e LDAP_DEFAULT_ADMINS=admin \
    -e LDAP_SECURITY_PRINCIPAL=cn=admin,dc=arkhotech,dc=com \
    -e LDAP_SECURITY_CREDENTIALS=toor \
    -e LDAP_GROUP_SEARCHBASE=ou=Groups,dc=arkhotech,dc=com \
    -e LDAP_USER_SEARCHBASE=ou=People,dc=arkhotech,dc=com \
    -e DB_KIND=mysql \
    -e DB_HOST=dev2.arkho.tech \
    -e DB_USERNAME=alfresco \
    -e DB_PASSWORD=7bT6K4IdXD8h \
    -e DB_NAME=alfresco \
    $IMAGE 
