#!/bin/sh

ENVIRONMENT=${ENVIRONMENT:-dev}

USER=${BITCOIN_USER:-codegik}
PASS=${BITCOIN_PASS:-codegik}
CONFIG=/bitcoin.$ENVIRONMENT.conf

sed -i -- "s/user/$USER/g" "$CONFIG"
sed -i -- "s/pass/$PASS/g" "$CONFIG"

/etc/init.d/rabbitmq-server start

bitcoind \
    -conf=/bitcoin.$ENVIRONMENT.conf \
    --printtoconsole \
    -txindex \
    -checkblocks=1