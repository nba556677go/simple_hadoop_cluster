FROM hadoop-noconf

RUN apt-get update && \
apt-get install -y 	mysql-server
RUN apt-get install -y libmysql-java
#add hive from local(can change to wget)
COPY apache-hive-2.3.4-bin.tar.gz /tmp/
# Unpack hive into /opt/ 
RUN tar -xzf /tmp/apache-hive-2.3.4-bin.tar.gz	 -C /opt/

#add env variable/path 
ARG HIVE_HOME
ENV HIVE_HOME=${HIVE_HOME}
ARG SPARK_HOME
ENV SPARK_HOME=${SPARK_HOME}

ENV PATH $PATH:${HIVE_HOME}/bin