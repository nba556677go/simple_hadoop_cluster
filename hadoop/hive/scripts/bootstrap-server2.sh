#!/bin/bash

# Start the SSH daemon
service ssh restart

# Setup password less ssh
sshpass -p screencast ssh-copy-id root@localhost


sed -i "s#hiveip#$HIVEMETASTORE#g" $HIVE_HOME/conf/hive-site.xml
#copy config from namenode
rsync -avhe ssh root@hdfs-namenode:/$HADOOP_HOME/etc/hadoop/*-site.xml /$HADOOP_HOME/etc/hadoop/


# Wait for metastore services to be up and running
while sleep 10
do
        if grep -q 'open' connection.txt | nc -vz $HIVEMETASTORE 9083 > "connection.txt"; then
          echo metastore server up!!
          break
        else
          echo wait for metastore server...
        fi
done
rm connection.txt

#start hive server2
hive --service hiveserver2 --hiveconf hive.server2.webui.host=$HIVEHSERVER --hiveconf hive.root.logger=INFO,console
# Run in daemon mode, don't exit
while true; do
  sleep 100;
done
