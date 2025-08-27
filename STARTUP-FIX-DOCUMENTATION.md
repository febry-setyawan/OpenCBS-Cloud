# OpenCBS Cloud Startup Issues & Solutions

## Problem Fixed: Java 17 Compatibility with Spring Boot 1.5.4

### Issue
The original error was:
```
java.lang.IllegalStateException: Cannot load configuration class: com.opencbs.cloud.ServerApplication
```

### Root Cause
Spring Boot 1.5.4.RELEASE was not designed for Java 17 and has CGLIB/reflection compatibility issues with newer Java versions.

### Solution Applied
Added required JVM flags for Java 17 compatibility:

```bash
java --add-opens java.base/java.lang=ALL-UNNAMED \
     --add-opens java.base/java.util=ALL-UNNAMED \
     --add-opens java.base/java.lang.reflect=ALL-UNNAMED \
     --add-opens java.base/java.text=ALL-UNNAMED \
     --add-opens java.base/java.io=ALL-UNNAMED \
     --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED \
     -jar opencbs-server-0.0.1-SNAPSHOT.jar
```

### Dependencies Fixed
1. **Added H2 database dependency** for testing
2. **Updated ModelMapper** from 0.7.5 → 3.1.1 for Java 17 compatibility  
3. **Added MapStruct annotation processor** to loans module
4. **Modified Flyway migration strategy** to respect enabled flag

### Files Modified
- `CoreFlywayMigrationStrategy.java` - Added conditional migration
- `opencbs-spring-boot-starter/pom.xml` - Added H2 database dependency
- `opencbs-loans/pom.xml` - Added MapStruct dependency and processor
- `opencbs-core/pom.xml` - Updated ModelMapper to 3.1.1
- `start-server.sh` - Startup script with JVM flags
- `application.properties` - Production configuration
- `application-test.properties` - Testing configuration  
- All Docker configurations updated with JVM flags

## Startup Methods

### Method 1: Direct JAR Execution
```bash
cd server/opencbs-server
./start-server.sh
```

### Method 2: Docker Compose (Recommended)  
```bash
docker compose up -d
```

### Method 3: Backend-Only Docker
```bash
docker compose -f docker-compose.backend-only.yml up -d
```

## Database Setup

**For Production:** Use PostgreSQL database with proper schema via Flyway migrations
**For Testing:** Use H2 in-memory database with `--spring.profiles.active=test`

## Status

✅ **RESOLVED** - Original configuration class loading error  
✅ **RESOLVED** - Java 17 compatibility issues  
✅ **RESOLVED** - MapStruct dependency injection issues  
✅ **RESOLVED** - ModelMapper Java 17 compatibility  
✅ **VALIDATED** - Application context loads successfully  
✅ **CONFIGURED** - Complete Docker deployment setup

Application can now start without errors when proper database is available.