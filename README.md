LAMP-Docker

A Docker and Docker Compose configuration template for MySQL, Apache, and PHP, allowing you to develop and test PHP applications with MySQL database, with SSL support for secure communication.

## Quick Setup

1. Clone the project:
```bash
git clone https://github.com/IsMoreiraKt/LAMP-Docker
cd LAMP-Docker
```

2. Set up your environment:
```bash
cp .example_env .env
# Edit .env with your preferred settings
```

3. Generate SSL certificates:
```bash
# On Linux/macOS
./conf.sh
```

```powershell
# On Windows
.\conf.ps1
```

4. Launch your development environment:
```bash
docker compose up -d
```

## Access Your Services

| Service    | URL                   | Description         |
|------------|-----------------------|---------------------|
| PHP App    | http://localhost:8080 | PHP application     |
| phpMyAdmin | http://localhost:8081 | Database management |

## Project Layout

```
app/              Place your PHP files here
mysql/
  ├── conf.d/     MySQL configurations
  └── ssl/        SSL certificates
```

## Daily Operations

```bash
# Start development
docker compose up -d

# View logs
docker compose logs -f

# Stop everything
docker compose down

# Restart services
docker compose restart
```

## Need Help?

Found a bug? Have a feature request? Open an issue or submit a pull request. Let's make this project better together!

## License

Released under the [MIT License](LICENSE). Feel free to use this in your projects!
