#Imagen base desde docker HUB
FROM mysql
# Datos del desarrollador
MAINTAINER Rodrigo Montenegro "rodrigo.montenegro@alumnos.uv.cl"
# ejemplo de recibir argumentos desde docker-compose 
ARG MYSQL_ROOT_PORT
ENV MYSQL_ROOT_PORT $MYSQL_ROOT_PORT
RUN echo $MYSQL_ROOT_PORT
# Copiar carpeta /scripts /docker-entrypoint-initdb.d/ 
COPY ./scripts/ /docker-entrypoint-initdb.d/
# Expone 3306
EXPOSE 3306


