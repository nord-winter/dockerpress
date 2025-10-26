# 📚 DockerPress Quick Reference

## 🚀 Essential Commands

### Starting & Stopping
```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose down

# Restart specific service
docker-compose restart wordpress

# View status
docker-compose ps
```

### Logs
```bash
# All logs
docker-compose logs -f

# Specific service
docker-compose logs -f wordpress
docker-compose logs -f nginx

# Last 100 lines
docker-compose logs --tail=100 wordpress
```

### Access Containers
```bash
# WordPress/Bedrock
docker-compose exec wordpress bash

# MariaDB
docker-compose exec mariadb bash
docker-compose exec mariadb mysql -uwordpress -p wordpress

# WP-CLI
docker-compose exec wpcli wp --info
```

## 🔧 Common Tasks

### WordPress Management
```bash
# List plugins
docker-compose exec wpcli wp plugin list

# Activate plugin
docker-compose exec wpcli wp plugin activate plugin-name

# List themes
docker-compose exec wpcli wp theme list

# Flush cache
docker-compose exec wpcli wp cache flush

# Update WordPress core
docker-compose exec wpcli wp core update
```

### Database Operations
```bash
# Backup database
docker-compose exec backup /backup.sh

# Access database
docker-compose exec mariadb mysql -uwordpress -p wordpress

# Import SQL
docker-compose exec -T mariadb mysql -uwordpress -p wordpress < backup.sql

# Export SQL
docker-compose exec mariadb mysqldump -uwordpress -p wordpress > backup.sql
```

### Sage Theme Development
```bash
# Enter WordPress container
docker-compose exec wordpress bash

# Navigate to theme
cd /var/www/html/web/app/themes/sage

# Install dependencies
npm install

# Development mode (hot reload)
npm run dev

# Production build
npm run build
```

## 📊 Monitoring

### Grafana Queries (Explore → Loki)
```
# WordPress errors
{service="wordpress"} |= "error"

# Nginx errors
{service="nginx"} |= "error"

# Slow queries
{service="mariadb"} |= "slow"

# Failed login attempts
{service="wordpress"} |= "login" |= "failed"

# All logs from specific container
{container="dockerpress_wordpress"}
```

### Prometheus Queries
```
# Container CPU usage
rate(container_cpu_usage_seconds_total[5m])

# Container memory
container_memory_usage_bytes

# Network traffic
rate(container_network_receive_bytes_total[5m])
```

## 🔒 Security

### Fail2Ban Commands
```bash
# Check status
docker-compose exec fail2ban fail2ban-client status

# Unban IP
docker-compose exec fail2ban fail2ban-client set jail-name unbanip IP_ADDRESS

# View banned IPs
docker-compose exec fail2ban fail2ban-client status jail-name
```

### SSL Setup
```bash
# Generate self-signed certificate (development)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/key.pem \
  -out nginx/ssl/cert.pem

# Uncomment SSL section in nginx/conf.d/wordpress.conf
# Restart nginx
docker-compose restart nginx
```

## 💾 Backup & Restore

### Manual Backup
```bash
# Full backup (DB + files)
docker-compose exec backup /backup.sh

# Database only
docker-compose exec mariadb mysqldump -uwordpress -p wordpress | gzip > backup_$(date +%F).sql.gz

# Files only
docker-compose exec wordpress tar -czf backup_files.tar.gz -C /var/www/html web/app/uploads web/app/themes web/app/plugins
```

### Restore
```bash
# Restore database
gunzip < backup.sql.gz | docker-compose exec -T mariadb mysql -uwordpress -p wordpress

# Restore files
docker-compose exec wordpress tar -xzf /backups/files/backup_files.tar.gz -C /var/www/html/
```

## 🐛 Troubleshooting

### Service won't start
```bash
# Check logs
docker-compose logs service-name

# Rebuild container
docker-compose up -d --build service-name

# Remove and recreate
docker-compose rm -f service-name
docker-compose up -d service-name
```

### Database connection issues
```bash
# Check MariaDB is running
docker-compose ps mariadb

# Check credentials in .env
cat .env | grep DB_

# Test connection
docker-compose exec mariadb mysql -uwordpress -p -e "SELECT 1"
```

### WordPress issues
```bash
# Enable debug mode
# Edit .env: WP_DEBUG=true

# Check PHP errors
docker-compose exec wordpress tail -f /var/www/html/web/app/debug.log

# Reset permalinks
docker-compose exec wpcli wp rewrite flush
```

### Clear everything and start fresh
```bash
# WARNING: This removes all data!
docker-compose down -v
docker-compose up -d
```

## 🔄 Updates

### Update Docker images
```bash
# Stop services
docker-compose down

# Pull latest images
docker-compose pull

# Start with new images
docker-compose up -d

# Clean old images
docker image prune -a
```

### Update WordPress
```bash
# Update core
docker-compose exec wpcli wp core update

# Update plugins
docker-compose exec wpcli wp plugin update --all

# Update themes
docker-compose exec wpcli wp theme update --all
```

## 📱 URLs

- WordPress: http://localhost:8080
- Adminer: http://localhost:8081
- Portainer: http://localhost:9000
- Grafana: http://localhost:3000
- Mailhog: http://localhost:8025
- Prometheus: http://localhost:9090

## 🆘 Need Help?

- Check logs: `docker-compose logs -f`
- View status: `docker-compose ps`
- Read documentation: [README.md](README.md)
- Open issue: https://github.com/yourusername/dockerpress/issues
