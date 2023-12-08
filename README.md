## Dockerfile para Aplicação Java com Elastic APM e suporte a TLS 1.0

Este repositório contém um Dockerfile para criar uma imagem Docker que executa uma aplicação Java utilizando o OpenJDK 11. Esta imagem é configurada para suportar conexões TLS 1.0 e integra-se com o Elastic APM para monitoramento de desempenho.

## Funcionamento do Dockerfile

### Construção e Execução da Aplicação

- **Fase de Construção (Maven):** A primeira fase do Dockerfile utiliza a imagem `maven:3.8.4` para compilar o aplicativo Java. O arquivo `pom.xml` e o código-fonte são copiados para a imagem, e o projeto é compilado.

- **Fase de Execução (OpenJDK):** A segunda fase utiliza a imagem `openjdk:11-jre-slim` para executar o aplicativo compilado.

### Configurações de Ambiente e Dependências

- **Configurações de Ambiente:**
  - `TZ`: Define o fuso horário para "America/Sao_Paulo".
  - `APP_FILE`: Especifica o nome do arquivo JAR da aplicação como `myapp.jar`.
  - `JAVA_OPTS`: Contém opções da JVM para suportar TLS 1.0.
  - Configurações do Elastic APM: Inclui informações como nome do serviço, URL do servidor, token secreto, pacotes da aplicação e ambiente.

- **Instalação de Dependências:**
  - Ferramentas como `curl`, `tzdata` e `net-tools` são instaladas.

### Configuração do Elastic APM

- O agente Elastic APM (versão 1.18.0.RC1) é adicionado ao diretório raiz da aplicação, sendo baixado diretamente do Maven Central Repository.

### Preparação da Aplicação

- Os certificados SSL necessários para a conexão TLS 1.0 são copiados para o diretório `/app/ssl/` dentro da imagem.
- O arquivo JAR compilado é copiado para o diretório `/app`.

### Exposição da Porta e Execução

- **Porta 8080:** A imagem expõe a porta 8080, que é a porta padrão para aplicações web.
- **Comando de Execução:** A imagem é configurada para executar a aplicação Java com as opções de TLS 1.0, Elastic APM e outras configurações necessárias.

```bash
CMD java ${JAVA_OPTS} -javaagent:/elastic-apm-agent.jar -Dserver.port=8080 -jar ${APP_FILE}

## Projeto Java para testes

O projeto também possui uma pequena aplicação em Java para que seja testado o Dockerfile. O que ela faz é basicamente tentar uma conexão com um banco MySQL e em seguida retornar se a conexão foi bem sucedida ou não.
