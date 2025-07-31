# Dockerfile

# 1. Verwende ein offizielles Maven-Java-Image als Basis
FROM maven:3.9.6-eclipse-temurin-17 AS build

# 2. Setze das Arbeitsverzeichnis
WORKDIR /app

# 3. Kopiere alle Dateien ins Image
COPY . .

# 4. Baue das Projekt (führt `mvn clean package` aus)
RUN mvn clean package -DskipTests

# 5. Neues Image nur mit dem fertigen .jar
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# 6. Startbefehl
CMD ["java", "-jar", "app.jar"]
