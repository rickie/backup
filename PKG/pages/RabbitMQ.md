- Important resources:
	- #[[RabbitMQ Summit]]
	- #[[Rabbit Survey]]
-
	-
- RabbitMQ start command:
- ```
  sudo -u rabbitmq rabbitmqctl start_app
  ```
-
- RabbitMQ stop command
- ```
  sudo -u rabbitmq rabbitmqctl stop
  ```
-
-
- # Meeting 22 Nov
-
- docker-compose up rabbitmq
- go to `localhost:15672`
- `qm --market nl --env  dev --rmq-uri http://localhost:15672 --vhost='/'`
- vhost in actual clusters it is dev in `dev`. Prod clusters `prod`.
- `can-migrate DC-.picnic.purchaseorder.deadletter`
-
-
- **Requirements for being able to migrate a queue:**
	- PSM recent version.
	- Deadletter queue does not have messages
	- Queue can be migrated
		- it's durable
		- non-auto deletable queue
		- mirrored queue
	- Whatever else...
-
- Auto delete, automatically deleted if last connection is closed.
- TTL Queue should be deleted after given amount of time it not having connections/consumers.
- Exclusive queues, exclusive to the connection. If it goes away, queue is gone.
- Those are non durable queues, means you are not given a f*ck about the messages, so should not be QQ. To expensive to mirror and stuff.
-
-
- `./run --resetk --durablek`
-
- ## Trying to run first migration on simple queue `wms-insight`
- Not authenticated.
-
- `export PN_APIKEY` --> global/dev/platform/ --> SYSTEM API KEY.
- port-forward
- `curl -H "Picnic-User: migrator" -H "Picnic-Roles: SYSTEM" http://localhost:8080/mng`
-
-
- PSM Branch: ibabiankou/quorum-migration.
-
- ## Migration tool
- In the `quorum/migration` directory.
- `pipenv install`
- `pipenv shell`
- `qm --help`
-
-
- Federation queues + exchanges.
	- Not using for the first part of the migration.
	- Feature to establish links between multiple clusters.
	- Federation between two queues between two clusters. Cluster A exchange and all queues.
-
- Google Sheet deletable queues: https://docs.google.com/spreadsheets/d/1kbDys5ozP1_G5XeEbOVh4HljsDh1qlHhbwFomR7V5yA/edit.
-
- Google Sheet **Path to Quorom**
- https://docs.google.com/spreadsheets/d/1kbDys5ozP1_G5XeEbOVh4HljsDh1qlHhbwFomR7V5yA/edit#gid=0
-
- # Theory
- Durable; survive broker restart; persisted.
- Autodelete == non-durable.
-
- Exclusive: can only delete by the one that created it
-
- Auto-delete, when there is no consumer connected. Channel is closed for that queue. QUeue auatomtaically ddleteled.
- Multiple channels per connection
-
- Type 1: Classic HA-3  Durable non exclusive
- Type 2: Exclusive, auto-delete, no mirroring, non-durable
-
- Deadletter for the classic, durable mirrorred not exclusive queues.
-
- Don't use: (need to check!)
	- Message TTL
	- Message priority
-
- https://medium.com/trendyol-tech/rabbitmq-exchange-types-d7e1f51ec825#:~:text=RabbitMQ%20has%20four%20different%20types,have%20bound%20queues%20or%20exchanges.
- Third option with migration, the shovel,
	-
	- Can we fetch quee declaration timstamp
	- can we do server side migration. Policy stop all queue migration? Create new things. WHen applications are unable to find their old queue.
		- Prevent clients from declaring new queues.
		- Client side change, control all java clients all out there.
	- Worth finding out common migration paths for migrating to quorem queues.
		-
