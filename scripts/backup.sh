#!/bin/bash

# DockerPress Backup Script
# Backs up MariaDB database and WordPress files

set -e

# Configuration
BACKUP_DIR="/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
DB_BACKUP_DIR="$BACKUP_DIR/database"
FILES_BACKUP_DIR="$BACKUP_DIR/files"
RETENTION_DAYS=30

# Create backup directories
mkdir -p "$DB_BACKUP_DIR"
mkdir -p "$FILES_BACKUP_DIR"

echo "========================================="
echo "DockerPress Backup Started: $DATE"
echo "========================================="

# Backup Database
echo "Backing up database..."
mysqldump -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" \
    --single-transaction \
    --quick \
    --lock-tables=false \
    | gzip > "$DB_BACKUP_DIR/wordpress_${DATE}.sql.gz"

if [ $? -eq 0 ]; then
    echo "✓ Database backup completed: wordpress_${DATE}.sql.gz"
else
    echo "✗ Database backup failed!"
    exit 1
fi

# Backup WordPress files (uploads, themes, plugins)
echo "Backing up WordPress files..."
tar -czf "$FILES_BACKUP_DIR/wordpress_files_${DATE}.tar.gz" \
    -C /var/www/html \
    web/app/uploads \
    web/app/themes \
    web/app/plugins \
    2>/dev/null || true

if [ $? -eq 0 ]; then
    echo "✓ Files backup completed: wordpress_files_${DATE}.tar.gz"
else
    echo "✗ Files backup failed!"
fi

# Calculate sizes
DB_SIZE=$(du -h "$DB_BACKUP_DIR/wordpress_${DATE}.sql.gz" | cut -f1)
FILES_SIZE=$(du -h "$FILES_BACKUP_DIR/wordpress_files_${DATE}.tar.gz" | cut -f1 2>/dev/null || echo "N/A")

echo ""
echo "Backup sizes:"
echo "  Database: $DB_SIZE"
echo "  Files: $FILES_SIZE"

# Clean up old backups
echo ""
echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$DB_BACKUP_DIR" -name "*.sql.gz" -mtime +$RETENTION_DAYS -delete
find "$FILES_BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
echo "✓ Cleanup completed"

echo ""
echo "========================================="
echo "DockerPress Backup Completed: $(date +%Y-%m-%d_%H-%M-%S)"
echo "========================================="
