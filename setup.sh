#!/bin/bash

# Paperless Quick Setup Script
# This script helps users quickly set up Paperless with mobile sync

set -e

echo "🚀 Paperless Mobile Sync Quick Setup"
echo "===================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo "Please install Docker Desktop from: https://www.docker.com/products/docker-desktop/"
    exit 1
fi

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not available!"
    echo "Please ensure Docker Desktop is properly installed."
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Get user's IP address
echo "🔍 Detecting your IP address..."
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "Your IP address: $IP_ADDRESS"
echo ""

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cp env.example .env
fi

# Update .env with IP address
echo "🔧 Updating configuration..."
sed -i "s|PAPERLESS_URL=http://localhost:8000|PAPERLESS_URL=http://$IP_ADDRESS:8000|g" .env
sed -i "s|PAPERLESS_URL=http://localhost:8001|PAPERLESS_URL=http://$IP_ADDRESS:8000|g" .env

echo "✅ Configuration updated with your IP address"
echo ""

# Ask for admin password
echo "🔐 Please set a secure admin password:"
read -s -p "Enter password: " ADMIN_PASSWORD
echo ""

if [ -z "$ADMIN_PASSWORD" ]; then
    ADMIN_PASSWORD="admin123"
    echo "⚠️  Using default password: admin123"
    echo "   Please change this after setup!"
fi

# Update password in .env
sed -i "s|PAPERLESS_ADMIN_PASSWORD=.*|PAPERLESS_ADMIN_PASSWORD=$ADMIN_PASSWORD|g" .env

echo "✅ Admin password configured"
echo ""

# Start services
echo "🚀 Starting Paperless services..."
docker compose up -d

echo "⏳ Waiting for services to start..."
sleep 10

# Check if services are running
if docker compose ps | grep -q "Up.*healthy"; then
    echo "✅ Paperless is running successfully!"
    echo ""
    echo "🌐 Access your Paperless instance:"
    echo "   URL: http://$IP_ADDRESS:8000"
    echo "   Username: admin"
    echo "   Password: $ADMIN_PASSWORD"
    echo ""
    echo "📱 For Android mobile setup:"
    echo "   1. Install 'Paperless' app from Google Play Store"
    echo "   2. Add server: http://$IP_ADDRESS:8000"
    echo "   3. Username: admin"
    echo "   4. Password: $ADMIN_PASSWORD"
    echo ""
    echo "📖 For detailed instructions, see: SETUP_GUIDE.md"
    echo ""
    echo "🎉 Setup complete! Your documents can now sync between PC and mobile!"
else
    echo "❌ Services failed to start properly"
    echo "Check logs with: docker compose logs"
    exit 1
fi
