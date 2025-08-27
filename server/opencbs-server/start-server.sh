#!/bin/bash
# OpenCBS Server Startup Script
# Spring Boot 2.7.18 with native Java 17 support - no compatibility flags needed

echo "Starting OpenCBS Cloud Server with Spring Boot 2.7.18..."
echo "Java Version: $(java -version 2>&1 | head -1)"
echo "Working Directory: $(pwd)"
echo ""

# Optional: Add memory settings
MEMORY_FLAGS="-Xmx1g -Xms512m"

echo "Starting with memory settings: $MEMORY_FLAGS"
echo "JAR file: target/opencbs-server-0.0.1-SNAPSHOT.jar"
echo ""

exec java $MEMORY_FLAGS -jar target/opencbs-server-0.0.1-SNAPSHOT.jar "$@"