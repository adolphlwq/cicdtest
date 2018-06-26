FROM index.alauda.cn/alaudaorg/jenkins:node

RUN apt-get update \
    && apt-get install -y unzip wget locales \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
ENV LC_CTYPE en_US.UTF-8

ENV SCANNER_VERSION=3.0.3.778
RUN set -e \
    && cd /usr/local \
    && wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SCANNER_VERSION}-linux.zip \
    && unzip sonar-scanner-cli-${SCANNER_VERSION}-linux.zip \
    && rm sonar-scanner-cli-${SCANNER_VERSION}-linux.zip \
    && ln -s /usr/local/sonar-scanner-${SCANNER_VERSION}-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && ln -s /usr/local/sonar-scanner-${SCANNER_VERSION}-linux/bin/sonar-scanner-debug /usr/local/bin/sonar-scanner-debug \
    && mkdir -p /var/log/mathilde

ARG commit_id
ENV COMMIT_ID=${commit_id}