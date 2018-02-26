#!/bin/bash

set -e

if [ -z "${SOURCE}" ] || [ -z "${DESTINATION}" ] || [ -z "${GROUPID}" ] || [ -z "${WHITELIST}" ]
then
  echo "Ussage: docker run -it -e DESTINATION=xxx.xxx.com:9092 -e SOURCE=xxx.xxx.com:9092 -e GROUPID=_mirror_maker -e WHITELIST=<TOPIC NAME> mirror-maker:latest"
  echo "Error: Some required variables are not defined"
  echo DESTINATION=${DESTINATION}
  echo SOURCE=${SOURCE}
  echo GROUPID=${GROUPID}
  echo WHITELIST=${WHITELIST}
  exit 1; 
fi

cat > /etc/mirror-maker/producer.properties << EOF
bootstrap.servers=${DESTINATION}
EOF

cat > /etc/mirror-maker/consumer.properties << EOF
bootstrap.servers=${SOURCE}
group.id=${GROUPID}
EOF

/opt/kafka/bin/kafka-mirror-maker.sh --whitelist ${WHITELIST} --abort.on.send.failure true --new.consumer --producer.config /etc/mirror-maker/producer.properties --consumer.config /etc/mirror-maker/consumer.properties

