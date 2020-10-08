# simple_hadoop_cluster

# Docker compose for spawning on demand HDFS cluster

# Build the required Docker images
`./build-images.sh`  
`docker-compose build`

# Run the cluster
Note: Run below commands from the directory where `docker-compose.yml` file is present.
## bring up the cluster
`docker-compose up -d`
## stop the cluster
`docker-compose stop`
## restart the stopped cluster
`docker-compose start`
## remove containers
`docker-compose rm -f`


## Attaching to cluster containers
  - HDFS NameNode container
    * Runs HDFS NameNode and DataNode services
    * `docker exec -it hdfs-namenode bash`
