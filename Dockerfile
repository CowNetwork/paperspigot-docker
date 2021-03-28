FROM adoptopenjdk/openjdk11:alpine-slim AS builder
ARG version
ARG build
WORKDIR /minecraft
ADD https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build/downloads/paper-$version-$build.jar paper.jar
RUN java -jar paper.jar

FROM adoptopenjdk/openjdk11:alpine-slim
EXPOSE 25565
WORKDIR /opt/spigot
COPY --from=builder /minecraft/cache/patched*.jar /opt/spigot/spigot.jar
RUN apk --update add --no-cache ca-certificates
CMD java -jar -Dcom.mojang.eula.agree=true spigot.jar --nogui
