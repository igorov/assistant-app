# Etapa 1: Construir la aplicación
FROM node:18 AS build-stage

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Copiar archivo .env
COPY .env ./

# Instalar dependencias
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Construir la aplicación
RUN npm run build

# Etapa 2: Configurar el servidor para servir la aplicación
FROM nginx:stable-alpine AS production-stage

# Copiar los archivos construidos desde la etapa de construcción
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copiar configuración personalizada de nginx si es necesario
# COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 8080
EXPOSE 8080

# Comando para correr nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]
