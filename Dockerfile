FROM ubuntu

RUN apt-get update && apt-get install -y curl daemontools ruby unzip wget

COPY . /workspace/

ARG CONSUL_VERSION=1.6.1
# custom consul binary?
ARG CONSUL_BIN=

RUN if [ "${CONSUL_BIN}" ] && [ -x "/workspace/${CONSUL_BIN}" ]; then \
    cp /workspace/${CONSUL_BIN} /usr/bin/consul; \
  else \
    wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -O consul.zip \
      && unzip consul.zip && mv consul /usr/bin/ && rm consul.zip; \
  fi

WORKDIR /etc/service/consul

RUN cp /workspace/sv_run.sh run && cp /workspace/config.json.erb /etc/consul.json.erb

CMD ["supervise", "."]
