# Stage 1: Build the app
FROM maven:3.9.5-eclipse-temurin-17 AS builder
WORKDIR /app
RUN git clone https://github.com/gowsat18/onlinebookstore.git .
RUN ls -la
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0
COPY --from=builder /app/target/onlinebookstore.war /usr/local/tomcat/webapps/onlinebookstore.war
EXPOSE 8081
CMD ["catalina.sh", "run"]
