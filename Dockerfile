# Imagen base desde docker HUB
FROM ubuntu:18.04

# Datos del desarrollador
MAINTAINER Rodrigo Montenegro "rodrigo.montenegro@alumnos.uv.cl"

# Cambia a root para instalar librerias.
USER root

# Esto hará que apt-get sea instalado
ARG DEBIAN_FRONTEND=noninteractive

# Instalacion de paquetes adicionales con apt-get, para el sistema.
RUN apt-get update  && \
    apt-get -y upgrade && \
    apt-get -y install apt-utils && \
    apt-get -y install locales && \
    locale-gen "en_US.UTF-8" && \
    dpkg-reconfigure --frontend=noninteractive locales
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
RUN apt-get update && \
    apt-get install -y git
RUN apt-get -y install python3.7-dev python3.7 python3-pip && \
    pip3 install --upgrade pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# Instalamos python3.7.
RUN apt-get update && \
    apt-get -y install git python3.7-dev python3.7 python3-pip && \
    apt-get -y install build-essential cmake unzip pkg-config wget libjpeg-dev libpng-dev libtiff-dev \
    libeigen3-dev libgtk-3-dev libatlas-base-dev gfortran && \
    apt-get -y install libatlas-base-dev gfortran

RUN apt-get -y install build-essential cmake unzip pkg-config wget
RUN apt-get -y install libjpeg-dev libpng-dev libtiff-dev

# Instalacion apt-get, libeigen3-dev.
#RUN apt-get update && apt-get install -y python3 libeigen3-dev cmake
# Actualizamos apt-get y instalamos libgtk-3-dev
#RUN apt-get update && apt-get install -y libeigen3-dev
# actualizamos apt-get y instalamos libgtk-3-dev
#RUN apt-get -y install libgtk-3-dev
 
RUN apt-get -y install libatlas-base-dev gfortran
ENV OPENCV_VERSION=3.4.5

RUN echo "Downloading OpenCV source..." && \
    wget -O opencv.tgz https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz -nv && \
    wget -O opencv_contrib.tgz https://github.com/Itseez/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz -nv && \
    echo "Extracting OpenCV sources..." && \
    tar xzf opencv.tgz && \
    tar xzf opencv_contrib.tgz

# Actualizacion de paquetes apt-get
RUN apt-get update

# Direccionar hacia el direcctorio root.
WORKDIR /root

# Añadimos SSH key para vincularlo con github.
RUN ssh-keygen -t rsa -b 4096 -C "rodrigo.montenegro@alumnos.uv.cl" -f ~/.ssh/id_rsa -q -N ""
# Permiso 600 a la carpeta /.ssh archivo id_resa recursivamente.
RUN chmod -R  600 /root/.ssh/id_rsa

# Instalacion de paquetes adicionales con pip
#RUN pip install matplotlib
RUN pip install opencv-python==4.5.4.58
RUN pip install pandas
RUN pip install keras
RUN pip install -U -q segmentation-models
RUN pip install -q tensorflow==2.1
RUN pip install -q keras==2.3.1
RUN pip install scipy
RUN pip install scikit-learn
RUN pip install seaborn
RUN pip install keras
RUN pip install imageio-ffmpeg
RUN pip install sklearn
RUN pip install conda
RUN pip install scikit-image
RUN pip install pillow
RUN pip install moviepy
RUN pip install --upgrade matplotlib
RUN pip install keras-models==0.0.2
RUN pip install plotly
RUN pip install statsmodels
RUN pip install openpyxl
RUN apt-get update && apt-get install -y git
RUN pip install sqlalchemy
RUN pip install PyMySQL==1.0.1
RUN pip install pyodbc==4.0.34
RUN pip install db-sqlite3==0.0.1
RUN pip install tensorflow-addons==0.11.0
RUN pip install --upgrade tensorflow==2.3.1
RUN pip install tensorflow-addons[optimizers]
RUN pip install eigen==0.0.1
RUN pip install tensorflow-addons[Levenberg-Marquardt]
RUN pip install keras==2.4.3

#Copiar desde la carpeta generada desde github al contenedor.
COPY .jupyter .jupyter
# Creamos directorio notebooks
RUN mkdir notebooks
# Añadir el archvo requirements.txt a la carpeta recien creada notebook
ADD requirements.txt notebooks/requirements.txt
# Instalar mediante el comando pip el archivo requirements.txt recien añadido a la carpeta notebok-
RUN pip install -r notebooks/requirements.txt
# Copiar la carpeta de notebook y su contenido a notebook del contenedor que se creara.
COPY notebooks notebooks
# Con este comando nos direccionamos en el directorio /root/notebooks
WORKDIR /root/notebooks
#
ENTRYPOINT ["jupyter", "notebook"]
# la aplicacion sera expuesta en el puerto 8888
