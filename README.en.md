# 🚀 DockerPress

**Modern and powerful Docker composition for WordPress with Bedrock and Sage**

DockerPress is a production-ready solution for running WordPress using modern technologies and DevOps best practices.

## ✨ Features

### 🎯 Core Stack
- **[Bedrock](https://roots.io/bedrock/)** - modern WordPress structure with Composer
- **[Sage 10](https://roots.io/sage/)** - advanced theme starter with Laravel Blade
- **MariaDB 11.2** - high-performance database
- **KeyDB** - multi-threaded Redis for caching
- **Nginx** - optimized reverse proxy

### 🛠️ Management Tools
- **Portainer** - web interface for Docker management
- **Adminer** - lightweight and fast database manager
- **WP-CLI** - command line for WordPress
- **Mailhog** - email capture and testing

### 📊 Monitoring & Logs
- **Grafana** - metrics and logs visualization
- **Prometheus** - metrics collection
- **Loki** - log aggregation
- **Promtail** - log collector
- **cAdvisor** - container metrics
- **Node Exporter** - system metrics

### 🔒 Security
- **Fail2Ban** - protection against brute-force attacks
- **Rate limiting** - request limiting
- **Security headers** - protective headers
- Access blocking to sensitive files

### 💾 Backup
- Automatic DB and files backup
- Configurable retention (default 30 days)

## 📋 Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+
- Minimum 2GB RAM (4GB+ recommended)
- 10GB free disk space

## 🚀 Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/dockerpress.git
cd dockerpress
```

### 2. Environment Setup

```bash
# Copy example configuration
cp .env.example .env

# Edit .env and change passwords and keys
nano .env
```

**Important:** Generate new WordPress keys at https://roots.io/salts.html

### 3. Launch

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

### 4. Access Services

| Service | URL | Credentials |
|---------|-----|-------------|
| WordPress | http://localhost:8080 | Setup on first run |
| Adminer | http://localhost:8081 | Server: mariadb |
| Portainer | http://localhost:9000 | Create on first run |
| Grafana | http://localhost:3000 | admin / admin (see .env) |
| Mailhog | http://localhost:8025 | - |
| Prometheus | http://localhost:9090 | - |

## 📦 Installing Sage Theme

After starting containers:

```bash
# Enter WordPress container
docker-compose exec wordpress bash

# Navigate to themes directory
cd /var/www/html/web/app/themes

# Install Sage
composer create-project roots/sage

# Navigate to theme folder
cd sage

# Install dependencies
npm install

# Start development server
npm run dev

# Or build for production
npm run build
```

## 🔧 WP-CLI Commands

```bash
# Execute WP-CLI commands
docker-compose exec wpcli wp --info

# Examples:
docker-compose exec wpcli wp plugin list
docker-compose exec wpcli wp theme list
docker-compose exec wpcli wp user list
docker-compose exec wpcli wp cache flush
```

## 💾 Backup

Automatic backup runs every 24 hours.

### Manual Backup:

```bash
docker-compose exec backup /backup.sh
```

### Restore from Backup:

```bash
# Database
gunzip < backups/database/wordpress_YYYY-MM-DD_HH-MM-SS.sql.gz | \
  docker-compose exec -T mariadb mysql -uwordpress -pYOUR_PASSWORD wordpress

# Files
docker-compose exec wordpress bash
tar -xzf /backups/files/wordpress_files_YYYY-MM-DD_HH-MM-SS.tar.gz -C /var/www/html/
```

## 📊 Monitoring

### Grafana Dashboards

After first login to Grafana (http://localhost:3000):

1. Go to Configuration → Data Sources
2. Verify Prometheus and Loki are connected
3. Import ready-made dashboards:
   - Docker Container Monitoring
   - System Metrics
   - WordPress Performance

### View Logs in Grafana

1. Go to Explore
2. Select Loki as data source
3. Use queries:
   ```
   {service="wordpress"}
   {service="nginx"} |= "error"
   {container="dockerpress_wordpress"} |= "fatal"
   ```

## 🔒 Security

### Production Recommendations:

1. **Change all passwords** in `.env`
2. **Generate new WordPress salts**
3. **Configure SSL certificates**:
   ```bash
   # Uncomment SSL section in nginx/conf.d/wordpress.conf
   # Add certificates to nginx/ssl/
   ```
4. **Configure firewall**:
   ```bash
   # Allow only necessary ports
   ufw allow 80/tcp
   ufw allow 443/tcp
   ufw enable
   ```
5. **Regular updates**:
   ```bash
   docker-compose pull
   docker-compose up -d
   ```

### Fail2Ban

Fail2Ban automatically blocks suspicious activity. View blocked IPs:

```bash
docker-compose exec fail2ban fail2ban-client status
```

## 🐛 Debugging

### View Logs:

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f wordpress
docker-compose logs -f mariadb
docker-compose logs -f nginx
```

### Check Status:

```bash
docker-compose ps
```

### Enter Container:

```bash
docker-compose exec wordpress bash
docker-compose exec mariadb bash
```

## 📁 Project Structure

```
dockerpress/
├── .docker/              # Docker files
│   └── wordpress/        # Bedrock WordPress Dockerfile
├── backups/              # Automatic backups
│   ├── database/         # SQL dumps
│   └── files/            # File archives
├── fail2ban/             # Fail2Ban configuration
├── grafana/              # Grafana settings and dashboards
│   ├── provisioning/     # Automatic setup
│   └── dashboards/       # JSON dashboards
├── loki/                 # Loki configuration
├── nginx/                # Nginx configuration
│   ├── conf.d/           # Sites
│   └── ssl/              # SSL certificates
├── prometheus/           # Prometheus configuration
├── promtail/             # Promtail configuration
├── scripts/              # Helper scripts
│   ├── backup.sh         # Backup script
│   └── mariadb-tuning.cnf # MariaDB optimization
├── .env.example          # Environment variables example
├── docker-compose.yml    # Main composition
├── uploads.ini           # PHP upload settings
└── README.md             # This documentation
```

## 🔄 Updates

```bash
# Stop and remove containers (data will persist)
docker-compose down

# Update images
docker-compose pull

# Start with new images
docker-compose up -d

# Check versions
docker-compose exec wordpress php -v
docker-compose exec mariadb mysql --version
```

## 🤝 Contributing

If you found a bug or want to suggest an improvement:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📝 License

MIT License - see [LICENSE](LICENSE) file

## 🙏 Acknowledgments

- [Roots.io](https://roots.io/) - for Bedrock and Sage
- [KeyDB](https://docs.keydb.dev/) - for multi-threaded Redis
- [Grafana Labs](https://grafana.com/) - for Loki and Grafana
- All open-source project contributors

## 📞 Support

- 🐛 [Issues](https://github.com/yourusername/dockerpress/issues)
- 💬 [Discussions](https://github.com/yourusername/dockerpress/discussions)
- 📧 Email: your@email.com

---

**Made with ❤️ for WordPress community**
