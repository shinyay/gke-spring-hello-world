FROM gradle:6.5.0-jdk11 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle assemble --no-daemon

FROM openjdk:11.0.5-jre-slim-buster
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar
ENTRYPOINT [ "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseZGC", "-XX:MaxDirectMemorySize=10M", "-XX:MaxMetaspaceSize=101583K", "-XX:ReservedCodeCacheSize=240M", "-Xss1M", "-Xmx434992K", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
