FROM ubuntu:latest  AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 9090

COPY --from=build /target/api-1.0.0.jar

ENTRYPOINT [ "java", "-jar", "app.jar"]