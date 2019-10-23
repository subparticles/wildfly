FROM jboss/wildfly:17.0.1.Final

USER root
RUN yum install -y epel-release gdal bzip2 && yum clean all

USER jboss
ENV LANG C.UTF-8

RUN mkdir -p /opt/jboss/wildfly/modules/org/postgresql/main/
ADD --chown=jboss:jboss module.xml /opt/jboss/wildfly/modules/org/postgresql/main/

RUN curl -L https://jdbc.postgresql.org/download/postgresql-42.2.6.jar -o /opt/jboss/wildfly/modules/org/postgresql/main/postgresql-42.2.6.jar

RUN /opt/jboss/wildfly/bin/add-user.sh admin admin1234 --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
