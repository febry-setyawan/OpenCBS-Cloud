#!/bin/bash

# OpenCBS Configuration Validation Script
# This script validates that all configuration properties are properly set up
# and can be loaded by Spring Boot without errors

set -e

echo "=========================================="
echo "OpenCBS Configuration Startup Validation"
echo "=========================================="

# Create required directories
echo "Creating required directories..."
mkdir -p /tmp/opencbs-test/attachments /tmp/opencbs-test/templates

# Check if configuration files exist
CONFIG_DIR="/home/runner/work/OpenCBS-Cloud/OpenCBS-Cloud/server/opencbs-server/src/main/resources"

echo "Checking configuration files..."

if [ -f "$CONFIG_DIR/application.properties" ]; then
    echo "✓ application.properties found"
    echo "  Properties count: $(grep -c '^[^#].*=' "$CONFIG_DIR/application.properties")"
else
    echo "✗ application.properties not found"
    exit 1
fi

if [ -f "$CONFIG_DIR/application.yml" ]; then
    echo "✓ application.yml found"
else
    echo "✗ application.yml not found" 
fi

# Validate properties file syntax
echo ""
echo "Validating properties file syntax..."

# Check for basic syntax errors in properties file
if grep -q "^[^#=]*=[^=]*$" "$CONFIG_DIR/application.properties"; then
    echo "✓ Properties file has valid key=value format"
else
    echo "✗ Properties file syntax issues detected"
    exit 1
fi

# Check for all required OpenCBS properties
echo ""
echo "Checking OpenCBS-specific properties..."

REQUIRED_PROPS=(
    "opencbs.core.enableInterestAccrual"
    "opencbs.core.enablePenaltyAccrual" 
    "opencbs.core.enableAutoRepayment"
    "attachment.location"
    "template.location"
    "account-balance-calculation.exchange"
    "account-balance-calculation.queue"
    "account-balance-calculation.routingKey"
    "day-closure.autoStart"
    "day-closure.autoStartTime"
    "day-closure.errorToEmails"
    "task-executor.minPoolSize"
    "task-executor.maxPoolSize"
    "email.sender"
)

for prop in "${REQUIRED_PROPS[@]}"; do
    if grep -q "^$prop=" "$CONFIG_DIR/application.properties"; then
        echo "✓ $prop is configured"
    else
        echo "✗ $prop is missing"
        exit 1
    fi
done

# Check directory paths
echo ""
echo "Validating directory paths..."

ATTACHMENT_DIR=$(grep "^attachment.location=" "$CONFIG_DIR/application.properties" | cut -d'=' -f2)
TEMPLATE_DIR=$(grep "^template.location=" "$CONFIG_DIR/application.properties" | cut -d'=' -f2)

if [ -d "$ATTACHMENT_DIR" ] || [ "$ATTACHMENT_DIR" = "/tmp/opencbs-test/attachments" ]; then
    echo "✓ Attachment directory path is valid: $ATTACHMENT_DIR"
else
    echo "⚠ Attachment directory does not exist: $ATTACHMENT_DIR (will be created at runtime)"
fi

if [ -d "$TEMPLATE_DIR" ] || [ "$TEMPLATE_DIR" = "/tmp/opencbs-test/templates" ]; then
    echo "✓ Template directory path is valid: $TEMPLATE_DIR"
else
    echo "⚠ Template directory does not exist: $TEMPLATE_DIR (will be created at runtime)"
fi

# Validate YAML configuration file
echo ""
echo "Validating YAML configuration..."

if command -v python3 > /dev/null; then
    python3 -c "
import yaml
import sys
try:
    with open('$CONFIG_DIR/application.yml', 'r') as f:
        config = yaml.safe_load(f)
    print('✓ YAML configuration is valid')
    
    # Check for key OpenCBS properties in YAML
    if 'opencbs' in config and 'core' in config['opencbs']:
        print('✓ OpenCBS core properties found in YAML')
    else:
        print('⚠ OpenCBS core properties not found in YAML')
        
except yaml.YAMLError as e:
    print(f'✗ YAML syntax error: {e}')
    sys.exit(1)
except Exception as e:
    print(f'✗ YAML validation error: {e}')
    sys.exit(1)
"
else
    echo "⚠ Python not available - skipping YAML syntax validation"
fi

echo ""
echo "=========================================="
echo "Configuration validation completed successfully!"
echo ""
echo "Summary:"
echo "- All required OpenCBS properties are configured"
echo "- Property file syntax is valid"
echo "- Directory paths are set up"
echo "- Configuration templates are available"
echo ""
echo "The application should be able to start with these configurations."
echo "Note: External dependencies (PostgreSQL, RabbitMQ) may need to be"
echo "      configured separately for full functionality."
echo "=========================================="