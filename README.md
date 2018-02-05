# Bitcoind
This docker image start the Bitcoind blockchain and the RabbitMQ.
This stack is composed of a Bitcoin Blockchain node and an instance of RabbitMQ. The purpose is to capture the events in the wallet and submit them to the queue.

## Initalize the docker containers
### Running in development mode
```
$ docker run -it --name bitcoind -p 18332:18332 -p 18333:18333 -p 15672:15672 -p 5672:5672 -v ~/.bitcoin:/data codegik/bitcoind
```

### Running in production mode
```
$ docker run -it --name bitcoind -p 8332:8332 -p 8333:8333 -p 15672:15672 -p 5672:5672 -v ~/.bitcoin:/data -e ENVIRONMENT=prod codegik/bitcoind
```

### Changing the RPC user name and password
```
$ docker run -it --name bitcoind -p 8332:8332 -p 8333:8333 -p 15672:15672 -p 5672:5672 -v ~/.bitcoin:/data -e ENVIRONMENT=prod -e BITCOIN_USER=otheruser -e BITCOIN_PASS=othersecret codegik/bitcoind
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

## Consumming transactions from Bitcoind

```
@Service
public class BtcTransactionHandler {
    private final Logger log = LoggerFactory.getLogger(BtcTransactionHandler.class);

    @Bean
    public ConnectionFactory createMQ() {
        try {
            final ConnectionFactory factory = new ConnectionFactory();
            factory.setUri("amqp://guest:guest@localhost");
            final String queue = "btc-transaction-handler";
            final Connection connection = factory.newConnection();
            final Channel channel = connection.createChannel();
            final Consumer consumer = new DefaultConsumer(channel) {
                @Override
                public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties,
                        byte[] body) throws IOException {
                    log.debug("transaction received: {}", new String(body, "UTF-8"));
                }
            };
            channel.queueDeclare(queue, false, false, false, null);
            channel.basicConsume(queue, true, consumer);
            log.info("Queue service consumer started");
            return factory;
        } catch (IOException | TimeoutException | KeyManagementException | NoSuchAlgorithmException
                | URISyntaxException e) {
            log.error("can't connect to Rabbit Queue!!", e);
            try {
                Thread.sleep(30 * 1000);
            } catch (InterruptedException e1) {
            }
        }
        return null;
    }

}
```
