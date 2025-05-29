# The Program 3.0 - Dockerization Project

## Overview
This project containerizes "The Program" - a legacy WebDNA web application currently running on Ubuntu 16.04 - to a modern, stable, containerized platform using Docker and Docker Compose.

## Project Goals
- Migrate legacy WebDNA application from Ubuntu 16.04 to containerized environment
- Ensure zero downtime migration with full functionality preservation
- Implement industry best practices for containerized web applications
- Create maintainable, portable infrastructure for future scalability

## Technology Stack
### Legacy Environment
- Ubuntu 16.04 LTS (End of Life)
- WebDNA Framework (proprietary)
- Apache2 Web Server
- MySQL + WebCatalog databases
- WebDAV protocol support

### Target Environment
- Docker + Docker Compose
- LTS Debian/Ubuntu (containerized)
- Apache2 (containerized)
- MySQL (containerized)
- SSL/TLS via Cloudflare/Certbot

## Project Structure
```
theprogram3.0/
├── memory-bank/          # Project documentation and context
│   ├── projectbrief.md   # Project overview and requirements
│   ├── productContext.md # Business context and user needs
│   ├── systemPatterns.md # Technical architecture patterns
│   ├── techContext.md    # Technology stack details
│   ├── activeContext.md  # Current work focus
│   └── progress.md       # Project status and milestones
├── docker/               # Docker configuration files (to be created)
├── config/               # Application configuration (to be created)
└── html/                 # Legacy application files (NOT in version control)
```

## Security Notice
⚠️ **IMPORTANT**: This repository excludes sensitive data including:
- Large application files (`html/` directory)
- Database files and backups
- API keys, passwords, and credentials
- SSL certificates and private keys
- Configuration files with sensitive data

See `.gitignore` for complete exclusion list.

## Development Status
**Current Phase**: Foundation and Planning (5% Complete)

### Completed
- ✅ Memory Bank documentation structure
- ✅ Project requirements and architecture planning
- ✅ Security measures and .gitignore configuration

### Next Steps
- [ ] WebDNA framework research and containerization strategy
- [ ] Docker environment setup and configuration
- [ ] Multi-container architecture implementation
- [ ] Volume mounting strategy for large application files

## Getting Started
1. Clone this repository
2. Review documentation in `memory-bank/` directory
3. Ensure Docker and Docker Compose are installed
4. Follow development setup instructions (to be added)

## Documentation
Complete project documentation is maintained in the `memory-bank/` directory:
- Start with `projectbrief.md` for project overview
- Review `systemPatterns.md` for technical architecture
- Check `activeContext.md` for current work status

## Contributing
This is a migration project for a specific legacy application. All changes should:
- Maintain comprehensive documentation
- Follow containerization best practices
- Preserve existing application functionality
- Include detailed commit messages

## License
Internal company project - not for public distribution.

---
**Note**: This project handles business-critical infrastructure. All changes must be thoroughly tested and documented.