-
- No queue is free. Reduce queues.
- Currently, process on average; 300 messages per second.
-
- [https://datalayer-dev.nl.picnicinternational.com/](https://datalayer-dev.nl.picnicinternational.com/)
- Swagger URL
-
- # Rebalance queues in prod
- `curl -4u 'ylapjlbz:TsZZoutIMUooGsVUG7ZYU9GcaYQHCzo9' -XPOST https://dramatic-weasel.rmq.cloudamqp.com/api/rebalance/queues/`
-
-
-
-
-
- # Questions
- Do we have lazy queues?
- Are lazy queues still interesting when we have
-
- For how much growth are we thinking ahead?
-
- `CONSUMER_PREFETCH_COUNT` Should we reconsider this one? The value is now 20.
-
- Some simple tickets as try out.
-
- # Combined queue topical.
- Topoligy. "Single queue per service"
- "One queue per delivery guarantee"
- "per type of settings"
-
- Fewer queues, less resources on metrics. Overheads.
- Don't believe have services that will exceed / hit limit of what one queue can handle.
- Fewer queues per service; maintenance. Right now upgrades of RabbitMQ require downtime.
- There are options to do it without downtimes. Requires new cluster,  same topology setup, federations, queue federations. Tell queues to use other clusters.
- A few minutes down time?
- THe more queues you have, the  harder it will be to setup other cluster. Spin up all the queues.
- Configure all federations.
-
- Topology to move them outside of the application. Not all, but about the durable persistent topology definition, queues and exchanges. They survive restart. Temporary, autodelete exclusive, those should be declared by the applications themselves. Bound to lifetime of the connection of the whatever. Those are not interesting ephemiral.
- Terraform?
-
- Disavantages;
	- Main downside; we will have to implement support for that. Multiple messages through a queue.
	- Teams need to do the migration.
-
-
- ### TOPOLOGY THING
- Visiualisations that would help people understand.
- Convincing people, and getting agreement, to change topology.
- This is the direction we should be going in.
-
- ### How
- How are we going to implement that.
- How should people migrate.
-
- # Problem;
- not Reliable setup.
- People don't really know about the current setup.
-
	- New integration with topology
	- People not knowing their stuff.
	- Truly reliable message publishing.
	-
- Align on whether we should complete QQ migration.
- Internal knowledge improvement
- New topology.
- Test new tools.
-
- What is the impact on downstream usages? Consumers
-
- Implement publish confirms.
-
- Gather reqs,
- Present them
- Get greenlight
- Do prototypes,
- Choose implementation
- Do presentation
- Get green light
- Implement stuff.
- Roll out
- Plan the guide and explanation.
- Help out team.s
-
-
- No value / sense in doing QQ migration to the end.
- Given that we want to have new topology; pausing QQmig; alignging on the topology; everyone agrees; shifting focus to MS2.0; with all the outcomes of that.
- While we are doing this; we want to implement publisher confirms.
- Discuss and make it clear to the public that this is the current state. DOnt have publisher confirms, unstable network will loose mesage. DLQ messages can be lost. Not really safe. Can be lost.
- Whether it is acutally big problem, we have no idea. Duplicates handling.
-
-
-
- PROPOSED PLAN MS 2.0
- ```
  Proposed plan for implementing the MS 2.0
  Goal: support a different topology that better fits ……? 
  Gather requirements for a new topology. 
  Present the requirements.
  Create a few setups/prototypes with possible solutions.
  Choose an implementation.
  Do a presentation about the results.
  Have a yes/no moment to decide on the way forward.
  If yes, continue with the implementation and productionize it.
  Create a guide and explanation. Maybe do a Lunch & Learn session about the new setup.
  Roll out the (initial) MS 2.0.
  Help out teams with the migration.
  
  While working on 1 and 2, we would like to implement Publisher confirms in the existing Messaging support.
  We might be losing messages while we don’t know. Therefore, waiting for MS 2.0’s publisher confirms could be a bad idea.
  (Assumption:) Currently people are not really aware of how our RabbitMQ setup works and how resilient it is. Adding a feature like this and making them aware of this could have a positive impact on the migration later on. It’s a way/possibility to educate them.
  
  
  
  ```
-
-
- # Meeting 30 Nov
- We don't have enough information to make this decision.
	- We need to find out how people are using the RabbitMQ setup.
	- Do a meeting about a different topology.
		- Knowing whether we want to do a topology is interesting as starting MS 2.0 is pretty focused on that.
		- Our whole idea kind of falls/stands with changing topology.
-
-
- # 2 Dec quick sync.
- Upgrade with downtime
- Resilience against upgrades
- No messages lost.
-
- ### Plan of action:
-
-
- Monday jarmila en meeting met Ivan om de questionarire te fixen.
- Start ball rolling?
	- Looking at alternative topologies. Let's discuss and gather input.
	- Let's have a chat. Present current thinking.
		- Who looks at what.
		- Resources available.
		-
-
-
-
- Migration 7 Dec
- ```
   export RMQ_USER=quorum-migration      
  (migration)  rick@rick-picnic  ~/repos/picnic-java-support-modules/quorum/migration   ibabiankou/quorum-migration ±  export RMQ_PWD=9XOOYyuyh4408kx3Elo3YQLlkNBJ9
  ```