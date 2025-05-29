#!/bin/bash

# The Program Setup Script
# This script helps initialize the Docker environment for WebDNA application

set -e

echo "=== The Program Docker Setup ==="
echo "Setting up containerized WebDNA environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    print_status "Checking Docker installation..."
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_status "Docker and Docker Compose are installed."
}

# Setup secrets
setup_secrets() {
    print_status "Setting up database secrets..."
    
    if [ ! -f "config/secrets/mysql_root_password.txt" ]; then
        print_warning "MySQL root password not found. Creating with random password..."
        openssl rand -base64 32 > config/secrets/mysql_root_password.txt
        chmod 600 config/secrets/mysql_root_password.txt
        print_status "MySQL root password created."
    fi
    
    if [ ! -f "config/secrets/mysql_password.txt" ]; then
        print_warning "MySQL webdna password not found. Creating with random password..."
        openssl rand -base64 32 > config/secrets/mysql_password.txt
        chmod 600 config/secrets/mysql_password.txt
        print_status "MySQL webdna password created."
    fi
    
    print_status "Database secrets are configured."
}

# Check WebDNA installation
check_webdna() {
    print_status "Checking WebDNA installation requirements..."
    
    if [ ! -d "html/WebCatalog" ]; then
        print_error "WebCatalog directory not found in html/. Please ensure WebDNA files are present."
        exit 1
    fi
    
    print_warning "WebDNA binaries need to be manually installed in docker/webdna-app/webdna-binaries/"
    print_warning "Please obtain WebDNA 8 installation files and place them in the appropriate directory."
    
    print_status "WebDNA directory structure verified."
}

# Create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    mkdir -p docker/webdna-app/webdna-binaries
    mkdir -p logs
    
    print_status "Directory structure created."
}

# Set permissions
set_permissions() {
    print_status "Setting proper permissions..."
    
    # Make scripts executable
    chmod +x scripts/*.sh 2>/dev/null || true
    chmod +x docker/webdna-app/start-webdna.sh
    
    # Set secure permissions for secrets
    chmod 600 config/secrets/*.txt 2>/dev/null || true
    
    print_status "Permissions set correctly."
}

# Display next steps
show_next_steps() {
    echo ""
    echo "=== Setup Complete ==="
    echo ""
    print_status "Next steps to complete the setup:"
    echo ""
    echo "1. Obtain WebDNA 8 installation files and place them in:"
    echo "   docker/webdna-app/webdna-binaries/"
    echo ""
    echo "2. Update the Dockerfile to install WebDNA properly"
    echo ""
    echo "3. Test the basic setup:"
    echo "   docker-compose build"
    echo "   docker-compose up -d"
    echo ""
    echo "4. Check container status:"
    echo "   docker-compose ps"
    echo "   docker-compose logs"
    echo ""
    echo "5. Access the application:"
    echo "   http://localhost"
    echo ""
    print_warning "Remember: This is a development setup. Production deployment requires additional security configuration."
}

# Main execution
main() {
    check_docker
    create_directories
    setup_secrets
    check_webdna
    set_permissions
    show_next_steps
}

# Run main function
main "$@"
