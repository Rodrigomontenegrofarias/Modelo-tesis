#Imagen base desde docker HUB
FROM mysql
# Datos del desarrollador
MAINTAINER Rodrigo Montenegro "rodrigo.montenegro@alumnos.uv.cl"
# Copiar carpeta /scripts /docker-entrypoint-initdb.d/ 
COPY ./scripts/ /docker-entrypoint-initdb.d/
# Expone en el puerto 3306
EXPOSE 3306


