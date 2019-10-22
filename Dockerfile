FROM tomcat:9.0-jre8

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN rm -Rf /usr/local/tomcat/webapps/ROOT
COPY target/finderpath-1.0.0-BUILD-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
ENV JAVA_OPTS="-Dserver.type=dev"
