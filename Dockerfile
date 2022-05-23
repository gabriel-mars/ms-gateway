# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine

# Add Maintainer Info
LABEL maintainer="gabrielmartins"

# Add a volume pointing to /tmp
VOLUME /tmp

# Copy the tmplication's jar to the container
COPY build/libs/ms-gateway*.jar /tmp/ms-gateway.jar
WORKDIR /tmp

# Set timezone BR
RUN apk add --update tzdata
ENV TZ=America/Sao_Paulo

# Run the jar file
ENTRYPOINT java -XX:MinHeapFreeRatio=50 -XX:+UseContainerSupport -XX:+UseParallelGC -XX:MaxRAMPercentage=80.0 -XX:ParallelGCThreads=4 -XX:MaxGCPauseMillis=100 -DAPPLICATION_NAME=${APPLICATION_NAME} -DSERVER_PORT=${SERVER_PORT} -DEUREKA_BASE_URL=${EUREKA_BASE_URL} -DASSEMBLY_MS_NAME=${ASSEMBLY_MS_NAME} -DVOTE_MS_NAME=${VOTE_MS_NAME} -jar api-gateway.jar

EXPOSE ${SERVER_PORT}
