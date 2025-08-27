#!/bin/bash

# OpenCBS Docker Setup Script
# This script helps set up the Docker environment for OpenCBS

set -e

echo "🚀 OpenCBS Docker Setup Script"
echo "==============================="

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file from template if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp docker-compose.env .env
    echo "✅ Created .env file. Please review and update it with your configuration."
else
    echo "✅ .env file already exists."
fi

# Create required directories
echo "📁 Creating required directories..."
mkdir -p ./data/attachments
mkdir -p ./data/templates  
mkdir -p ./data/postgres
mkdir -p ./data/rabbitmq

# Set proper permissions
echo "🔒 Setting directory permissions..."
chmod -R 755 ./data

echo ""
echo "🎯 Docker Setup Summary"
echo "======================="
echo "✅ Environment file: .env"
echo "✅ Data directories created in ./data/"
echo "✅ Docker Compose configuration: docker-compose.yml"
echo ""
echo "📋 Next Steps:"
echo "1. Review and update the .env file with your configuration"
echo "2. Run 'docker-compose up -d' to start all services"
echo "3. Access OpenCBS at http://localhost:8080"
echo "4. Access RabbitMQ Management at http://localhost:15672"
echo "5. Access PgAdmin at http://localhost:8081 (optional)"
echo ""
echo "🔧 Useful Commands:"
echo "- Start services: docker-compose up -d"
echo "- View logs: docker-compose logs -f opencbs-server"
echo "- Stop services: docker-compose down"
echo "- Reset data: docker-compose down -v"
echo ""
echo "⚠️  Note: The first build may take 10-15 minutes as it downloads"
echo "   dependencies and builds both the Java backend and Angular frontend."