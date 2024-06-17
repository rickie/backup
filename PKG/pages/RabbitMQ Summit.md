- 16 September 2022
-
- # Erlang powered Rabbits
- Stockholm phone services building with all the wires.
-
- ## Erlang
- Share nothing processes.
- Communicate via copying message passing.
- Preempted if running too long.
- Supervise other processes via links and monitors.
-
- Erlang in RabbitMQ
	- Connection
	- Channels
	- Queues
-
- Primitives:
	- **Spawn**
	- **Send**
	- **Monitor**
	- **Link**
-
- Fairness:
	- Run for max ~1 ms.
	- Will try to keep serving and therefore progress the system.
	- Under heavy load still try to serve customers best way.
- Isolation:
	- Failures only affect one process
		- Unless linked :wink:.
	- Errors managed at process level
	- Processes do **NOT** share any data.
	- Always a copy of data, no reference.
- Parallelism
	- Erlang does nicely distribute & balances all the queues and channels over all the cores. It makes sure to keep latency low.
- Distributed
	- If you want to split the application, to use two computers that can be happened.
	- Use the same primitives distributed
	- Can handle 100s of nodes, normal is < 10 nodes.
-
- Erlang the language;
	- Strong dynamic typing
-
-
- # RabbitMQ Core Team update
- 3.6 released by an actual rabbit.
-
- # RabbitMQ at Bloomberg
- OMS = Order Management System
- Position-oriented.
	- What do I hold and what is it worth?
	- Daily Profit and Loss
	- Aggregated risk, pricing, analytics.
-
- Millions of transactions per day.
	- It's important because it's about trades.
	-
- Requirements:
	- High reliability
	- Message ordering
-
	- Sharding of all resources, multiple production environments!
-
- ## Why RabbitMQ
- Strong guarantees (no message loss)
- Support for charding, not too high throughput.
-
- `reject-publish` vhost overflow policy.
	- Default is `drop-HEAD`
	- Broker confirms, ack/nack handling.
	- Message priority.
- `reply-to` queues for statuses
-
- Externalized application config.
-
- Define somewhere in an abstract place the application behavior.
	- Instead of in the applications itself, also helps with all the migrations.
	- Config artifacts, a library drives the behavior based on the config and creates the RabbitMQ broker.
	- AMQP proxy :omg:.
-
-
- # 84 codes Client library developers
- AMQP 0-9-1 protocol.
	- TCP, binary
	- Frame based
	- Multiplexed by channels
-
- Frame with:
	- type
		- method
		- header
		- body
		- heartbeat
	- channel (channelID)
	- size
	- payload
		- byte size for the rest of the frame
	- frame-end
-
- Method frames; we can pass a class and method id with arguments.
	- So for example:
		- Connection#Start
		- Channel#Open
		- Exchange#declare
- Header frame;
-
- Connection
- Channel
	- queueDeclare
	- basicConsume
- That maps to the protocoil.
- After that, High level API without channels and automatic reconnect.
-
- Durable queue massively help prevent having to write `Reconnect logic`.
- Socket handling;
- Heartbeats; disable by default; rely on TCP keepalive instead.
-
- What can we do better;
	- Better higher level APIs
	- Reconnect logic
	- Performance
	- Fewer dependencies
	- Better error messages
	-
- # How we Rabbit at Weber
- RPC messages; performing On-Demand Work
	- Consumers are Responding when another app has requested work.
- May publish an event, as in, do something and pass on the work.
- Direct exchange; very targeted who receives the events.
- Probably does not reply. Not waiting for a response.
-
- Transaction Messages; a way of synchronizing distributed data stores.
	- Data structure is the same for alllll publishers;
-
- For Postgres one can use Mikkoo.
-
- Apache Avro Datums; message serialization.
	- Strongly-Typed
	- Contract Based
	- Binary Message
	- Schema Registry
-
- Operational Management
	- Broker Management
		- Ansible Role & Play.
		- Installs and Upgrade Packages
		- Configures
		- SSL certificates
	- Cluster formation
		- Service Discovery
		- rabbit_peer_discovery_consul plugin
	- Runtime configuration
		- Serially upgrades node of the cluster to have no downtime.
		- "hides" node for discovery.
		- Bidirectional Git sync for RabbitMQ object definitions.
		- UI or CLI Object Configuration.
-
- ## Best Practices
	- Simple consumers; better 5 simple than 1 complex.
		- Easier to Debug
		- More robust.
	- Queue naming;
		- Without knowledge, what does it do? Who is the owner?
	- Sharding Queues; handling high throughput
		- Random Exchange; low CPU; balances well.
	- Handling Processing Errors; Delayed retry behavior.
	- Don't Alert on Queue Depth Alone
		- Indicates a consumers isn't keeping up.
		- Combined with `Ack Rate` there is some stuff happening.
	- AMQP properties:
		- app-id; who sent the message?
		- correlation-id; cross app tracing
		- message-id; unique identifier for the message being sent
		- timestamp; when it was first published
		- type; identifies the format/type of data in the message
	- Spinning messages; Consumer Shutdown Behavior
		- Max Error Count; how many operational errors until the consumer shuts down
		- Drop After N Errors; send to dead-letter queue
	-
-
- # Pushing RabbitMQ to the limit
- Should we update CPU or?
- Memory and disk requirement can be estimated.
- Network not really problem.
-
- PerfTest -- producers 1 -- consumers 5
-
- RabbitMQ computational hungry. On the same node saves quite some performance.
- Otherwise it needs to serialize and send in between nodes.... This takes time.
- Publish Confirm. ==> One MUST do this.
	- Publish Window Size; 100?
	- Sent extra messages, try not to overload, processes the messages and gives publisher confirms, so you are being idle, just sent extra 100 messages (for example).
-
- Message size
- QQs
-
- Options:
	- --exchange
	- --routing-key
	- --uris
	- --time
	- --variable-{rate,latency,size}
	- --requeue
	- **--help**
-
- # Management, Monitoring and Tracing in RabbitMQ
- RabbitMQ: Management Plugin
-
- Rabbitrace
	- Support management from editor.
-
- # Fun, interesting and common RabbitMQ use cases
-