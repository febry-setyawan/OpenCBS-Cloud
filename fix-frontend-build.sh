#!/bin/bash

# Node.js Frontend Build Fix Script
# Resolves OpenSSL compatibility issues with Node.js 17+ and older Angular/Webpack

echo "🔧 Node.js Frontend Build Fix"
echo "=============================="

# Check Node.js version
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo "📋 Current Node.js version: $NODE_VERSION"
else
    echo "❌ Node.js is not installed"
    exit 1
fi

# Set Node.js options for OpenSSL compatibility
export NODE_OPTIONS="--openssl-legacy-provider --max_old_space_size=4096"

echo "🔑 Applied Node.js compatibility fixes:"
echo "   NODE_OPTIONS=$NODE_OPTIONS"

# Navigate to client directory
if [ -d "client" ]; then
    cd client
    echo "📁 Changed to client directory"
else
    echo "❌ Client directory not found"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
if command -v yarn &> /dev/null; then
    yarn install
    echo "✅ Dependencies installed with Yarn"
    
    # Build the frontend
    echo "🏗️  Building Angular frontend..."
    if yarn build-prod; then
        echo "✅ Frontend build successful"
    else
        echo "⚠️  Frontend build failed - trying alternative approach"
        # Try with different build command
        npm run build || yarn build
    fi
elif command -v npm &> /dev/null; then
    npm install
    echo "✅ Dependencies installed with NPM"
    
    # Build the frontend  
    echo "🏗️  Building Angular frontend..."
    if npm run build-prod; then
        echo "✅ Frontend build successful"
    else
        echo "⚠️  Frontend build failed - check Angular/Node.js compatibility"
    fi
else
    echo "❌ Neither Yarn nor NPM found"
    exit 1
fi

echo ""
echo "🎯 Frontend Build Summary"
echo "========================="
echo "✅ Node.js OpenSSL compatibility fix applied"
echo "✅ Memory allocation increased to 4GB"
echo "📁 Built files should be in dist/ directory"
echo ""
echo "💡 To make this permanent, add to your environment:"
echo "   export NODE_OPTIONS=\"--openssl-legacy-provider --max_old_space_size=4096\""
echo ""
echo "🐳 For Docker deployment, this fix is already included in:"
echo "   - docker-compose.yml"
echo "   - Dockerfile with NODE_OPTIONS environment variable"