FROM alpine:3.10


COPY lib /lib
COPY package.json /package.json
ENV PATH="/bin:${PATH}"

RUN apk add --no-cache --update \
    nodejs nodejs-npm \
    python3 \
    wget \
    asciidoctor && \
    pip3 install docutils && \
    wget https://github.com/errata-ai/vale/releases/download/v2.3.2/vale_2.3.2_Linux_64-bit.tar.gz && \
    tar xfz vale_2.3.2_Linux_64-bit.tar.gz && \
    rm LICENSE README.md && \
    mv vale /bin && \
    npm install --production

ENTRYPOINT ["node", "/lib/main.js"]
