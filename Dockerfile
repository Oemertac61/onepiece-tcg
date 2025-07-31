FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/characterdb-0.0.1-SNAPSHOT.jar app.jar

# 👉 Neue Lösung: direkt als -jar starten, ABER korrekten Namen verwenden
ENTRYPOINT ["java", "-jar", "app.jar"]
