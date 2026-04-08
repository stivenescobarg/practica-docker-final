@echo off
echo Iniciando TesloShop...
echo.

docker info >nul 2>&1
if errorlevel 1 (
    echo Error: Docker no esta corriendo. Por favor inicia Docker Desktop.
    pause
    exit /b 1
)

echo Docker esta corriendo
echo.

echo Construyendo e iniciando contenedores...
docker compose up --build -d

echo.
echo Esperando a que los servicios esten listos...
timeout /t 10 /nobreak >nul

echo.
echo TesloShop esta corriendo!
echo.
echo Accede a la aplicacion:
echo    Frontend:    http://localhost
echo    Backend API: http://localhost:3000/api
echo    Base de datos: localhost:5432
echo.
echo Ver logs:
echo    docker compose logs -f
echo.
echo Detener la aplicacion:
echo    docker compose down
echo.
pause