FROM maven:3.8.4 AS build

WORKDIR /build

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ /build/src/
RUN mvn package

FROM openjdk:11-jre-slim

ENV TZ=America/Sao_Paulo \
    APP_FILE=myapp.jar \
    JAVA_OPTS="-Djdk.tls.client.protocols=TLSv1 -Dhttps.protocols=TLSv1"
    ELASTIC_APM_SERVICE_NAME=my-java-app \
    ELASTIC_APM_SERVER_URL=http://apm-server:8200 \
    ELASTIC_APM_SECRET_TOKEN=your_token \
    ELASTIC_APM_APPLICATION_PACKAGES=org.example \
    ELASTIC_APM_ENVIRONMENT=production

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    tzdata \
    net-tools \
    && rm -rf /var/lib/apt/lists/*


COPY mysql/ssl/ /app/ssl/

COPY --from=build /build/target/*.jar /app/bin.jar

ADD https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/1.18.0.RC1/elastic-apm-agent-1.18.0.RC1.jar /elastic-apm-agent.jar

EXPOSE 8080

CMD java ${JAVA_OPTS} -Dserver.port=8080 -jar bin.jar

