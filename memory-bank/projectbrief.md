# Project Brief: The Program Dockerization

## Project Overview
Migrate and containerize "The Program" - a legacy WebDNA web application currently running on Ubuntu 16.04 - to a modern, stable, containerized platform.

## Core Problem
- Legacy server running Ubuntu 16.04 (no longer supported)
- Fear of breaking production during in-place OS upgrade
- Difficulty migrating to new server due to complex dependencies
- Need for stable, portable platform following industry best practices

## Project Goals
1. **Primary**: Containerize existing WebDNA application for modern hardware
2. **Stability**: Create reliable platform that won't break during future migrations
3. **Portability**: Enable easy movement between servers via containerization
4. **Standards**: Follow industry best practices for web application deployment
5. **Maintainability**: Establish sustainable infrastructure for long-term operation

## Application Details
- **Name**: "The Program" (internal company reference)
- **Current URL**: https://www.goodvaluation.com/theprogram (LAN-only access)
- **Framework**: WebDNA (webdna.us) - non-standard web framework
- **Size**: 10s of GBs of application files in html/ directory

## Technical Requirements
### Current Dependencies
- WebDNA framework
- Apache2 web server
- MySQL database
- WebDAV
- WebCatalog (built-in database)

### Target Technology Stack
- **OS**: LTS Debian/Ubuntu
- **Containerization**: Docker with Docker Compose
- **Database**: MySQL
- **Web Server**: Apache2
- **SSL**: Cloudflare/Certbot

## Key Constraints
- Cannot upload html/ folder to GitHub (too large)
- Cannot copy html/ directly into Docker container
- Must maintain existing application functionality
- LAN-only access requirement must be preserved

## Success Criteria
- WebDNA application runs successfully in Docker container
- All existing functionality preserved
- Easy deployment and migration capabilities
- Follows containerization best practices
- Maintainable and documented infrastructure

## Development Approach
- Focus on containerization infrastructure first
- Handle large html/ folder through volume mounting
- Use GitHub MCP tool for version control with detailed commit messages
- Incremental development with thorough testing
