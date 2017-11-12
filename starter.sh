#!/bin/sh

ENVIRONMENT=${ENVIRONMENT:-dev}

/omnicore-0.2.0/bin/omnicored \
    -datadir=/data \
    -conf=/bitcoin.$ENVIRONMENT.conf \
    --printtoconsole \
    -txindex \
    -checkblocks=1