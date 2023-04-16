FROM ubuntu:18.04
# Image providing Jupyter notebook server with Python 3.6 bindings for OpenCV 3.4.5
# Based on https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/



# Switch to root to be able to install stuff
USER root

# This w	ill make apt-get install without question
ARG DEBIAN_FRONTEND=noninteractive

# Update package list, upgrade system and set default locale
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

#RUN apt-get update && apt-get install -y libeigen3-dev
# Install python3.6

RUN apt-get -y install python3.7-dev python3.7 python3-pip && \
    pip3 install --upgrade pip && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1


# Install packages required for compiling opencv
RUN apt-get -y install build-essential cmake unzip pkg-config wget

# Install packages providing support for several image formats like JPEG, PNG, TIFF
RUN apt-get -y install libjpeg-dev libpng-dev libtiff-dev

# Install packages providing support for several video formats
# so you can work with your camera stream and process video files
RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
 
# Install gtk (GUI components in opencv rely on gtk)
# as OpenCV’s highgui relies on the GTK library for GUI operations
RUN apt-get -y install libgtk-3-dev


# Install additional packages optimizing opencv
RUN apt-get -y install libatlas-base-dev gfortran

# Define OpenCV version to download, compile and install
ENV OPENCV_VERSION=3.4.5

# Download and extract OpenCV sources
WORKDIR /root
RUN echo "Downloading OpenCV source..." && \
    wget -O opencv.tgz https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz -nv && \
    wget -O opencv_contrib.tgz https://github.com/Itseez/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz -nv && \
    echo "Extracting OpenCV sources..." && \
    tar xzf opencv.tgz && \
    tar xzf opencv_contrib.tgz

# numpy is required for OpenCV Python bindings
RUN pip install numpy
RUN pip install matplotlib
RUN pip install pandas
#RUN pip install pandas as sb
RUN pip install keras


RUN pip install -U -q segmentation-models
RUN pip install -q tensorflow==2.1

RUN pip install -q keras==2.3.1
#RUN pip install -q tensorflow-estimator==2.1. 
#RUN pip install --upgrade tensorflow
#RUN pip install numpy
#RUN pip install keras

#RUN pip install tensorflow==1.15.4


RUN pip install scipy
RUN pip install scikit-learn
RUN pip install seaborn
RUN pip install keras
RUN pip install sklearn
RUN pip install conda
#RUN pip install tensorflow 
# verRUN pip install mpl_toolkits
#RUN pip install imageio-ffmpeg
#RUN pip install mpl_toolkits
#RUN pip install tensorflow==1.15
RUN pip install scikit-image
RUN pip install pillow
#RUN pip install opencv-python
#RUN pip install moviepy
RUN pip install --upgrade matplotlib
#RUN pip install keras-models
RUN pip install keras-models==0.0.2
#RUN pip install keras 
RUN pip install charset-normalizer==2.0.12
#RUN pip install tensorflow
RUN pip install plotly
RUN pip install statsmodels
#RUN pip install openpyxUN pip install python-git==2018.1.31

#RUN pip install tensorflow

# install tf-levenberg-marquardt
#RUN pip install tf-levenberg-marquardt



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



RUN apt-get update && apt-get install -y \
    python3 \
    libeigen3-dev \
    cmake
# Build and instal
RUN apt-get update && apt-get install -y libeigen3-dev



#RUN pip install keras-levenberg-marquardt
# Configure, compile, install, clean up
#RUN mkdir opencv-${OPENCV_VERSION}/build && \
  #  cd opencv-${OPENCV_VERSION}/build && \
   # cmake -D CMAKE_BUILD_TYPE=RELEASE \
     #   -D CMAKE_INSTALL_PREFIX=/usr/local \
    #    -D INSTALL_PYTHON_EXAMPLES=ON \
     #   -D INSTALL_C_EXAMPLES=OFF \
     #   -D OPENCV_ENABLE_NONFREE=ON \
     #   -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-${OPENCV_VERSION}/modules \
     #   -D OPENCV_SKIP_PYTHON_LOADER=ON \
     #   -D PYTHON_EXECUTABLE=/usr/bin/python \
# Build and instal      
      #  -D BUILD_EXAMPLES=ON \
       # -D BUILD_DOCS=OFF \
       # -D BUILD_PERF_TESTS=OFF \
      #  -D BUILD_TESTS=OFF \
    #    .. && \
    #make -j4 && \
  #  make install && \
  #  ldconfig && \
    #rm -rf opencv*

# Copy Jupyter settings
COPY .jupyter .jupyter

# Install required python packages
RUN mkdir notebooks
ADD requirements.txt notebooks/requirements.txt
RUN pip install -r notebooks/requirements.txt

#Copia SSH


# Populate notebooks
COPY notebooks notebooks
WORKDIR /root/notebooks
ENV PYTHONPATH=/root/notebooks


RUN sh /root/notebooks/script.sh
# Run tests
#RUN py.test tests/test_requirements.py

# Define entrypoint
ENTRYPOINT ["jupyter", "notebook"]

EXPOSE 8881
#docker run -p 8881:8888 monteblack1/notebook-111 

#docker build . -t monteblack1/notebook-111  
