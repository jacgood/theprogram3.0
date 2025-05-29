# WebDNA Application Container
# Based on Ubuntu 22.04 LTS for WebDNA 8.6.5 FastCGI support

FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=America/New_York

# Install system dependencies including WebDNA requirements
RUN apt-get update && apt-get install -y \
    apache2 \
    apache2-dev \
    libapache2-mod-php \
    libapache2-mod-fcgid \
    mysql-client \
    curl \
    wget \
    unzip \
    vim \
    nano \
    tzdata \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Enable Apache modules that WebDNA needs
RUN a2enmod rewrite \
    && a2enmod headers \
    && a2enmod ssl \
    && a2enmod dav \
    && a2enmod dav_fs \
    && a2enmod fcgid

# Install WebDNA Apache module using official repository
# Add WebDNA repository and install
RUN curl https://deb.webdna.us/ubuntu23/webdna.key | gpg --dearmor > webdna.gpg \
    && install -o root -g root -m 644 webdna.gpg /etc/apt/trusted.gpg.d/ \
    && echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/webdna.gpg] https://deb.webdna.us/ubuntu23 lunar non-free" | tee -a /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y libapache2-mod-webdna=8.6.5 \
    && rm -rf /var/lib/apt/lists/*

# Enable WebDNA module
RUN a2enmod webdna

# Create WebDNA directories
RUN mkdir -p /opt/webdna \
    && mkdir -p /var/www/html \
    && mkdir -p /var/log/webdna

# Set proper permissions for Apache
RUN chown -R www-data:www-data /var/www/html \
    && chown -R www-data:www-data /var/log/webdna

# Copy WebDNA installation files (to be added)
# COPY webdna-binaries/ /opt/webdna/

# Copy Apache configuration
COPY apache-config/ /etc/apache2/sites-available/

# Copy startup script
COPY start-webdna.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-webdna.sh

# Environment variables for configuration
ENV WEBDNA_HTML_PATH=/var/www/html
ENV WEBDNA_LOG_LEVEL=info
ENV APACHE_LOG_LEVEL=warn
ENV MYSQL_HOST=mysql-db
ENV MYSQL_PORT=3306
ENV MYSQL_DATABASE=theprogram
ENV MYSQL_USER=webdna

# Expose HTTP port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start Apache and WebDNA
CMD ["/usr/local/bin/start-webdna.sh"]
