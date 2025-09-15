# Etapa 1: Construcción de la app Node.js
FROM node:20 AS build

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Etapa 2: Apache con Node.js ya compilado
FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalar Apache y Certbot
RUN apt-get update && \
    apt-get install -y apache2 python3-certbot-apache && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Habilitar módulos de Apache
RUN a2enmod proxy proxy_http ssl

# Copiar archivos estáticos ya construidos desde la primera etapa
COPY --from=build /app/dist /var/www/html

EXPOSE 80 443

CMD ["apachectl", "-D", "FOREGROUND"]
