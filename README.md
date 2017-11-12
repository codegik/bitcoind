# OmniLayer (Bitcoind)
This docker image start the OmniLayer over Bitcoind blockchain.

### Running in development mode
```
$ docker run -it --name omnilayer -p 18332:18332 -p 18333:18333 -v ~/.bitcoin:/data versates/bitcoind
```

### Running in production mode
```
$ docker run -it --name omnilayer -p 8332:8332 -p 8333:8333 -v ~/.bitcoin:/data -e ENVIRONMENT=prod versates/bitcoind
```

### Default options
The container start with default options:
- testnet=1
- server=1
- listener=1
- rpcuser=user
- rpcpassword=pass
- rpcallowip=127.0.0.0/24
- rpcallowip=172.17.0.0/16
- rpcallowip=0.0.0.0/24
- rpcallowip=10.0.0.0/24
- rpcallowip=192.0.0.0/24
- rpcallowip=10.200.130.158
- rpcallowip=10.200.0.0/255.255.0.0
- rpcallowip=192.168.0.0/24
- rpcallowip=192.168.0.0/255.255.0.0
- rpcallowip=10.200.0.0/24
- datadir=/data
