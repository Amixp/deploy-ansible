# Postgresql

## User

CREATE ROLE confluenceuser WITH LOGIN CREATEDB CREATEROLE PASSWORD 'confluence_user_pass';

## Db

CREATE DATABASE confluence WITH OWNER confluenceuser TEMPLATE template0 ENCODING 'UTF8' LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';

ALTER ROLE confluenceuser WITH PASSWORD 'confluence_user_pass';

# Key

# Proxy

/opt/atlassian/confluence/conf/catalina.properties

  http.proxyHost=localhost
  http.proxyPort=3128
  https.proxyHost=localhost
  https.proxyPort=3128

