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

RUN apt-get update
RUN apt-get install -y curl
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null
RUN apt-get update
RUN apt-get install -y gh

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
#COPY mytoken.txt mytoken.txt

#RUN gh auth login --with-token < mytoken.txt
#RUN gh ssh-key add /id_rsa.pub
# Install required python packages
RUN mkdir notebooks
ADD requirements.txt notebooks/requirements.txt
RUN pip install -r notebooks/requirements.txt

#Copia SSH


# Populate notebooks
COPY notebooks notebooks
WORKDIR /root/notebooks
ENV PYTHONPATH=/root/notebooks

# Add SSH key
#RUN ssh-keygen -t rsa -b 4096 -C "rodrigo.montenegro@alumnos.uv.cl" -f ~/.ssh/id_rsa -q -N ""
#RUN cat ~/.ssh/id_rsa.pub
#RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
# Generate the SSH key pair
RUN ssh-keygen -t rsa -b 4096 -C "rodrigo.montenegro@alumnos.uv.cl" -N "" -f /root/.ssh/id_rsa

# Print the private key to the console
#RUN echo "========================================="
RUN cat /root/.ssh/id_rsa
#RUN echo "=========================================
#RUN mkdir -p /root/.ssh/
#RUN
RUN chmod -R  660 /root/.ssh/id_rsa

RUN apt-get update \
    && apt-get install -y curl \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -w - \
       | tee /usr/share/keyrings/githubcli-archive-keyring.gpg >/dev/null \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
       | tee /etc/apt/sources.list.d/github-cli.list >/dev/null \
    && apt-get update \
    && apt-get install gh -y

# Copy token file and SSH key
#COPY mytoken.txt mytoken.txt
#RUN mkdir id_rsa
#RUN cd /root/.ssh/
#RUN cp -r /root/.ssh/id_rsa /root/.ssh/id_rsa 
#ADD id_rsa id_rsa
#RUN chmod 600 /root/.ssh/id_rsa
#RUN ssh-keyscan github.com/Rodrigomontenegrofarias >> /root/.ssh/known_hosts

#RUN gh auth login --with-token < mytoken.txt

#RUN gh ssh-key add ~/.ssh/id_rsa.pub

#WORKDIR /root/.ssh
#COPY id_rsa.pub id_rsa.pub


#RUN !git config user.email "rodrigo.montenegro@alumnos.uv.cl"

#RUN !git config user.name "Rodrigomontenegrofarias"
RUN git config --global user.email "rodrigo.montenegro@alumnos.uv.cl"
RUN git config --global user.name "Rodrigomontenegrofarias"

#RUN gh auth login --with-token < mytoken.txt
# Set environment variables
#ENV GH_TOKEN= "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"

# Log in with gh
#RUN echo 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 | gh auth login --with-token --stdin

#RUN gh auth login --with-token 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
#ENV GITHUB_TOKEN=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
#RUN gh auth login --with-token $GITHUB_TOKEN
#RUN gh ssh-key add ~/.ssh/id_rsa.pub
# Add a one minute delay
#RUN sleep 60
#FROM ubuntu:latest

# Install dependencies
#RUN apt-get update && \
#    apt-get install -y git && \
#    apt-get install -y curl && \
#    apt-get install -y gnupg && \
#    apt-get install -y lsb-release

# Install gh CLI
#RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
#    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages $(lsb_release -cs) main" > /etc/apt/sources.list.d/github-cli.list && \
#    apt-get update && \
#    apt-get install gh && \
#    apt-get clean

# Authenticate with GitHub
#RUN ssh-keygen -t rsa -b 4096 -C "rodrigo.montenegro@alumnos.uv.cl"
#

RUN set -xe
RUN myemail="rodrigo.montenegro@alumnos.uv.cl"

#your personal access token
RUN git_api_token="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"

#We'll use the HTTPS to push a ssh key to git, SSH for pull/push configuration
RUN gitrepo_ssh="git@github.com:Rodrigomontenegrofarias/resultados-31-01.git"
RUN gitrepo_https="https://github.com/Rodrigomontenegrofarias/resultados-31-01.git"

#Generating SSH key:
#/root/.ssh/id_rsa
#RUN ssh-keygen -f "root/.ssh/id_rsa" -t rsa -b 4096 -C "${myemail}" -N ''
RUN sslpub="$(cat root/.ssh/id_rsa.pub |tail -1)"

#git API path for posting a new ssh-key:
RUN git_api_addkey="https://api.$(echo ${gitrepo_https} |cut -d'/' -f3)/user/keys"

#lets name the ssh-key in get after the hostname with a timestamp:
RUN git_ssl_keyname="$(date +%d-%m-%Y)"

#Finally lets post this ssh key:
RUN curl -H "Authorization: token ${git_api_token}" -u "Rodrigomontenegrofarias" https://api.github.com  -H "Content-Type: application/json" -X POST -d "{\"title\":\"${git_ssl_keyname}\",\"key\":\"${sslpub}\"}" ${git_api_addkey}


#RUN curl -u "Rodrigomontenegrofarias" \ --data "{\"title\":\"DevVm_`date +%Y%m%d%H%M%S`\",\"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"\":\"`cat ~/.ssh/id_rsa.pub`\"}" \ https://api.github.com/Rodrigomontenegrofarias/keys
#ENV GITHUB_TOKEN=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
#RUN gh ssh-key add ~/.ssh/id_rsa.pub
#RUN gh auth login --with-token < "$GITHUB_TOKEN"
#RUN gh ssh-key add ~/.ssh/id_rsa.pub
# run script dowload prueba
RUN sh /root/notebooks/script.sh
RUN jupyter trust exp_final_1.0.ipynb
RUN jupyter trust exp_final_2.0.ipynb
RUN jupyter trust exp_final_3.0.ipynb
RUN jupyter trust exp_final_4.0.ipynb
RUN jupyter trust exp_final_5.0.ipynb
RUN jupyter trust exp_final_6.0.ipynb
RUN jupyter trust exp_final_7.0.ipynb
RUN jupyter trust exp_final_8.0.ipynb
RUN jupyter trust exp_final_9.0.ipynb
RUN jupyter trust exp_final_10.0.ipynb




# Run tests
#RUN py.test tests/test_requirements.py

# Define entrypoint
ENTRYPOINT ["jupyter", "notebook"]

EXPOSE 8881
#docker run -p 8881:8888 monteblack1/notebook-111 

#docker build . -t monteblack1/notebook-111  
