# System Patterns: The Program Architecture

## Current Legacy Architecture
### Application Layer
- **WebDNA Framework**: Non-standard web framework (webdna.us)
- **Template System**: .tpl files for dynamic content generation
- **Database Integration**: Built-in WebCatalog database + MySQL
- **File Structure**: Large html/ directory with nested application files

### Infrastructure Layer
- **OS**: Ubuntu 16.04 (legacy, unsupported)
- **Web Server**: Apache2
- **Database**: MySQL + WebCatalog (proprietary)
- **Protocol Support**: WebDAV for file operations
- **Network**: LAN-only access pattern

### Key Dependencies Identified
```
WebDNA Application
├── Apache2 (web server)
├── MySQL (relational database)
├── WebCatalog (built-in database)
├── WebDAV (file protocol)
└── Large file system (html/ directory)
```

## Target Containerized Architecture
### Container Strategy
- **Multi-container approach**: Separate concerns for maintainability
- **Volume mounting**: Handle large html/ directory externally
- **Service isolation**: Database, web server, and application layers

### Proposed Container Structure
```
Docker Compose Stack
├── webdna-app (main application container)
│   ├── WebDNA runtime
│   ├── Apache2 configuration
│   └── Application logic
├── mysql-db (database container)
│   ├── MySQL server
│   └── Data persistence
└── volumes
    ├── html-content (external mount)
    ├── mysql-data (persistent storage)
    └── logs (centralized logging)
```

## Design Patterns and Principles
### Containerization Patterns
- **Single Responsibility**: Each container has one primary function
- **External Configuration**: Environment-based configuration
- **Data Persistence**: Separate data from application containers
- **Volume Mounting**: Large files handled via host filesystem

### Migration Patterns
- **Lift and Shift**: Minimal changes to existing application
- **Infrastructure as Code**: Docker Compose for reproducible deployments
- **Configuration Management**: Environment variables for settings
- **Backup Strategy**: Container-aware backup and restore procedures

## Critical Implementation Paths
### Phase 1: Base Infrastructure
1. Create WebDNA-compatible base image
2. Configure Apache2 within container
3. Set up MySQL container with proper networking
4. Establish volume mounting strategy

### Phase 2: Application Integration
1. Mount html/ directory as external volume
2. Configure WebDNA to work within container environment
3. Set up database connections and WebCatalog integration
4. Test WebDAV functionality

### Phase 3: Production Readiness
1. Implement proper logging and monitoring
2. Configure SSL/TLS termination
3. Set up backup and restore procedures
4. Performance optimization and testing

## Component Relationships
### Network Architecture
```
External Network (LAN)
    ↓
Docker Network (internal)
    ├── webdna-app:80 → Apache2 → WebDNA
    ├── mysql-db:3306 → MySQL Server
    └── Volume Mounts
        ├── /var/www/html → host:/path/to/html
        └── /var/lib/mysql → mysql-data volume
```

### Data Flow Patterns
1. **Request Flow**: LAN → Docker Network → Apache2 → WebDNA → Response
2. **Database Flow**: WebDNA ↔ MySQL Container + WebCatalog
3. **File Access**: WebDNA → Volume Mount → Host Filesystem
4. **Logging Flow**: All Containers → Centralized Log Volume

## Technology Integration Points
### WebDNA Specific Considerations
- Proprietary framework requires careful container setup
- WebCatalog database integration needs special handling
- Template processing (.tpl files) must work in container environment
- File system access patterns need to be preserved

### Apache2 Configuration
- Virtual host configuration for container environment
- WebDAV module enablement and configuration
- Proper permissions for WebDNA execution
- Log management and rotation

### MySQL Integration
- Container networking for database connections
- Data persistence across container restarts
- Backup and restore procedures
- Performance optimization for container environment
