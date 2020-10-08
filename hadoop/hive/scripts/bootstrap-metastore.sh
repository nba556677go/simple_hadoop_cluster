#!/bin/bash

# Start the SSH daemon
service ssh restart

# Setup password less ssh
sshpass -p screencast ssh-copy-id root@localhost



sed -i "s#hiveip#$HIVEMETASTORE#g" /opt/apache-hive-2.3.4-bin/conf/hive-site.xml
#copy config from namenode
rsync -avhe ssh root@hdfs-namenode:/$HADOOP_HOME/etc/hadoop/*-site.xml /$HADOOP_HOME/etc/hadoop/


# Wait for HDFS services to be up and running
var=$(netcat -l -p 7778 )
echo $var
#start mysql service
mkdir /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
/etc/init.d/mysql start


#link mysql with hive
ln -s /usr/share/java/mysql-connector-java.jar /opt/apache-hive-2.3.4-bin/lib/mysql-connector-java.jar
rm /opt/apache-hive-2.3.4-bin/lib/log4j-slf4j-impl-2.6.2.jar
mysql -u root <<MY_QUERY
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive'; 
GRANT all on *.* to 'hive'@localhost identified by 'hive';
flush privileges;
MY_QUERY


#make hive directory
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir /tmp/hive
hdfs dfs -chmod -R 777 /user/hive/warehouse
hdfs dfs -chmod -R 777 /tmp/hive

#copy hive-site to spark
rsync -avhe ssh  $HIVE_HOME/conf/hive-site.xml root@spark-master:$SPARK_HOME/conf/

#mysql schema initialize
schematool -initSchema -dbType mysql

#start metastore server
hive --service metastore 

#start hive server2
#hive --service hiveserver2 --hiveconf hive.server2.webui.host=$HIVEHOSTIP --hiveconf hive.root.logger=INFO,console
# Run in daemon mode, don't exit
while true; do
  sleep 100;
done
