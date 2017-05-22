#!/bin/sh

JAVA_HOME=/opt/ibm/ibm-java-x86_64-60
CLASSPATH=$(echo lib/*.jar | tr ' ' ':')

$JAVA_HOME/bin/java -cp $CLASSPATH com.ibm.custom.XML2PDF samples/incident.xml samples/inc2fo.xsl samples/incident.pdf etc/fop.xconf

