# OpenCBS Cloud Configuration Properties Reference

## Overview
This document provides a comprehensive reference for all configuration properties used throughout the OpenCBS Cloud system. Properties are organized by their source and functionality.

## Properties Source Analysis

### Configuration Classes Found
1. **CoreModuleProperties.java** - Core business logic settings
2. **AttachmentProperty.java** - File attachment storage  
3. **TemplateProperty.java** - Document template storage
4. **AccountBalanceCalculationProperties.java** - Account balance messaging
5. **RabbitProperties.java** - RabbitMQ message queue configuration
6. **DayClosureProperties.java** - End-of-day processing automation
7. **TaskExecutorProperties.java** - Thread pool configuration
8. **EmailServiceImpl.java** - Email sender configuration (@Value annotations)

## Complete Properties Reference

### Core Module Properties
**Prefix:** `opencbs.core`  
**Class:** `com.opencbs.core.configs.properties.CoreModuleProperties`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `opencbs.core.enableInterestAccrual` | boolean | false | No | Enable automatic interest accrual calculation |
| `opencbs.core.enablePenaltyAccrual` | boolean | false | No | Enable automatic penalty accrual calculation |
| `opencbs.core.enableAutoRepayment` | boolean | false | No | Enable automatic loan repayment processing |

**Example:**
```properties
opencbs.core.enableInterestAccrual=true
opencbs.core.enablePenaltyAccrual=true
opencbs.core.enableAutoRepayment=false
```

### Attachment Storage
**Prefix:** `attachment`  
**Class:** `com.opencbs.core.configs.properties.AttachmentProperty`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `attachment.location` | String | none | **Yes** | Directory path for storing uploaded attachments |

**Example:**
```properties
# Linux/Mac
attachment.location=/var/opencbs/attachments

# Windows  
attachment.location=C:\\opencbs\\attachments
```

### Template Storage
**Prefix:** `template`  
**Class:** `com.opencbs.core.configs.properties.TemplateProperty`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `template.location` | String | none | **Yes** | Directory path for storing document templates |

**Example:**
```properties
# Linux/Mac
template.location=/var/opencbs/templates

# Windows
template.location=C:\\opencbs\\templates
```

### Account Balance Calculation
**Prefix:** `account-balance-calculation`  
**Class:** `com.opencbs.core.configs.properties.AccountBalanceCalculationProperties`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `account-balance-calculation.exchange` | String | none | No | Exchange name for balance calculation messages |
| `account-balance-calculation.queue` | String | none | No | Queue name for balance calculation processing |
| `account-balance-calculation.routingKey` | String | none | No | Routing key for balance calculation messages |

**Example:**
```properties
account-balance-calculation.exchange=balance.exchange
account-balance-calculation.queue=balance.calculation.queue
account-balance-calculation.routingKey=balance.calculation
```

### RabbitMQ Configuration
**Prefix:** `spring.rabbitmq`  
**Class:** `com.opencbs.core.configs.properties.RabbitProperties`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `spring.rabbitmq.host` | String | none | No | RabbitMQ server hostname or IP |
| `spring.rabbitmq.frontHost` | String | none | No | Frontend RabbitMQ host (if different) |
| `spring.rabbitmq.port` | String | none | No | RabbitMQ server port |
| `spring.rabbitmq.username` | String | none | No | RabbitMQ authentication username |
| `spring.rabbitmq.password` | String | none | No | RabbitMQ authentication password |
| `spring.rabbitmq.virtualHost` | String | none | No | RabbitMQ virtual host |
| `spring.rabbitmq.directExchange` | String | none | No | Direct exchange name |
| `spring.rabbitmq.fanoutExchange` | String | none | No | Fanout exchange name |

**Example:**
```properties
spring.rabbitmq.host=localhost
spring.rabbitmq.port=5672
spring.rabbitmq.username=opencbs
spring.rabbitmq.password=password123
spring.rabbitmq.virtualHost=/opencbs
spring.rabbitmq.directExchange=opencbs.direct
spring.rabbitmq.fanoutExchange=opencbs.fanout
```

