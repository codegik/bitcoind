FROM phusion/baseimage:latest
MAINTAINER Inacio Klassmann <inacio@versates.com>

# Install bitcoind
RUN apt-get update
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y bitcoind wget
RUN mkdir /data

# Install RabbitMQ
RUN cd /tmp
RUN apt-get -y install rabbitmq-server
RUN apt-get update
RUN echo "[{rabbit, [{loopback_users, []}]}]." >> /etc/rabbitmq/rabbitmq.config
RUN rabbitmq-plugins enable rabbitmq_management

COPY *.sh /
COPY *.conf /

EXPOSE 8332 8333 18332 18333 15672 5672

CMD ["./starter.sh"]