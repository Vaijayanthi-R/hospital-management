# Multi-stage build for Spring Boot backend

# 1. Build stage using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# copy only what is necessary for dependency resolution first
COPY backend/pom.xml .
RUN mvn dependency:go-offline -B

# copy source and build
COPY backend/src ./src
RUN mvn clean package -DskipTests -B

# 2. Run stage using a lightweight JRE
FROM eclipse-temurin:17-jre
WORKDIR /app
# copy the fat jar produced by spring-boot-maven-plugin
COPY --from=build /app/target/hospital-system-1.0.0.jar app.jar

# expose default port (change if you configure a different one)
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]