### Day Closure Configuration  
**Prefix:** `day-closure`  
**Class:** `com.opencbs.core.configs.properties.DayClosureProperties`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `day-closure.autoStart` | Boolean | none | No | Enable automatic day closure start |
| `day-closure.autoStartTime` | String | none | No | Time to start day closure (HH:mm format) |
| `day-closure.errorToEmails` | List\<String\> | none | No | Email addresses for error notifications |

**Example:**
```properties
day-closure.autoStart=true
day-closure.autoStartTime=23:30
day-closure.errorToEmails=admin@bank.com,operations@bank.com
```

### Task Executor Configuration
**Prefix:** `task-executor`  
**Class:** `com.opencbs.core.configs.properties.TaskExecutorProperties`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `task-executor.minPoolSize` | Integer | none | No | Minimum number of threads in executor pool |
| `task-executor.maxPoolSize` | Integer | none | No | Maximum number of threads in executor pool |

**Example:**
```properties
task-executor.minPoolSize=5
task-executor.maxPoolSize=20
```

### Email Configuration
**Source:** `@Value` annotations in `EmailServiceImpl`

| Property | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `email.sender` | String | none | No | Display name for email sender |
| `spring.mail.username` | String | none | No | SMTP username (used as sender email) |

**Example:**
```properties
email.sender=OpenCBS System
spring.mail.username=system@opencbs.com
spring.mail.password=email_password
spring.mail.host=smtp.gmail.com
spring.mail.port=587
```

## Configuration Validation

### Required Properties
The following properties are marked as required with validation annotations:

1. **`attachment.location`** - Validated with `@NotBlank`
2. **`template.location`** - Validated with `@NotBlank`

### Spring Boot Auto-Configuration
Some properties follow Spring Boot conventions and don't require explicit property classes:

- `spring.datasource.*` - Database configuration
- `spring.mail.*` - Email/SMTP configuration  
- `spring.jpa.*` - JPA/Hibernate configuration
- `server.*` - Embedded server configuration
- `logging.*` - Logging configuration

## Configuration Loading Order

Spring Boot loads configuration in the following order (later sources override earlier):

1. Default properties (in code)
2. `application.properties` 
3. `application-{profile}.properties`
4. Environment variables
5. Command line arguments

## Environment Variable Mapping

Properties can be overridden using environment variables:

```bash
# Convert property name to UPPERCASE and replace dots/hyphens with underscores
export OPENCBS_CORE_ENABLEINTERESTACCRUAL=true
export ATTACHMENT_LOCATION=/opt/attachments
export SPRING_RABBITMQ_HOST=rabbitmq.example.com
```

## Validation and Error Handling

### Startup Validation
- Properties marked with `@NotBlank` will cause startup failure if empty
- Invalid directory paths will be logged as warnings
- Missing required directories should be created manually

### Runtime Validation  
- Database connectivity is checked on first usage
- Email configuration is validated when sending emails
- RabbitMQ connectivity is checked when publishing messages

## Property Documentation Format

Each property in the configuration files follows this documentation format:

```properties
# Brief description of the property
# Additional details about usage, format, or constraints
# Example: value_example or /path/example
property.name=default_value
```

## Migration Notes

When upgrading OpenCBS versions:

1. Review new properties in the updated reference
2. Add new required properties to your configuration
3. Check for deprecated properties and update accordingly
4. Test configuration changes in development environment first

## Troubleshooting

### Common Configuration Issues

1. **Startup Failures**: Check required properties are set and valid
2. **File Access**: Ensure attachment/template directories exist and are writable
3. **Database Connection**: Verify JDBC URL, credentials, and database availability  
4. **Email Issues**: Test SMTP configuration and authentication
5. **RabbitMQ**: Confirm server accessibility and credentials

### Debug Configuration Loading

Enable configuration debug logging:

```properties
logging.level.org.springframework.boot.context.config=DEBUG
logging.level.org.springframework.core.env=DEBUG
```

This will show which configuration files are loaded and property resolution details.