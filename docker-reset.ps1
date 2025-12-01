# Docker Reset Script for GradeHub System

Write-Host "Stopping and removing all containers..." -ForegroundColor Yellow
docker-compose down -v --remove-orphans

Write-Host "Removing unused images and volumes..." -ForegroundColor Yellow
docker system prune -f
docker volume prune -f

Write-Host "Building and starting all services..." -ForegroundColor Green
docker-compose up --build -d

Write-Host "Waiting for services to start..." -ForegroundColor Blue
Start-Sleep -Seconds 45

Write-Host "Checking service status..." -ForegroundColor Cyan
docker-compose ps

Write-Host "Checking service logs for any errors..." -ForegroundColor Cyan
docker-compose logs --tail=10 api-gateway
docker-compose logs --tail=10 auth
docker-compose logs --tail=10 users

Write-Host "System is ready!" -ForegroundColor Green
Write-Host "Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "API Gateway: http://localhost:5000" -ForegroundColor White
Write-Host "RabbitMQ Management: http://localhost:15672 (guest/guest)" -ForegroundColor White
