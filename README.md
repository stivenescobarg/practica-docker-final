# tesloshop-app
# 🐳 Práctica Docker Final - TesloShop

**Aprendiz:** Stiven Escobar Gomez  
**Actividad:** CN-GA1-220501097-01-AA1 – EV07  -- Práctica Final 
**Fecha:** Abril 2026


## 📋 Descripción del Proyecto

Aplicación web completa (Full Stack) contenerizada con Docker y orquestada con Docker Compose.

### Arquitectura
┌─────────────────┐
│   FRONTEND      │  Puerto 80
│   Angular 19    │  (Nginx)
│   Nginx         │
└────────┬────────┘
│
▼
┌─────────────────┐
│   BACKEND       │  Puerto 3000
│   NestJS        │  (API REST)
└────────┬────────┘
│
▼
┌─────────────────┐
│   DATABASE      │  Puerto 5432
│   PostgreSQL    │
└─────────────────┘

---

## 🛠️ Tecnologías Utilizadas

- **Frontend:** Angular 19 + Nginx
- **Backend:** NestJS (Node.js + TypeScript)
- **Base de Datos:** PostgreSQL 14.3
- **Contenedores:** Docker
- **Orquestación:** Docker Compose

---

## 📂 Estructura del Proyecto
tesloshop-app/
├── teslo-shop/              # Backend (NestJS)
│   ├── Dockerfile           # Multi-stage build
│   └── src/
├── angular-tesloshop/       # Frontend (Angular)
│   ├── Dockerfile           # Build + Nginx
│   ├── nginx.conf           # Configuración proxy
│   └── src/
├── docker-compose.yml       # Orquestación
├── .env                     # Variables de entorno
├── start.sh                # Script de inicio
└── stop.sh                 # Script de parada

---

## 🚀 Pasos de Ejecución

### 1️⃣ Requisitos Previos

- Docker Desktop instalado
- Git instalado
- Puertos 80, 3000 y 5432 disponibles

### 2️⃣ Clonar el Repositorio
```bash
git clone https://github.com/DEV-SENA-TRAINING/tesloshop-app.git
cd tesloshop-app
```

### 3️⃣ Configurar Variables de Entorno

Ya viene configurado el archivo `.env` con las credenciales necesarias.

### 4️⃣ Levantar los Servicios
```bash
docker compose up --build -d
```

O usando el script:
```bash
start.sh
```

### 5️⃣ Poblar la Base de Datos

Visitar en el navegador:
http://localhost:3000/api/seed

### 6️⃣ Acceder a la Aplicación

- **Frontend:** http://localhost
- **Backend API:** http://localhost:3000/api

---

## 🐋 Explicación de Servicios

### 🗄️ Servicio: `db` (PostgreSQL)

- **Imagen:** `postgres:14.3`
- **Puerto:** 5432
- **Volumen:** `postgres-data` (persistencia de datos)
- **Healthcheck:** Verifica que la BD esté lista antes de que el backend se conecte

### ⚙️ Servicio: `backend` (NestJS)

- **Build:** Multi-stage (dev/prod)
- **Puerto:** 3000
- **Dependencias:** Espera a que `db` esté healthy
- **Variables:** Conexión a BD, JWT secret, etc.

### 🎨 Servicio: `frontend` (Angular + Nginx)

- **Build:** Compila Angular y sirve con Nginx
- **Puerto:** 80
- **Proxy:** Redirige `/api` al backend
- **Dependencias:** Arranca después del backend

---

## 📊 Dockerfile del Backend

### Características:

✅ **Multi-stage build** con 5 etapas:
- `dev`: Desarrollo con hot-reload
- `dev-deps`: Instala dependencias completas
- `builder`: Compila TypeScript a JavaScript
- `prod-deps`: Solo dependencias de producción
- `prod`: Imagen final optimizada

✅ **Optimizaciones:**
- Uso de Alpine Linux (imagen ligera)
- Caché de capas de Docker
- Separación de dependencias dev/prod

---

## 📊 Dockerfile del Frontend

### Características:

✅ **Multi-stage build** con 2 etapas:
- `build`: Compila Angular con Node
- `runtime`: Sirve con Nginx (sin Node)

✅ **Ventajas:**
- Imagen final muy pequeña (~50MB)
- Solo archivos estáticos + Nginx
- Caché inteligente de npm

---

## 🌐 Redes y Volúmenes

### Red:
- **Nombre:** `teslo-network`
- **Tipo:** Bridge
- **Función:** Conecta los 3 servicios internamente

### Volúmenes:
- **postgres-data:** Persiste datos de PostgreSQL entre reinicios

---

## 🔧 Comandos Útiles
```bash
# Ver contenedores corriendo
docker compose ps

# Ver logs en tiempo real
docker compose logs -f

# Ver logs solo del backend
docker compose logs -f backend

# Detener servicios
docker compose down

# Detener y eliminar volúmenes (RESET TOTAL)
docker compose down -v

# Reconstruir las imágenes
docker compose build --no-cache

# Ejecutar comandos dentro del backend
docker compose exec backend yarn start:dev
```

---

## ⚠️ Problemas Encontrados y Soluciones

### Problema 1:  Variables de entorno para TesloShop .env
**Solución:** Las variables DB_USERNAME, DB_PASSWORD y DB_NAME DEBEN coincidir exactamente con POSTGRES_USER, POSTGRES_PASSWORD y POSTGRES_DB. Al principio no coincidían y el backend no podía conectarse."


---

## 📹 Video de Sustentación

[\[Enlace al video en YouTube\]](https://youtu.be/KX1UB-vEKuk)

**Duración:** 13:52 minutos  
**Contenido:**
- Explicación de la arquitectura
- Demostración de Dockerfiles
- Explicación de docker-compose.yml
- Ejecución en vivo
- Demostración funcional

---

## 👨‍💻 Autor

**Nombre:** Stiven Escobar Gomez  
**Ficha:** 3144585  
**SENA - 2026**

---

## 📚 Referencias

- [Documentación Docker](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [NestJS](https://nestjs.com/)
- [Angular](https://angular.io/)