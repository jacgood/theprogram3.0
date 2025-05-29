# Technical Context: The Program

## Technology Stack Overview
### Legacy Environment
- **Operating System**: Ubuntu 16.04 LTS (End of Life)
- **Web Framework**: WebDNA (proprietary, webdna.us)
- **Web Server**: Apache2
- **Database Systems**: 
  - MySQL (relational database)
  - WebCatalog (WebDNA's built-in database)
- **Protocols**: HTTP/HTTPS, WebDAV
- **File System**: Large html/ directory (10s of GBs)

### Target Modern Environment
- **Operating System**: LTS Debian/Ubuntu (containerized)
- **Containerization**: Docker + Docker Compose
- **Web Server**: Apache2 (containerized)
- **Database**: MySQL (containerized)
- **SSL/TLS**: Cloudflare/Certbot
- **Orchestration**: Docker Compose

## WebDNA Framework Details
### What is WebDNA?
- Proprietary web development framework
- Server-side scripting language
- Built-in database capabilities (WebCatalog)
- Template-based rendering system (.tpl files)
- Integrated with web servers via CGI/module

### WebDNA Dependencies
- Requires specific runtime environment
- Integrates with Apache via module or CGI
- File system access for templates and data
- Database connectivity (both MySQL and WebCatalog)
- WebDAV support for file operations

### Critical Files Identified
```
html/
├── *.tpl (template files)
├── *.dna (WebDNA script files)
├── WebCatalog/ (built-in database files)
├── index.html, index.tpl (entry points)
├── debug-webdna.dna (debugging script)
└── Various subdirectories (AIS/, test/, trunk/, etc.)
```

## Development Environment Setup
### Prerequisites
- Docker and Docker Compose installed
- Access to WebDNA runtime/binaries
- Understanding of Apache2 configuration
- MySQL administration knowledge

### Local Development Approach
1. **Volume Mounting**: Mount html/ directory from host
2. **Container Development**: Build and test in isolated environment
3. **Configuration Management**: Use environment variables
4. **Iterative Testing**: Quick container rebuild cycles

## Technical Constraints
### WebDNA Specific Limitations
- Proprietary framework with limited documentation
- Specific runtime requirements
- File system dependencies
- Integration complexity with modern containerization

### Infrastructure Constraints
- Large file system (cannot be copied into container)
- LAN-only access requirement
- Legacy database integration needs
- WebDAV protocol support required

### Migration Challenges
- WebDNA containerization complexity
- Preserving file system access patterns
- Database migration and integration
- Apache2 configuration in container environment

## Dependencies and Integrations
### External Dependencies
```yaml
System Dependencies:
  - Docker Engine
  - Docker Compose
  - Host file system access

Application Dependencies:
  - WebDNA runtime
  - Apache2 with WebDNA module
  - MySQL server
  - WebDAV support
```

### Internal Integrations
- WebDNA ↔ Apache2 (web server integration)
- WebDNA ↔ MySQL (database connectivity)
- WebDNA ↔ WebCatalog (built-in database)
- WebDNA ↔ File System (template and data access)

## Tool Usage Patterns
### Development Tools
- **Docker**: Container creation and management
- **Docker Compose**: Multi-container orchestration
- **Git**: Version control (excluding large html/ directory)
- **GitHub MCP**: Automated version control integration

### Deployment Tools
- **Docker Compose**: Production deployment
- **Volume Management**: External file system mounting
- **Backup Tools**: Database and file system backup
- **Monitoring**: Container health and performance monitoring

## Configuration Management
### Environment Variables
```bash
# Database Configuration
MYSQL_ROOT_PASSWORD=<secure_password>
MYSQL_DATABASE=theprogram
MYSQL_USER=webdna
MYSQL_PASSWORD=<secure_password>

# Application Configuration
WEBDNA_HTML_PATH=/var/www/html
WEBDNA_LOG_LEVEL=info
APACHE_LOG_LEVEL=warn

# Network Configuration
APACHE_PORT=80
MYSQL_PORT=3306
```

### Volume Configurations
```yaml
volumes:
  - ./html:/var/www/html:ro  # Read-only mount for security
  - mysql_data:/var/lib/mysql
  - logs:/var/log
```

## Performance Considerations
### Container Optimization
- Minimal base images for faster startup
- Proper resource limits and requests
- Efficient volume mounting strategies
- Optimized Apache2 configuration

### Database Performance
- MySQL configuration tuning for container environment
- Proper indexing for WebDNA queries
- Connection pooling and management
- Regular maintenance and optimization

## Security Considerations
### Container Security
- Non-root user execution where possible
- Read-only file system mounts
- Network isolation and proper port exposure
- Regular security updates for base images

### Application Security
- Secure database credentials management
- Proper file permissions
- SSL/TLS termination
- Access control and authentication

## Monitoring and Logging
### Container Monitoring
- Health checks for all services
- Resource usage monitoring
- Container restart policies
- Performance metrics collection

### Application Logging
- Centralized log collection
- WebDNA application logs
- Apache2 access and error logs
- MySQL query and error logs
