FROM centos:7.6.1810
MAINTAINER ccondit@randomcoder.com

ENV MAVEN_VERSION=3.6.3
ENV JAVA_HOME=/opt/java/jdk11
ENV MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}
ENV PATH=/opt/java/jdk11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN \	
	yum clean metadata && \
	yum -y install epel-release && \
	yum clean metadata && \
	yum -y install make which tar rpm-build yum-utils python-argparse python-yaml gcc gcc-c++ createrepo && \
	yum clean all

RUN \
	mkdir -p /download && \
	curl -L -o /download/jdk.tar.gz 'https://api.adoptopenjdk.net/v2/binary/releases/openjdk11?openjdk_impl=hotspot&os=linux&arch=x64&release=latest&type=jdk' && \
	curl -o /download/apache-maven-${MAVEN_VERSION}-bin.tar.gz http://apache.cs.utah.edu/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	mkdir -p /opt/java && \
	cd /opt/java && \
	tar -zxvf /download/jdk.tar.gz && \
	rm -f /download/jdk.tar.gz && \
	mv jdk-* jdk11 && \
	chown -R root:root jdk11 && \
	mkdir -p /download && \
	cd /opt && \
	tar -zxf /download/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	rm -rf /download/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	ln -sf "${MAVEN_HOME}/bin/mvn" /usr/bin/mvn

