# 🚀 DockerPress

<div align="center">

![DockerPress Logo](https://img.shields.io/badge/Docker-Press-2496ED?style=for-the-badge&logo=docker&logoColor=white)

**Production-ready WordPress with Bedrock, Sage, and complete DevOps stack**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![WordPress](https://img.shields.io/badge/WordPress-Bedrock-21759B?style=flat&logo=wordpress&logoColor=white)](https://roots.io/bedrock/)
[![MariaDB](https://img.shields.io/badge/MariaDB-11.2-003545?style=flat&logo=mariadb&logoColor=white)](https://mariadb.org/)

[English](README.en.md) | [Русский](README.md)

</div>

---

## 📑 Table of Contents

- [Features](#-features)
- [Quick Start](#-quick-start)
- [Architecture](#-architecture)
- [Services](#-services)
- [Documentation](#-documentation)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎯 Core Stack
- **Bedrock WordPress** - Modern structure
- **Sage 10** - Advanced theme starter
- **MariaDB 11.2** - High performance DB
- **KeyDB** - Multi-threaded Redis
- **Nginx** - Optimized reverse proxy

</td>
<td width="50%">

### 🛠️ Management
- **Portainer** - Docker web UI
- **Adminer** - Database manager
- **WP-CLI** - Command line tools
- **Mailhog** - Email testing
- **Node.js** - Theme development

</td>
</tr>
<tr>
<td>

### 📊 Monitoring & Logs
- **Grafana** - Visualization
- **Prometheus** - Metrics collection
- **Loki** - Log aggregation
- **Promtail** - Log collector
- **cAdvisor** - Container metrics

</td>
<td>

### 🔒 Security & Backup
- **Fail2Ban** - Brute-force protection
- **Rate limiting** - Request throttling
- **Security headers** - XSS, CSRF protection
- **Auto backups** - Daily DB & files backup
- **SSL ready** - HTTPS support

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- 2GB RAM minimum (4GB+ recommended)
- 10GB free disk space

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/dockerpress.git
cd dockerpress

# Run quick start script
chmod +x start.sh
./start.sh

# Or manually
cp .env.example .env
# Edit .env with your settings
docker-compose up -d
```

### Access Your Services

| Service | URL | Default Credentials |
|---------|-----|---------------------|
| 🌐 WordPress | http://localhost:8080 | Setup on first run |
| 🗄️ Adminer | http://localhost:8081 | Server: `mariadb` |
| 🐳 Portainer | http://localhost:9000 | Create on first run |
| 📊 Grafana | http://localhost:3000 | admin / admin |
| 📧 Mailhog | http://localhost:8025 | - |
| 📈 Prometheus | http://localhost:9090 | - |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Nginx (Port 80/443)                  │
│                      Reverse Proxy + SSL                     │
└────────────────────────┬────────────────────────────────────┘
                         │
           ┌─────────────┴──────────────┐
           │                            │
┌──────────▼──────────┐      ┌─────────▼────────┐
│   WordPress         │      │    Monitoring     │
│   (Bedrock + Sage)  │      │                   │
│                     │      │  - Grafana        │
│  - PHP-FPM          │      │  - Prometheus     │
│  - Composer         │      │  - Loki           │
│  - WP-CLI           │      │  - Promtail       │
└──────────┬──────────┘      └───────────────────┘
           │
    ┌──────┴──────┐
    │             │
┌───▼────┐   ┌───▼─────┐
│MariaDB │   │  KeyDB  │
│  11.2  │   │ (Redis) │
└────────┘   └─────────┘
```

---

## 📦 Services

<details>
<summary><b>🌐 WordPress (Bedrock)</b></summary>

- Modern WordPress boilerplate
- Composer for dependency management
- Environment-based configuration
- Enhanced folder structure
- Better security defaults

</details>

<details>
<summary><b>🎨 Sage Theme</b></summary>

- Laravel Blade templating
- Webpack/Vite asset bundling
- Tailwind CSS support
- Hot module replacement
- Modern JavaScript (ES6+)

</details>

<details>
<summary><b>🗄️ MariaDB</b></summary>

- High-performance MySQL fork
- Optimized configuration
- Automatic backups
- Slow query logging
- UTF8MB4 support

</details>

<details>
<summary><b>⚡ KeyDB</b></summary>

- Multi-threaded Redis alternative
- 5x faster than Redis
- 100% Redis compatible
- Active replication
- FLASH storage support

</details>

<details>
<summary><b>📊 Grafana Stack</b></summary>

- Beautiful dashboards
- Real-time metrics
- Log exploration (Loki)
- Alerting system
- Data source provisioning

</details>

<details>
<summary><b>🔒 Fail2Ban</b></summary>

- Automatic IP banning
- Protection against brute-force
- Custom jail rules
- WordPress-specific filters
- Email notifications

</details>

---

## 📚 Documentation

- [📖 Quick Reference](QUICK-REFERENCE.md) - Common commands and tasks
- [🇬🇧 English README](README.en.md) - Full documentation in English
- [🤝 Contributing](CONTRIBUTING.md) - How to contribute
- [📋 Changelog](CHANGELOG.md) - Version history

### Useful Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Check system status
./check.sh

# Access WP-CLI
docker-compose exec wpcli wp --info

# Manual backup
docker-compose exec backup /backup.sh

# Stop services
docker-compose down
```

---

## 🎯 Use Cases

### 🚀 Development
- Hot reload for theme development
- Email testing with Mailhog
- Debug logs in Grafana
- Quick database access

### 🏢 Production
- Automated backups
- Security hardening
- Performance monitoring
- Log aggregation
- Fail2Ban protection

### 📊 Enterprise
- Complete monitoring stack
- Metrics and alerting
- Centralized logging
- Container orchestration
- Scalability ready

---

## 🔧 Configuration

### Environment Variables

Key variables in `.env`:

```env
# Database
DB_PASSWORD=your_secure_password
MYSQL_ROOT_PASSWORD=your_root_password

# WordPress
WP_ENV=production
WP_HOME=https://yourdomain.com
WP_DEBUG=false

# Security Keys
AUTH_KEY=generate-at-roots.io/salts
# ... more keys

# Monitoring
GRAFANA_PASSWORD=admin
```

### SSL Setup

```bash
# Generate self-signed certificate (dev)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/key.pem -out nginx/ssl/cert.pem

# For production, use Let's Encrypt
# See documentation for Certbot integration
```

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md).

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/dockerpress&type=Date)](https://star-history.com/#yourusername/dockerpress&Date)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Roots.io](https://roots.io/) - Bedrock and Sage
- [KeyDB](https://docs.keydb.dev/) - Multi-threaded Redis
- [Grafana Labs](https://grafana.com/) - Loki and Grafana
- All open-source contributors

---

## 📞 Support

- 🐛 [Report Bug](https://github.com/yourusername/dockerpress/issues)
- 💡 [Request Feature](https://github.com/yourusername/dockerpress/issues)
- 💬 [Discussions](https://github.com/yourusername/dockerpress/discussions)

---

<div align="center">

**Made with ❤️ for the WordPress Community**

[![GitHub stars](https://img.shields.io/github/stars/yourusername/dockerpress?style=social)](https://github.com/yourusername/dockerpress/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/yourusername/dockerpress?style=social)](https://github.com/yourusername/dockerpress/network/members)

</div>
