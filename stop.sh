@echo off
echo Deteniendo TesloShop...
docker compose down

echo.
echo TesloShop detenido
echo.
echo Para eliminar tambien los volumenes (base de datos):
echo    docker compose down -v
echo.
pause