# kafka-mirror-maker

This is a simple kafka mirror-maker using a default java:openjdk-8-jre source and adding the kafka version specified on Dockerfile.

The Build process download the tgz file from the defined mirror and install it simply by untar and creating a symlink to /opt/kafka

run.sh script require the following variables:

DESTINATION=xxx.xxx.com:9092
SOURCE=xxx.xxx.com:9092
GROUPID="xxxx"
WHITELIST="xxxx" have to be 

the execution will create a /etc/kafka-mirror/consumer.properties and /etc/kafka-mirror/producer.properties and launch mirror-maker using:
```
/opt/kafka/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure true --new.consumer --producer.config /etc/mirror-maker/producer.properties --consumer.config /etc/mirror-maker/consumer.properties
```

# Building the Docker

Once you are in the Dockerfile directory execute:

```
docker build . -t mirror-maker 
```

# Running the Docker
```
docker run -it -e DESTINATION=xxx.xxx.com:9092 -e SOURCE=xxx.xxx.com:9092 -e GROUPID=_mirror_maker -e WHITELIST=<TOPIC NAME> mirror-maker:latest
```
