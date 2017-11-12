FROM phusion/baseimage:latest
MAINTAINER Inacio Klassmann <inacio@versates.com>

RUN apt-get update
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y bitcoind
RUN mkdir /data

COPY *.sh /
COPY *.conf /
COPY omnicore-0.2.0 /omnicore-0.2.0

EXPOSE 8332 8333 18332 18333

CMD ["./starter.sh"]