FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B clean package

FROM tomcat:9.0-jdk17-temurin

WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*
COPY --from=build /app/target/rublinmart.war webapps/ROOT.war

EXPOSE 10000
CMD ["sh", "-c", "mkdir -p /usr/local/tomcat/data && sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-10000}\\\"/\" /usr/local/tomcat/conf/server.xml && exec catalina.sh run"]
