#!/bin/bash

# DockerPress Quick Start Script
# This script helps you set up DockerPress quickly

set -e

echo "========================================="
echo "🚀 DockerPress Quick Start"
echo "========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed. Please install Docker Compose first.${NC}"
    echo "Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

echo -e "${GREEN}✓ Docker and Docker Compose are installed${NC}"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠ .env file not found. Creating from .env.example...${NC}"
    cp .env.example .env
    
    # Generate random passwords
    DB_PASS=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)
    ROOT_PASS=$(openssl rand -base64 32 | tr -d "=+/" | cut -c1-25)
    GRAFANA_PASS=$(openssl rand -base64 16 | tr -d "=+/" | cut -c1-16)
    
    # Update passwords in .env
    sed -i "s/change_this_secure_password/$DB_PASS/" .env
    sed -i "s/change_this_root_password/$ROOT_PASS/" .env
    sed -i "s/change_this_password/$GRAFANA_PASS/" .env
    
    echo -e "${GREEN}✓ .env file created with random passwords${NC}"
    echo ""
    echo -e "${YELLOW}⚠ IMPORTANT: Generate WordPress salts at https://roots.io/salts.html${NC}"
    echo -e "${YELLOW}  and update the keys in .env file${NC}"
    echo ""
else
    echo -e "${GREEN}✓ .env file exists${NC}"
    echo ""
fi

# Ask user if they want to start services
echo "Do you want to start DockerPress now? (y/n)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo ""
    echo "Starting DockerPress services..."
    docker-compose up -d
    
    echo ""
    echo -e "${GREEN}✓ DockerPress is starting!${NC}"
    echo ""
    echo "========================================="
    echo "📋 Access your services at:"
    echo "========================================="
    echo "WordPress:    http://localhost:8080"
    echo "Adminer:      http://localhost:8081"
    echo "Portainer:    http://localhost:9000"
    echo "Grafana:      http://localhost:3000"
    echo "Mailhog:      http://localhost:8025"
    echo "Prometheus:   http://localhost:9090"
    echo ""
    echo -e "${YELLOW}Note: It may take a few minutes for all services to be ready.${NC}"
    echo ""
    echo "View logs with: docker-compose logs -f"
    echo "========================================="
else
    echo ""
    echo "Setup complete! Start DockerPress anytime with:"
    echo "  docker-compose up -d"
    echo ""
fi

echo ""
echo -e "${GREEN}🎉 DockerPress setup completed!${NC}"
echo ""
