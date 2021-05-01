FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM adoptopenjdk/openjdk11:alpine
COPY --from=build /home/app/target/plothub-0.0.1-SNAPSHOT.jar /usr/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app.jar"]