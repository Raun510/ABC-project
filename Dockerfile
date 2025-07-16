FROM tomcat:9.0.50-jdk11

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy app WAR
COPY target/app.war /usr/local/tomcat/webapps/app.war

# Copy manager UI
COPY manager /usr/local/tomcat/webapps/manager

# Remove IP restriction for external access
RUN sed -i 's/className="org.apache.catalina.valves.RemoteAddrValve"/<!-- &/' /usr/local/tomcat/webapps/manager/META-INF/context.xml

# Add credentials
COPY tomcat-users.xml /usr/local/tomcat/conf/

EXPOSE 8080
CMD ["catalina.sh", "run"]
