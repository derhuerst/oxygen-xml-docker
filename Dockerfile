FROM ubuntu as builder
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

FROM alpine

# copy installation
COPY --from=builder /usr/local/oxygen /usr/local/oxygen

ENV PATH="/usr/local/oxygen:/usr/local/oxygen/jre/bin:${PATH}"
ENTRYPOINT [[ -z "${AGREE_TOS}" ]] &&
