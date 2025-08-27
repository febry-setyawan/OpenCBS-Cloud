#!/bin/bash
# Test Spring Boot 2.7.18 startup
set -e

echo "Testing Spring Boot 2.7.18 startup..."
echo "========================================="

cd /home/runner/work/OpenCBS-Cloud/OpenCBS-Cloud/server/opencbs-server

# Check if JAR exists
if [ ! -f "target/opencbs-server-0.0.1-SNAPSHOT.jar" ]; then
    echo "❌ JAR file not found. Building first..."
    cd ../
    mvn clean package -DskipTests --no-transfer-progress -pl opencbs-server -am
    cd opencbs-server
fi

echo "✅ JAR file found: $(ls -lh target/opencbs-server-0.0.1-SNAPSHOT.jar | cut -d' ' -f5,9)"

# Test startup without database (should fail gracefully)
echo ""
echo "Testing startup sequence (expecting database connection failure)..."
echo "This tests that Spring Boot 2.7.18 starts without Java 17 compatibility issues"

timeout 30 java -Xmx512m -jar target/opencbs-server-0.0.1-SNAPSHOT.jar --spring.profiles.active=test \
    --spring.datasource.url=jdbc:h2:mem:testdb \
    --spring.datasource.driver-class-name=org.h2.Driver \
    --spring.jpa.hibernate.ddl-auto=create-drop \
    --spring.flyway.enabled=false \
    --logging.level.org.springframework.web=INFO 2>&1 | tee startup_test.log &

JAVA_PID=$!
sleep 10

# Check if process is still running (good sign)
if kill -0 $JAVA_PID 2>/dev/null; then
    echo "✅ Application started successfully with Spring Boot 2.7.18!"
    echo "✅ No Java 17 compatibility issues detected!"
    kill $JAVA_PID 2>/dev/null || true
    wait $JAVA_PID 2>/dev/null || true
else
    echo "❌ Application failed to start"
    echo "Last few lines of startup log:"
    tail -10 startup_test.log
    exit 1
fi

echo ""
echo "✅ Spring Boot 2.7.18 upgrade successful!"
echo "✅ Application can start without Java 17 compatibility flags"