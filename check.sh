#!/bin/bash

# DockerPress System Check Script
# Checks if all services are running correctly

echo "========================================="
echo "🔍 DockerPress System Check"
echo "========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0

# Function to check service
check_service() {
    SERVICE=$1
    if docker-compose ps | grep -q "$SERVICE.*Up"; then
        echo -e "${GREEN}✓${NC} $SERVICE is running"
    else
        echo -e "${RED}✗${NC} $SERVICE is not running"
        ((ERRORS++))
    fi
}

# Function to check URL
check_url() {
    URL=$1
    NAME=$2
    if curl -s -o /dev/null -w "%{http_code}" "$URL" | grep -q "200\|301\|302"; then
        echo -e "${GREEN}✓${NC} $NAME is accessible ($URL)"
    else
        echo -e "${YELLOW}⚠${NC} $NAME may not be ready yet ($URL)"
    fi
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}✗ Docker is not running${NC}"
    exit 1
fi

echo "Checking Docker services..."
echo ""

# Check all services
check_service "wordpress"
check_service "mariadb"
check_service "keydb"
check_service "nginx"
check_service "adminer"
check_service "portainer"
check_service "grafana"
check_service "prometheus"
check_service "loki"
check_service "promtail"
check_service "mailhog"
check_service "fail2ban"
check_service "node-exporter"
check_service "cadvisor"
check_service "wpcli"
check_service "backup"

echo ""
echo "Checking service URLs..."
echo ""

# Check URLs (with timeout)
check_url "http://localhost:8080" "WordPress"
check_url "http://localhost:8081" "Adminer"
check_url "http://localhost:9000" "Portainer"
check_url "http://localhost:3000" "Grafana"
check_url "http://localhost:8025" "Mailhog"
check_url "http://localhost:9090" "Prometheus"
check_url "http://localhost:3100/ready" "Loki"

echo ""
echo "Checking disk usage..."
echo ""

# Check Docker disk usage
docker system df

echo ""
echo "Checking volumes..."
echo ""

# List volumes
docker volume ls | grep dockerpress

echo ""
echo "========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All services are running correctly!${NC}"
else
    echo -e "${RED}✗ $ERRORS service(s) have issues${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "  1. Check logs: docker-compose logs -f"
    echo "  2. Restart services: docker-compose restart"
    echo "  3. Rebuild: docker-compose up -d --build"
fi
echo "========================================="
echo ""
