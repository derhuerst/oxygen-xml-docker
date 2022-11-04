FROM ubuntu:22.04 as builder
WORKDIR /root

# download installer
# RUN apt update && apt install -y wget
# RUN wget -q 'https://www.oxygenxml.com/InstData/Editor/Linux64/VM/oxygen-64bit-openjdk.sh' -o install.sh && chmod +x install.sh
ADD "https://www.oxygenxml.com/InstData/Editor/Linux64/VM/oxygen-64bit-openjdk.sh" install.sh
RUN chmod +x install.sh

# install dependencies
# todo: move up
RUN apt update && apt install -y libfreetype6

# run installer
ADD automate-install.txt ./
RUN sh install.sh <automate-install.txt

# we need glibc, so alpine does not work :(
FROM ubuntu:22.04
LABEL org.opencontainers.image.title="oxygen-xml"
LABEL org.opencontainers.image.description="Oxygen XML scripting API"
LABEL org.opencontainers.image.authors="Jannis R <mail@jannisr.de>"
LABEL org.opencontainers.image.documentation="https://github.com/derhuerst/oxygen-xml-docker/tree/1.0.0"
LABEL org.opencontainers.image.source="https://github.com/derhuerst/oxygen-xml-docker"
LABEL org.opencontainers.image.revision="1.0.0"

# copy installation
WORKDIR /usr/local/oxygen
COPY --from=builder /usr/local/oxygen ./

# we include jre/bin to allow for `java some-file.jar` overrides
ENV PATH="/usr/local/oxygen/jre/bin:/usr/local/oxygen:${PATH}"
COPY entrypoint.sh ./

ENTRYPOINT ["entrypoint.sh"]
CMD ["ls -l *.sh"]
