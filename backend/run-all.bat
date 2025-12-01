@echo off
setlocal enabledelayedexpansion

echo Starting all microservices with rebuild...

REM NotificationService (Worker project)
start "NotificationService" cmd /k "cd NotificationService\NotificationService.Worker && dotnet build && dotnet run"

REM AuthService
start "AuthService" cmd /k "cd AuthService\AuthService.Api && dotnet build && dotnet run --launch-profile https"

REM CourseService
start "CourseService" cmd /k "cd CourseService\CourseService.Api && dotnet build && dotnet run --launch-profile https"

REM GradeService
start "GradeService" cmd /k "cd GradeService\GradeService.Api && dotnet build && dotnet run --launch-profile https"

REM UserService
start "UserService" cmd /k "cd UserService\UserService.Api && dotnet build && dotnet run --launch-profile https"

timeout /t 3 /nobreak >nul  REM Коротка пауза для стабільності

echo All services started in separate windows. Check each for errors.
echo Close windows or use Ctrl+C to stop.
pause