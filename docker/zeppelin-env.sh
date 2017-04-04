# retrieve HDFS config files that are dynamically generated by DC/OS HDFS
# docker builder already creates the "${HADOOP_CONF_DIR}"
# mkdir -p "${HADOOP_CONF_DIR}"
[ -f "${MESOS_SANDBOX}/hdfs-site.xml" ] && cp "${MESOS_SANDBOX}/hdfs-site.xml" "${HADOOP_CONF_DIR}"
[ -f "${MESOS_SANDBOX}/core-site.xml" ] && cp "${MESOS_SANDBOX}/core-site.xml" "${HADOOP_CONF_DIR}"

# export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.coarse=true -Dspark.mesos.executor.home=/opt/spark/dist"
[ -n "${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.executor.docker.image=${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}" &&
    export ZEPPELIN_INTP_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.mesos.executor.docker.image=${SPARK_MESOS_EXECUTOR_DOCKER_IMAGE}"

[ -n "${SPARK_EXECUTOR_MEMORY}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.executor.memory=${SPARK_EXECUTOR_MEMORY}" &&
    export ZEPPELIN_INTP_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.executor.memory=${SPARK_EXECUTOR_MEMORY}"

[ -n "${SPARK_CORES_MAX}" ] &&
    export ZEPPELIN_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.cores.max=${SPARK_CORES_MAX}" &&
    export ZEPPELIN_INTP_JAVA_OPTS="${ZEPPELIN_JAVA_OPTS} -Dspark.cores.max=${SPARK_CORES_MAX}"

export MASTER=mesos://leader.mesos:5050
export MESOS_NATIVE_LIBRARY=/usr/lib/libmesos.so
