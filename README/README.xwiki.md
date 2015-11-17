# Config

## /etc/xwiki/xwiki.cfg


## /etc/default/tomcat7

```
  JAVA_OPTS="-Xms800m -Xmx800m -XX:MaxPermSize=196m -Dfile.encoding=utf-8 -Djava.awt.headless=true"
  JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

# Service

```
  /etc/init.d/tomcat7 start
  /etc/init.d/tomcat7 stop
  /etc/init.d/tomcat7 restart
```

# XWiki as root webapp

When doing it make sure to check after upgrade if all is OK in /etc/tomcat7/Catalina/localhost folder (xwiki.xml might be restored).

- Open folder /etc/tomcat7/Catalina/localhost.

- Delete ROOT.xml (if it exists)

- Rename xwiki.xml to ROOT.xml (after this operation you shouldn't have any xwiki.xml link)

- Edit ROOT.xml after renaming, change ..path="/xwiki".. to ..path="/"..

- Save ROOT.xml

- Restart Tomcat

# LDAP

```
DC={{DOMAIN}},DC={{NAME}},DC={{ORG}}
CN={{ CN }},OU={{ OU1 }},OU={{ OU2 }},DC={{DOMAIN}},DC={{NAME}},DC={{ORG}}

sudo tshark -i eth0 host {{ ip_address }}
```
