#!/bin/bash

# WebDNA Application Startup Script
# This script initializes and starts the WebDNA application with Apache

set -e

echo "Starting WebDNA Application Container..."

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Wait for MySQL to be ready
log "Waiting for MySQL database to be ready..."
while ! mysqladmin ping -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    log "MySQL is not ready yet, waiting 5 seconds..."
    sleep 5
done
log "MySQL is ready!"

# Initialize WebDNA if not already done
if [ ! -f /opt/webdna/.initialized ]; then
    log "Initializing WebDNA for first run..."
    
    # Run WebDNA configurator for FastCGI setup
    log "Running WebDNA configurator..."
    webdna-configurator-fcgi
    
    # Set proper permissions for WebDNA
    chown -R www-data:www-data /var/www/html
    chmod -R 755 /var/www/html
    
    # Ensure WebDNA can write to necessary directories
    mkdir -p /var/www/html/WebCatalog
    chown -R www-data:www-data /var/www/html/WebCatalog
    chmod -R 755 /var/www/html/WebCatalog
    
    touch /opt/webdna/.initialized
    log "WebDNA initialization completed"
fi

# Configure Apache for WebDNA
log "Configuring Apache for WebDNA..."

# Enable the WebDNA site configuration
if [ -f /etc/apache2/sites-available/webdna.conf ]; then
    a2ensite webdna.conf
    log "WebDNA site configuration enabled"
else
    log "Warning: WebDNA site configuration not found, using default"
fi

# Disable default Apache site
a2dissite 000-default.conf || true

# Set proper permissions for html directory
chown -R www-data:www-data "$WEBDNA_HTML_PATH"
chmod -R 755 "$WEBDNA_HTML_PATH"

# Set Apache log level
sed -i "s/LogLevel .*/LogLevel $APACHE_LOG_LEVEL/" /etc/apache2/apache2.conf

# Test Apache configuration
log "Testing Apache configuration..."
apache2ctl configtest

# Start Apache in foreground
log "Starting Apache web server..."
exec apache2ctl -D FOREGROUND
