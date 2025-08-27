#!/bin/bash
# OpenCBS Server Startup Script
# This script includes the necessary JVM flags to run Spring Boot 1.5.4 with Java 17

echo "Starting OpenCBS Cloud Server..."
echo "Java Version: $(java -version 2>&1 | head -1)"
echo "Working Directory: $(pwd)"
echo ""

# Required JVM flags for Spring Boot 1.5.4 compatibility with Java 17
JVM_FLAGS="--add-opens java.base/java.lang=ALL-UNNAMED"
JVM_FLAGS="$JVM_FLAGS --add-opens java.base/java.util=ALL-UNNAMED"
JVM_FLAGS="$JVM_FLAGS --add-opens java.base/java.lang.reflect=ALL-UNNAMED"
JVM_FLAGS="$JVM_FLAGS --add-opens java.base/java.text=ALL-UNNAMED"
JVM_FLAGS="$JVM_FLAGS --add-opens java.base/java.io=ALL-UNNAMED"
JVM_FLAGS="$JVM_FLAGS --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED"

# Optional: Add memory settings
MEMORY_FLAGS="-Xmx1g -Xms512m"

echo "Starting with JVM flags: $JVM_FLAGS $MEMORY_FLAGS"
echo "JAR file: target/opencbs-server-0.0.1-SNAPSHOT.jar"
echo ""

exec java $JVM_FLAGS $MEMORY_FLAGS -jar target/opencbs-server-0.0.1-SNAPSHOT.jar "$@"