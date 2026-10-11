# syntax=docker/dockerfile:1

# Giai đoạn 1: build JAR bằng Gradle Wrapper (JDK 17 Temurin)
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY gradlew gradlew.bat settings.gradle build.gradle ./
COPY gradle ./gradle
COPY src ./src
RUN chmod +x gradlew && ./gradlew bootJar --no-daemon

# Giai đoạn 2: chạy ứng dụng với JRE 17 nhẹ
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
