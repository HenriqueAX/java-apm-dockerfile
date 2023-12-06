Este repositório contém um Dockerfile para criar uma imagem Docker para executar uma aplicação Java utilizando o OpenJDK 11 com o Elastic APM para monitoramento de desempenho.
<br>

## Funcionamento do Dockerfile

### Imagem e variáveis
A imagem utiliza a imagem base `openjdk:11-jre-slim` e configura diversas variáveis de ambiente para personalizar o ambiente de execução da aplicação:

- **TZ (TimeZone):** Define o fuso horário para "America/Sao_Paulo".
- **APP_FILE:** Nome do arquivo JAR da aplicação, configurado como `myapp.jar`.
- **JAVA_OPTS:** Opções de linha de comando do Java, inicialmente vazias.
- **ELASTIC_APM_SERVICE_NAME:** Nome do serviço para o Elastic APM, configurado como `my-java-app`.
- **ELASTIC_APM_SERVER_URL:** URL do servidor Elastic APM, configurado como `http://apm-server:8200`.
- **ELASTIC_APM_SECRET_TOKEN:** Token secreto para autenticação no servidor Elastic APM, configurado como `your_token`.
- **ELASTIC_APM_APPLICATION_PACKAGES:** Pacotes da aplicação a serem monitorados pelo Elastic APM, configurados como `org.example`.
- **ELASTIC_APM_ENVIRONMENT:** Ambiente da aplicação, configurado como `production`.
<br>

### Instalação de Dependências

O Dockerfile instala as seguintes dependências no sistema operacional da imagem:

**curl:** Ferramenta para transferência de dados com sintaxe URL.
**tzdata:** Informações de fuso horário.
**net-tools:** Ferramentas de rede.
**libpq5:** Biblioteca de cliente PostgreSQL.
<br><br>

### Adição do agente Elastic APM

O Dockerfile adiciona o Elastic APM Agent (versão 1.18.0.RC1) ao diretório raiz da aplicação. O agente é baixado diretamente do Maven Central Repository.
<br><br>

### Copiando a Aplicação

O arquivo JAR da aplicação é copiado para o diretório `/app` na imagem.
<br><br>

### Expondo a Porta 8080

A imagem expõe a porta 8080 para permitir o acesso à aplicação.
<br><br>

### Comando de Execução Padrão

O comando padrão para executar a imagem é configurado para iniciar a aplicação Java com o Elastic APM Agent. As opções do Java (`JAVA_OPTS`), o agente (`-javaagent:/elastic-apm-agent.jar`), a porta do servidor (`-Dserver.port=8080`), e o arquivo JAR da aplicação são todos configurados dinamicamente.

```bash
CMD java ${JAVA_OPTS} -javaagent:/elastic-apm-agent.jar -Dserver.port=8080 -jar ${APP_FILE}
