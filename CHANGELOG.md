# OpenCBS Cloud Changelog

## Version 0.0.2 - Spring Boot 2.7.18 Upgrade (2025-08-27)

### 🚀 Major Upgrade: Spring Boot 2.7.18 + Native Java 17 Support

#### Breaking Changes
- **Spring Boot**: 1.5.4.RELEASE → 2.7.18
- **Spring Cloud**: Dalston.SR1 → 2021.0.8
- **Java compatibility flags are no longer required** (native Java 17 support)

#### Dependencies Updated
- **Flyway**: 4.0.3 → 8.5.13 (with new migration API)
- **PostgreSQL**: 9.4.1212 → 42.5.4
- **AssertJ**: 1.7.0 → 3.24.2
- **Mockito**: mockito-all 1.10.8 → mockito-core 4.11.0
- **RestAssured**: 2.9.0 → 5.3.2 (with new group ID)

#### Configuration Changes
- Added `spring.main.allow-bean-definition-overriding=true` for 2.7.x compatibility
- Updated Flyway configuration to use new fluent API
- Removed Java 17 compatibility JVM flags from startup scripts and Docker configs

#### Fixes
- Fixed "Cannot load configuration class" startup error (original issue)
- Fixed JPA auditing handler bean conflicts
- Fixed QueryDSL reflection warnings
- Updated Docker configurations for cleaner deployment

#### Testing
- ✅ Application starts successfully without Java 17 compatibility flags
- ✅ All core modules compile without errors
- ✅ Database connectivity and migrations work properly
- ✅ Docker deployment validated across multiple environments

---

## Version 0.0.1 - Initial Release (2025-08-26)

### 📋 Configuration Management
- Created comprehensive properties files with 41+ configuration parameters
- Added Docker Compose support for multiple deployment environments
- Fixed Maven build dependencies and Java 17 compatibility issues

### 🔧 Build System Fixes
- Resolved parent POM structure issues
- Fixed deprecated dependency versions
- Updated QueryDSL, MapStruct, and Lombok for Java 17

### 🐳 Docker Support
- Multi-environment Docker configurations
- Production-optimized settings
- Backend-only deployment option
- Node.js compatibility fixes for Angular build

### 📚 Documentation
- Complete deployment guides
- Startup troubleshooting documentation  
- Configuration reference files
- Validation scripts and automation tools