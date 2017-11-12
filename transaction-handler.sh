#!/bin/sh

uri="http://localhost:15672/api/exchanges/%2f/amq.default/publish"
json="{\"payload\": \"$1\", \"vhost\": \"/\", \"name\": \"amq.default\",\"properties\": {\"delivery_mode\": 1, \"headers\": {}}, \"routing_key\": \"btc-transaction-handler\", \"delivery_mode\": 1, \"headers\": {}, \"props\": {}, \"payload_encoding\": \"string\"}"
curl -i -u guest:guest -H "content-type:plain/text" -X POST $uri -d "$json"