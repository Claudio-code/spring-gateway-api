FROM eclipse-temurin:21-jdk AS builder

WORKDIR /builder

COPY . .

RUN ./gradlew build -x test --no-daemon

FROM eclipse-temurin:21-alpine

COPY --from=builder /builder/build/libs/msgateway-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java", "-XX:+UseSerialGC", "-XX:+UseStringDeduplication", "-Xms128m", "-Xmx600m", "-jar", "app.jar"]
