#Kafka mirror-maker

FROM java:openjdk-8-jre

#Installation based on spotify/kafka

ENV KAFKA_MIRROR ftp.cixug.es
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 1.0.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Install Kafka
RUN wget -q http://$KAFKA_MIRROR/apache/kafka/$KAFKA_VERSION/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    ln -s /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

ADD ./run.sh /etc/mirror-maker/

RUN chmod +x /etc/mirror-maker/run.sh

CMD /etc/mirror-maker/run.sh
