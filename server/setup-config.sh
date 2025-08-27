#!/bin/bash

# OpenCBS Cloud Server Setup Script
# This script creates the necessary directories and sets up basic configuration

echo "OpenCBS Cloud Server Configuration Setup"
echo "========================================"

# Function to create directory with proper permissions
create_directory() {
    local dir="$1"
    local description="$2"
    
    echo -n "Creating $description directory: $dir ... "
    
    if mkdir -p "$dir" 2>/dev/null; then
        chmod 755 "$dir"
        echo "✓ Created"
    else
        echo "✗ Failed (check permissions)"
        return 1
    fi
}

# Function to copy configuration template
setup_configuration() {
    local config_dir="${CONFIG_DIR:-./opencbs-server/src/main/resources}"
    
    echo -n "Setting up configuration file in $config_dir ... "
    
    if [ -f "$config_dir/application.properties" ]; then
        echo "✓ Configuration file already exists"
    elif [ -f "$config_dir/application-sample.properties" ]; then
        cp "$config_dir/application-sample.properties" "$config_dir/application.properties"
        echo "✓ Created from sample"
    else
        echo "✗ Sample configuration not found"
        return 1
    fi
}

# Default directory paths (can be overridden with environment variables)
ATTACHMENT_DIR="${ATTACHMENT_DIR:-/var/opencbs/attachments}"
TEMPLATE_DIR="${TEMPLATE_DIR:-/var/opencbs/templates}"
LOG_DIR="${LOG_DIR:-/var/log/opencbs}"

echo ""
echo "Configuration:"
echo "  Attachment directory: $ATTACHMENT_DIR"
echo "  Template directory:   $TEMPLATE_DIR"
echo "  Log directory:        $LOG_DIR"
echo ""

# Create directories
create_directory "$ATTACHMENT_DIR" "attachments"
create_directory "$TEMPLATE_DIR" "templates"  
create_directory "$LOG_DIR" "logs"

# Setup configuration
echo ""
setup_configuration

echo ""
echo "Setup Summary:"
echo "=============="
echo "✓ Created directory structure"
echo "✓ Set proper permissions"

if [ -w "$ATTACHMENT_DIR" ] && [ -w "$TEMPLATE_DIR" ]; then
    echo "✓ Directories are writable"
else
    echo "⚠ Some directories may not be writable by the application"
    echo "  Consider running: sudo chown -R [app-user]:[app-group] $ATTACHMENT_DIR $TEMPLATE_DIR"
fi

echo ""
echo "Next Steps:"
echo "==========="
echo "1. Review and edit the configuration file:"
echo "   $PWD/opencbs-server/src/main/resources/application.properties"
echo ""
echo "2. Update these key settings:"
echo "   - Database connection (spring.datasource.*)"
echo "   - Email SMTP settings (spring.mail.*)"
echo "   - RabbitMQ connection (spring.rabbitmq.*)"
echo "   - Directory paths if different from defaults"
echo ""
echo "3. Create database and user:"
echo "   CREATE DATABASE opencbs_cloud;"
echo "   CREATE USER opencbs WITH PASSWORD 'your_password';"
echo "   GRANT ALL PRIVILEGES ON DATABASE opencbs_cloud TO opencbs;"
echo ""
echo "4. Install and configure RabbitMQ if using message queues"
echo ""
echo "5. Test the configuration by starting the application"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "⚠ Warning: Running as root. Consider creating a dedicated user:"
    echo "  sudo useradd -m opencbs"
    echo "  sudo chown -R opencbs:opencbs /var/opencbs /var/log/opencbs"
fi

echo "Setup complete! 🎉"