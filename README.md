# Paperless-ngx Docker Setup

A complete Docker setup for Paperless-ngx, a powerful document management system that transforms your physical documents into a searchable online archive.

## Features

- 🗂️ **Document Management**: Organize and search through your documents
- 🔍 **OCR Support**: Automatic text recognition from scanned documents
- 🏷️ **Tagging System**: Categorize documents with tags and correspondents
- 📱 **Web Interface**: Modern, responsive web UI
- 🔒 **User Management**: Multi-user support with permissions
- 📧 **Email Integration**: Import documents via email
- 🔄 **Auto-Processing**: Automatic document processing and filing

## Quick Start

### Prerequisites

- Docker and Docker Compose installed
- At least 2GB of available RAM
- Port 8000 available

### Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/orazio-dev/paperless.git
   cd paperless
   ```

2. **Configure environment** (optional):
   ```bash
   cp env.example .env
   # Edit .env with your preferred settings
   ```

3. **Start the services**:
   ```bash
   docker-compose up -d
   ```

4. **Access Paperless**:
   - Open http://localhost:8000 in your browser
   - Login with username: `admin`, password: `admin`
   - **Important**: Change the admin password immediately after first login!

### First-time Setup

1. **Change admin password**: Go to Admin → Users → admin → Change password
2. **Configure settings**: Admin → Settings → Configure your preferences
3. **Set up document processing**: Configure OCR language, file naming, etc.

## Usage

### Adding Documents

1. **Web Upload**: Use the web interface to upload documents directly
2. **Watch Folder**: Place documents in the `consume/` folder - they'll be processed automatically
3. **Email**: Configure email settings to receive documents via email
4. **Mobile App**: Use the official Paperless mobile app

### Directory Structure

```
paperless/
├── docker-compose.yml     # Docker services configuration
├── env.example           # Environment variables template
├── consume/             # Drop documents here for auto-processing
├── export/              # Export documents here
└── README.md           # This file
```

## Configuration

### Environment Variables

Key configuration options in `.env`:

- `PAPERLESS_SECRET_KEY`: Django secret key (change this!)
- `PAPERLESS_URL`: External URL for Paperless
- `PAPERLESS_TIME_ZONE`: Your timezone
- `PAPERLESS_OCR_LANGUAGE`: OCR language (eng, deu, fra, etc.)
- `PAPERLESS_ADMIN_USER/PASSWORD`: Initial admin credentials

### Database

The setup uses PostgreSQL with persistent storage. Database files are stored in a Docker volume.

### Redis

Redis is used for task queuing and caching.

## Management Commands

### Backup

```bash
# Backup documents and database
docker-compose exec webserver document_exporter /usr/src/paperless/export/
```

### Update

```bash
# Pull latest images and restart
docker-compose pull
docker-compose up -d
```

### Logs

```bash
# View logs
docker-compose logs -f webserver
```

### Reset Admin Password

```bash
docker-compose exec webserver python3 manage.py changepassword admin
```

## Troubleshooting

### Common Issues

1. **Port 8000 already in use**: Change the port mapping in `docker-compose.yml`
2. **Permission issues**: Ensure Docker has permission to access the directories
3. **OCR not working**: Check if the OCR language is installed
4. **High memory usage**: Paperless can use significant RAM during document processing

### Getting Help

- Check the logs: `docker-compose logs webserver`
- Visit the [Paperless-ngx documentation](https://paperless-ngx.readthedocs.io/)
- Join the [community discussions](https://github.com/paperless-ngx/paperless-ngx/discussions)

## Security Notes

- Change the default admin password immediately
- Use a strong `PAPERLESS_SECRET_KEY`
- Consider using HTTPS in production
- Regularly backup your data
- Keep Docker images updated

## License

This Docker setup is provided as-is. Paperless-ngx itself is licensed under the GNU General Public License v3.0.

## Contributing

Feel free to submit issues and enhancement requests!
