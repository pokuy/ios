FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31

ENV DENO_VERSION=1.0.0-rc1
ENV GROUP_USER_NUMBER=3005

#Get binary and set up
RUN apk add --virtual .download --no-cache curl \
 && curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 777 deno \
 && mv deno /bin/deno \
 && apk del .download

#Set up group and user and deno-dir
RUN addgroup -g ${GROUP_USER_NUMBER} -S deno \
 && adduser -u ${GROUP_USER_NUMBER} -S deno -G deno \
 && mkdir /deno-dir/ \
 && chown deno:deno /deno-dir/

ENV DENO_DIR /deno-dir/

ENTRYPOINT ["deno"]