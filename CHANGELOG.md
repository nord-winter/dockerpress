# Changelog

All notable changes to DockerPress will be documented in this file.

## [1.0.0] - 2024-10-27

### Added
- Initial release of DockerPress
- Bedrock WordPress integration
- Sage 10 theme support
- MariaDB 11.2 as database
- KeyDB for caching (multi-threaded Redis alternative)
- Nginx reverse proxy with optimization
- Portainer for Docker management
- Adminer for database management
- WP-CLI for command-line operations
- Mailhog for email testing
- Complete monitoring stack:
  - Grafana for visualization
  - Prometheus for metrics
  - Loki for log aggregation
  - Promtail for log collection
  - cAdvisor for container metrics
  - Node Exporter for system metrics
- Fail2Ban for security
- Automatic backup system
- SSL support (ready for production)
- Comprehensive documentation:
  - README in Russian and English
  - Quick Reference Guide
  - Contributing Guidelines
- Quick start script
- Environment configuration template
- Security hardening:
  - Rate limiting
  - Security headers
  - Sensitive files blocking
- Docker Compose with profiles
- Grafana dashboards
- MariaDB tuning configuration

### Features
- Production-ready setup
- Development and production profiles
- Automatic daily backups
- 30-day backup retention
- Log rotation
- Multi-language support
- One-command startup
- Hot reload for development

## [Unreleased]

### Planned
- Elasticsearch integration (optional)
- Redis Insights dashboard
- Automated SSL with Certbot
- WordPress multisite support
- Additional Grafana dashboards
- Backup to S3/external storage
- Health check endpoints
- Auto-scaling configuration
- CI/CD pipeline examples
