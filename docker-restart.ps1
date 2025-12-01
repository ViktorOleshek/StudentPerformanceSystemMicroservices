# Quick Docker restart script
Write-Host "Stopping containers..." -ForegroundColor Yellow
docker-compose down

# Generate certificates if they don't exist
if (!(Test-Path ".\certs")) {
    Write-Host "Generating HTTPS certificates..." -ForegroundColor Cyan
    .\generate-certs.ps1
}

Write-Host "Starting containers..." -ForegroundColor Green
docker-compose up -d

Write-Host "Waiting for services to start..." -ForegroundColor Blue
Start-Sleep -Seconds 30

Write-Host "Checking container status..." -ForegroundColor Cyan
docker-compose ps

Write-Host "Services are starting up!" -ForegroundColor Green
Write-Host "Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "API Gateway: http://localhost:5000" -ForegroundColor White
