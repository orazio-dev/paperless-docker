#!/bin/bash

# Paperless Docker Management Script

set -e

COMPOSE_FILE="docker-compose.yml"

show_help() {
    echo "Paperless Docker Management Script"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start     Start all services"
    echo "  stop      Stop all services"
    echo "  restart   Restart all services"
    echo "  logs      Show logs (add service name for specific service)"
    echo "  status    Show service status"
    echo "  update    Pull latest images and restart"
    echo "  backup    Export all documents to export folder"
    echo "  reset-admin Reset admin password"
    echo "  shell     Open shell in webserver container"
    echo "  help      Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 start"
    echo "  $0 logs webserver"
    echo "  $0 backup"
}

case "${1:-help}" in
    start)
        echo "Starting Paperless services..."
        docker-compose up -d
        echo "Services started! Access Paperless at http://localhost:8000"
        ;;
    stop)
        echo "Stopping Paperless services..."
        docker-compose down
        echo "Services stopped."
        ;;
    restart)
        echo "Restarting Paperless services..."
        docker-compose restart
        echo "Services restarted."
        ;;
    logs)
        if [ -n "$2" ]; then
            docker-compose logs -f "$2"
        else
            docker-compose logs -f
        fi
        ;;
    status)
        docker-compose ps
        ;;
    update)
        echo "Updating Paperless..."
        docker-compose pull
        docker-compose up -d
        echo "Update complete!"
        ;;
    backup)
        echo "Creating backup..."
        docker-compose exec webserver document_exporter /usr/src/paperless/export/
        echo "Backup created in export/ folder"
        ;;
    reset-admin)
        echo "Resetting admin password..."
        docker-compose exec webserver python3 manage.py changepassword admin
        ;;
    shell)
        docker-compose exec webserver bash
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
