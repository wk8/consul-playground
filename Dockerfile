FROM ubuntu

RUN apt-get update && apt-get install -y curl daemontools ruby unzip wget

ARG CONSUL_VERSION=1.6.1

RUN wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -O consul.zip \
  && unzip consul.zip && mv consul /usr/bin/ && rm consul.zip

WORKDIR /etc/service/consul 

COPY sv_run.sh run

COPY config.json.erb /etc/consul.json.erb

CMD ["supervise", "."]
