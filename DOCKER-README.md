# OpenCBS Cloud Docker Deployment Guide

This guide provides complete Docker deployment instructions for OpenCBS Cloud with **Spring Boot 2.7.18** and native Java 17 support.

## 🚀 Quick Start

1. **Clone and setup**:
   ```bash
   git clone https://github.com/febry-setyawan/OpenCBS-Cloud.git
   cd OpenCBS-Cloud
   ./docker-setup.sh
   ```

2. **Start services**:
   ```bash
   docker-compose up -d
   ```

3. **Access the application**:
   - OpenCBS: http://localhost:8080
   - RabbitMQ Management: http://localhost:15672 (opencbs/opencbs_rabbit)
   - PgAdmin: http://localhost:8081 (admin@opencbs.com/admin123)


## Deployment Options

### Development Environment
```bash
# Start with development configuration
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

# Features:
# - Debug logging enabled
# - Hot reload support
# - Java remote debugging on port 5005
# - Mailhog for email testing (port 8025)
```

### Production Environment
```bash
# Start with production configuration
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Features:
# - Optimized JVM settings
# - Security hardened
# - Auto-restart policies
# - Health monitoring
```

### Configuration Files Used
The Docker deployment uses the comprehensive configuration files created in this PR:
- `server/opencbs-server/src/main/resources/application.properties` - Main configuration
- All 41 parameters properly configured for both PostgreSQL and H2 fallback
- Complete RabbitMQ, email, and process automation settings

## Service Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   OpenCBS App   │────│   PostgreSQL    │────│   RabbitMQ      │
│   (port 8080)   │    │   (port 5432)   │    │   (port 5672)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │    PgAdmin      │
                    │   (port 8081)   │
                    └─────────────────┘
```

## Configuration Details

### Database Configuration
- **Production**: PostgreSQL 13 with persistent storage
- **Development**: PostgreSQL with development database
- **Testing**: H2 in-memory (configurable)

### Message Queue
- **RabbitMQ 3.11** with management interface
- **Account balance calculation** queues pre-configured
- **Virtual host isolation** for multi-tenancy support

### Application Features
All OpenCBS features properly configured:
- ✅ Interest and penalty accrual
- ✅ File attachment storage
- ✅ Email notifications 
- ✅ Day closure automation
- ✅ Task execution management

## Environment Variables

Key environment variables (see `docker-compose.env` for all):

| Variable | Description | Default |
|----------|-------------|---------|
| `POSTGRES_USER` | Database username | opencbs_user |
| `POSTGRES_PASSWORD` | Database password | opencbs_pass |
| `RABBITMQ_DEFAULT_USER` | RabbitMQ username | opencbs |
| `OPENCBS_CORE_ENABLEINTERESTACCRUAL` | Enable interest calculations | true |
| `EMAIL_ENABLED` | Enable email notifications | false |
| `NODE_OPTIONS` | Node.js compatibility fix | --openssl-legacy-provider |

## Troubleshooting

### Build Issues
- **Node.js OpenSSL Error**: Fixed with `NODE_OPTIONS=--openssl-legacy-provider`
- **Java Compilation**: Fixed with Java 17 compatibility updates
- **Maven Dependencies**: All library conflicts resolved

### Memory Issues
- **Frontend Build**: Increased Node.js memory with `--max_old_space_size=4096`
- **Backend Runtime**: JVM configured with appropriate heap sizes

### Database Connection
- **Connection Failed**: Ensure PostgreSQL health check passes before OpenCBS starts
- **Migration Issues**: Database migrations run automatically on startup

## Monitoring and Maintenance

### Health Checks
All services include comprehensive health monitoring:
- **PostgreSQL**: `pg_isready` health check
- **RabbitMQ**: Management diagnostics
- **OpenCBS**: Spring Boot Actuator health endpoint

### Data Persistence
- **Database**: Persistent volume `postgres_data`
- **RabbitMQ**: Persistent volume `rabbitmq_data` 
- **File Storage**: Persistent volumes for attachments and templates

### Backup and Recovery
```bash
# Backup database
docker-compose exec postgres pg_dump -U opencbs_user opencbs > backup.sql

# Restore database
cat backup.sql | docker-compose exec -T postgres psql -U opencbs_user opencbs
```

## Support

- **Setup Issues**: Check service logs with `docker-compose logs <service-name>`
- **Build Problems**: All Maven dependency issues have been resolved in this PR