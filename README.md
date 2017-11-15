# Bitcoind
This docker image start the Bitcoind blockchain and the RabbitMQ.
This stack is composed of a Bitcoin Blockchain node and an instance of RabbitMQ. The purpose is to capture the events in the wallet and submit them to the queue.

### Running in development mode
```
$ docker run -it --name bitcoind -p 18332:18332 -p 18333:18333 -p 15672:15672 -p 5672:5672 -v ~/.bitcoin:/data codegik/bitcoind
```

### Running in production mode
```
$ docker run -it --name bitcoind -p 8332:8332 -p 8333:8333 -p 15672:15672 -p 5672:5672 -v ~/.bitcoin:/data -e ENVIRONMENT=prod codegik/bitcoind
```

### Default options
The blockchain container start with default options:
- regtest=1
- server=1
- listener=1
- rpcuser=codegik
- rpcpassword=codegik
- rpcallowip=0.0.0.0/0
- datadir=/data
