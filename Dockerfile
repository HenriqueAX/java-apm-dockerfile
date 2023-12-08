# Use a imagem Maven oficial para compilação
FROM maven:3.8.4 AS build

WORKDIR /build

# Copie o arquivo pom.xml e baixe as dependências
COPY pom.xml .
RUN mvn dependency:go-offline

# Copie o código-fonte e compile o aplicativo
COPY src/ /build/src/
RUN mvn package

# Imagem final com OpenJDK
FROM openjdk:11-jre-slim

ENV TZ=America/Sao_Paulo \
    APP_FILE=myapp.jar \
    JAVA_OPTS="-Djdk.tls.client.protocols=TLSv1 -Dhttps.protocols=TLSv1 -Dcom.mysql.cj.protocol.TlsProtocol=TLSv1.0 -Djavax.net.ssl.ciphers=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
#    ELASTIC_APM_SERVICE_NAME=my-java-app \
#    ELASTIC_APM_SERVER_URL=http://apm-server:8200 \
#    ELASTIC_APM_SECRET_TOKEN=your_token \
#    ELASTIC_APM_APPLICATION_PACKAGES=org.example \
#    ELASTIC_APM_ENVIRONMENT=production

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    tzdata \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Adicione o JAR compilado diretamente à imagem final
COPY --from=build /build/target/*.jar /app/bin.jar

#ADD https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/1.18.0.RC1/elastic-apm-agent-1.18.0.RC1.jar /elastic-apm-agent.jar

EXPOSE 8080

CMD java ${JAVA_OPTS} -Dserver.port=8080 -jar bin.jar

