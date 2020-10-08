FROM hive-noconf

#add hadoop config
#ADD hdfs-conf/hadoop-conf/ /opt/hadoop-2.7.3/etc/hadoop/
#add hive config
ADD hive/hive-conf/ ${HIVE_HOME}/conf

COPY hive/scripts /usr/bin/.
RUN chmod +x /usr/bin/bootstrap-metastore.sh && \
chmod +x /usr/bin/bootstrap-server2.sh


#EXPOSE 9999 9083 10002

