FROM node:10.22.0-buster

COPY lib /lib
COPY package.json /package.json
ENV PATH="/bin:${PATH}"

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        curl ca-certificates \
    python3 python3-pip \
    asciidoctor && \
    pip3 install docutils && \
    curl -sSL https://github.com/errata-ai/vale/releases/download/v2.3.4/vale_2.3.4_Linux_64-bit.tar.gz -o vale.tar.gz && \
    tar xfz vale.tar.gz && \
    rm LICENSE README.md && \
    mv vale /bin && \
    npm install --production && \
    apt-get purge -y \
        curl ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["node", "/lib/main.js"]
