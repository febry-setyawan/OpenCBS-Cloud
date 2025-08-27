# OpenCBS Cloud Server Configuration

This directory contains configuration files for the OpenCBS Cloud server application. These files define all the configurable parameters used throughout the system.

## Configuration Files

### 1. `application.properties`
The main configuration file containing all system parameters with default values and detailed comments. This is the primary file to customize for your deployment.

### 2. `application-sample.properties` 
A template file showing example configurations for different environments (development, testing, production, Docker). Copy and modify this file as needed.

### 3. `application.yml`
YAML format version of the configuration with profile-specific settings. Use either `.properties` OR `.yml` format, not both simultaneously.

## Configuration Categories

### Core Module Properties (`opencbs.core.*`)
Controls core business logic features:
- `enableInterestAccrual`: Enable automatic interest calculations
- `enablePenaltyAccrual`: Enable automatic penalty calculations  
- `enableAutoRepayment`: Enable automatic loan repayment processing

### File Storage (`attachment.*`, `template.*`)
File system paths for storing:
- `attachment.location`: Uploaded file attachments
- `template.location`: Document templates and reports

### Message Queue (`spring.rabbitmq.*`)
RabbitMQ configuration for asynchronous processing:
- Connection details (host, port, credentials)
- Exchange and queue naming
- Virtual host configuration

### Account Processing (`account-balance-calculation.*`)
Message routing for account balance calculations:
- Exchange, queue, and routing key configuration

### Day Closure (`day-closure.*`)
End-of-day processing automation:
- `autoStart`: Enable automated day closure
- `autoStartTime`: Time to trigger automatic closure
- `errorToEmails`: Email notifications for errors

### Task Execution (`task-executor.*`)
Thread pool configuration for async tasks:
- `minPoolSize`: Minimum thread count
- `maxPoolSize`: Maximum thread count

### Email Configuration
SMTP settings for system notifications:
- `email.sender`: Display name for system emails
- `spring.mail.*`: Standard Spring Boot mail configuration

## Setup Instructions

### 1. First Time Setup

1. Copy the sample configuration:
   ```bash
   cp application-sample.properties application.properties
   ```

2. Edit `application.properties` with your environment-specific values:
   - Database connection details
   - File storage paths (create directories first)
   - Email SMTP settings
   - RabbitMQ connection details

### 2. Required Directories

Create the following directories and ensure they are writable by the application:

```bash
# Linux/Mac
sudo mkdir -p /var/opencbs/attachments /var/opencbs/templates
sudo chown -R opencbs:opencbs /var/opencbs

# Or use custom paths as configured in your properties file
mkdir -p /path/to/your/attachments /path/to/your/templates
```

### 3. Database Setup

Ensure your database is created and accessible:

```sql
-- PostgreSQL example
CREATE DATABASE opencbs_cloud;
CREATE USER opencbs WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE opencbs_cloud TO opencbs;
```

### 4. RabbitMQ Setup

Install and configure RabbitMQ with the user credentials specified in your configuration.

## Environment-Specific Configuration

### Development
- Use H2 in-memory database for quick testing
- Enable all features for testing
- Use local file paths like `/tmp/opencbs/`
- Manual day closure triggering

### Production  
- Use PostgreSQL or MySQL database
- Configure secure file storage paths
- Enable SSL/TLS for security
- Set up automated day closure
- Configure proper email notifications
- Use strong passwords and secure connections

### Docker
- Use environment variables for dynamic configuration
- Mount volumes for file storage
- Use Docker service names for internal connections

## Configuration Validation

The application will validate configuration on startup:

1. **Required Properties**: Some properties like `attachment.location` and `template.location` are required and cannot be empty.

2. **Directory Access**: File storage directories must exist and be writable.

3. **Database Connection**: Database must be accessible with provided credentials.

4. **Email Configuration**: SMTP settings will be validated when sending emails.

## Troubleshooting

### Common Issues

1. **File Storage Errors**: Ensure directories exist and have proper permissions
2. **Database Connection**: Check connection string, credentials, and database availability  
3. **Email Sending**: Verify SMTP settings and authentication
4. **RabbitMQ Connection**: Check host, port, and credentials

### Log Configuration

Enable debug logging for configuration issues:
```properties
logging.level.com.opencbs=DEBUG
logging.level.org.springframework.boot.context.config=DEBUG
```

### Property Override

You can override any property using:
1. Environment variables: `OPENCBS_CORE_ENABLEINTERESTACCRUAL=true`
2. Command line arguments: `--opencbs.core.enableInterestAccrual=true`
3. Profile-specific files: `application-prod.properties`

## Security Considerations

1. **Passwords**: Never commit actual passwords to version control
2. **File Permissions**: Restrict access to configuration files (600 or 644)
3. **Environment Variables**: Use environment variables for sensitive data
4. **SSL/TLS**: Enable HTTPS in production environments
5. **Database Security**: Use encrypted connections and strong passwords

## Support

For configuration assistance:
1. Check the application logs for detailed error messages
2. Verify all required directories exist and are writable
3. Test database and RabbitMQ connections independently
4. Review sample configurations for your environment type