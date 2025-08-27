# OpenCBS Cloud Startup Issues & Solutions

## ✅ FINAL SOLUTION: Spring Boot 2.7.18 Upgrade (CURRENT)

### Spring Boot 2.7.18 with Native Java 17 Support
As of the latest update, OpenCBS Cloud has been **successfully upgraded to Spring Boot 2.7.18** which provides **native Java 17 support**.

**No special JVM flags are required anymore!**

#### Startup Methods
1. **Direct JAR execution:**
   ```bash
   cd server/opencbs-server
   ./start-server.sh
   ```

2. **Docker Compose (Recommended):**
   ```bash
   docker compose up -d
   ```

#### What Changed in the Upgrade
- ✅ Spring Boot 1.5.4 → 2.7.18
- ✅ Spring Cloud Dalston.SR1 → 2021.0.8  
- ✅ Flyway 4.0.3 → 8.5.13 (with new API configuration)
- ✅ PostgreSQL driver 9.4.1212 → 42.5.4
- ✅ Updated test dependencies (AssertJ, Mockito, RestAssured)
- ✅ Added bean overriding configuration for Spring Boot 2.7.x compatibility
- ✅ Removed Java 17 compatibility JVM flags (no longer needed)

---

## 📜 Historical Solution: Spring Boot 1.5.4 + Java 17 Compatibility (LEGACY)

*This section is kept for reference only. The current version uses Spring Boot 2.7.18.*

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