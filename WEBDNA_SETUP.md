# WebDNA Installation and Setup Guide

## Overview
This guide provides instructions for obtaining, installing, and configuring WebDNA 8 within the Docker container environment.

## WebDNA 8 Requirements
Based on the analysis of the existing WebDNA installation in `html/WebCatalog/About WebDNA 8.txt`:

### System Requirements
- Intel machine (32 or 64 bit)
- Ubuntu 12.04+ or CentOS 6.5+ (we're using Ubuntu 20.04)
- Apache WebServer 2.2x or higher (we're using Apache 2.4)
- 7GB hard drive space
- 500MB RAM minimum

### WebDNA 8 Features
- TLS SMTP Security
- Full HTTP MIME header support
- FastCGI support (recommended for containerization)
- Blowfish encryption option
- Enhanced tag support

## Obtaining WebDNA 8.6.5

### Official Package Installation (Recommended)
WebDNA 8.6.5 is now available as an official Ubuntu package with FastCGI support:
- **Latest Version**: WebDNA fcgi version v8.6.5 (May, 2025)
- **Platform**: Ubuntu 22.04 LTS (Jammy Jellyfish) 64 bit
- **Installation Method**: APT package manager
- **Documentation**: https://docs.webdna.us/installers

### Legacy Installation (If Needed)
If you have access to the original server:
1. Locate WebDNA binaries (typically in `/usr/local/webdna/` or similar)
2. Copy the WebDNA module file (usually `mod_webdna.so`)
3. Copy any WebDNA configuration files
4. Copy license files

### WebDNA Software Corp Contact
For licensing or support:
- Website: http://www.webdna.us
- Developer Resource: http://dev.webdna.us
- Email: support@webdna.us
- Phone: (608) 770-3822

## Installation Methods

### Method 1: Apache Module (Traditional)
This is the traditional method used in the legacy system.

**Pros:**
- Direct integration with Apache
- Better performance for high-traffic sites
- Traditional WebDNA deployment method

**Cons:**
- More complex container setup
- Requires Apache module compilation
- Potential compatibility issues with newer Apache versions

### Method 2: FastCGI (Recommended for Containers)
WebDNA 8 supports FastCGI, which is more container-friendly.

**Pros:**
- Better isolation in container environment
- Easier to manage and restart
- More compatible with modern Apache versions
- Better for development and testing

**Cons:**
- Slightly different configuration
- May have minor performance overhead

## Container Integration Steps

### Step 1: Prepare WebDNA Files
1. Create directory structure:
   ```bash
   mkdir -p docker/webdna-app/webdna-binaries
   mkdir -p docker/webdna-app/webdna-config
   ```

2. Place WebDNA files in `docker/webdna-app/webdna-binaries/`:
   - WebDNA executable or module
   - License files
   - Configuration files
   - Any required libraries

### Step 2: Update Dockerfile
Add WebDNA installation steps to `docker/webdna-app/Dockerfile`:

```dockerfile
# Copy WebDNA installation files
COPY webdna-binaries/ /opt/webdna/
COPY webdna-config/ /etc/webdna/

# Install WebDNA (method depends on installation type)
# For Apache Module:
# RUN cp /opt/webdna/mod_webdna.so /usr/lib/apache2/modules/
# RUN echo "LoadModule webdna_module modules/mod_webdna.so" >> /etc/apache2/mods-available/webdna.load
# RUN a2enmod webdna

# For FastCGI:
# RUN cp /opt/webdna/webdna /usr/local/bin/
# RUN chmod +x /usr/local/bin/webdna
```

### Step 3: Configure Apache
Update `docker/webdna-app/apache-config/webdna.conf`:

**For Apache Module:**
```apache
LoadModule webdna_module modules/mod_webdna.so
AddHandler webdna-handler .dna
AddHandler webdna-handler .tpl
```

**For FastCGI:**
```apache
LoadModule fcgid_module modules/mod_fcgid.so
AddHandler fcgid-script .dna
AddHandler fcgid-script .tpl
FcgidWrapper /usr/local/bin/webdna .dna
FcgidWrapper /usr/local/bin/webdna .tpl
```

### Step 4: WebCatalog Database Integration
The WebCatalog database files are in `html/WebCatalog/`. These need special handling:

1. **Read-Only Mount**: The html directory is mounted read-only for security
2. **WebCatalog Access**: WebDNA needs read/write access to WebCatalog files
3. **Solution**: Create a separate volume for WebCatalog data or adjust permissions

## Testing WebDNA Installation

### Basic Functionality Test
Create a test file to verify WebDNA is working:

```webdna
[!]-- Test file: test-webdna.dna --[/!]
<!DOCTYPE html>
<html>
<head>
    <title>WebDNA Test</title>
</head>
<body>
    <h1>WebDNA Container Test</h1>
    <p>Math test: [math]2+2[/math]</p>
    <p>Date test: [date]</p>
    <p>Time test: [time]</p>
    
    [text]testvar=Hello from containerized WebDNA![/text]
    <p>Variable test: [testvar]</p>
    
    [!]-- Database connection test --[/!]
    [sql database=theprogram&username=webdna&password=[url][MYSQL_PASSWORD][/url]]
        SELECT COUNT(*) as record_count FROM webdna_test
    [/sql]
    
    [founditems]
        <p>Database test: Found [record_count] records in test table</p>
    [/founditems]
</body>
</html>
```

### Testing Steps
1. Build the container: `docker-compose build`
2. Start the services: `docker-compose up -d`
3. Check logs: `docker-compose logs webdna-app`
4. Access test page: `http://localhost/test-webdna.dna`
5. Verify WebDNA tags are processed correctly

## Troubleshooting

### Common Issues

**WebDNA Module Not Loading:**
- Check Apache error logs: `docker-compose logs webdna-app`
- Verify module path and permissions
- Ensure Apache configuration is correct

**WebCatalog Access Issues:**
- Check file permissions in WebCatalog directory
- Verify WebDNA has read/write access to database files
- Consider separate volume for WebCatalog data

**Database Connection Problems:**
- Verify MySQL container is running: `docker-compose ps`
- Check database credentials in environment variables
- Test MySQL connection from WebDNA container

**Performance Issues:**
- Monitor container resources: `docker stats`
- Adjust Apache and MySQL configuration
- Consider FastCGI vs Apache module performance

## Security Considerations

### Container Security
- Run WebDNA as non-root user when possible
- Use read-only mounts for application files
- Secure database credentials using Docker secrets
- Regular security updates for base images

### WebDNA Security
- Configure proper file permissions
- Secure WebCatalog database access
- Implement proper authentication for WebDAV
- Regular WebDNA security updates

## Next Steps

1. **Obtain WebDNA 8 installation files**
2. **Choose installation method** (Apache module vs FastCGI)
3. **Update Dockerfile** with WebDNA installation steps
4. **Configure Apache** for WebDNA integration
5. **Test basic functionality** with simple WebDNA pages
6. **Integrate with existing application** files
7. **Performance testing** and optimization

## Resources

- WebDNA Documentation: http://dev.webdna.us
- WebDNA Support: support@webdna.us
- Docker Best Practices: https://docs.docker.com/develop/best-practices/
- Apache Configuration: https://httpd.apache.org/docs/
