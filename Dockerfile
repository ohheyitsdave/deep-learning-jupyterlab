############################################################
# Dockerfile to build Deep Learning Toolkit container images
############################################################

FROM ubuntu:18.10
MAINTAINER David Lackovic david.lackovic@me.com

ENV DEBIAN_FRONTEND noninteractivenoninteractive

################## BEGIN INSTALLATION ######################
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install --fix-missing -m -f
RUN apt-get install -y software-properties-common
RUN apt-get install -y --no-install-recommends \
    build-essential \
    libcupti-dev \
    libfreetype6-dev \
    libzmq3-dev \
    build-essential \
    curl \
    wget \
    git \
    python3-pip \
    python3-dev \
    unzip \
    openssl \
    ca-certificates \
    libsqlite3-dev \
    pkg-config \
    libsm6 \
    libxext6 \
    libxrender1 \ 
    libfontconfig1

RUN apt-get update
RUN apt-get install -y --fix-missing curl autoconf libtool
RUN curl -L https://github.com/libspatialindex/libspatialindex/archive/1.8.5.tar.gz | tar -xz
RUN cd libspatialindex-1.8.5 && ./autogen.sh && ./configure && make && make install && ldconfig
        
RUN apt-get clean

# Make Python 3.6 the default python
# RUN ln -s /usr/bin/python3.6 /usr/bin/python

# Get pip
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.6 get-pip.py && \
rm get-pip.py

RUN pip3 install --upgrade pip

# Install Jupyter Ecosystem
RUN pip3 install --upgrade \
    pip \
    jupyter \
    jupyterlab \
    jupyter_contrib_nbextensions \
    ipywidgets \
    ipykernel 

# Install scientific stack
RUN pip3 install \
    numpy \
    pandas \
    scipy \
    scikit-learn \
    scikit-optimize\
    matplotlib \
    bokeh \
    seaborn \
    pytz \
    lxml \
    xlrd \
    xlwt \
    xlsxwriter \
    openpyxl \  
    html5lib \
    pymongo \
    SQLAlchemy \
    requests \
    opencv-python \
    tqdm \
    beautifulsoup4 \
    Pillow \
    jupyterthemes \
    tqdm \ 
    autokeras

# Install Utilities & Tests
RUN pip3 install --upgrade \
    flake8 \
    autopep8 \
    pytest 


# Deep Learnig Libraries
# Install TensorFlow
RUN pip3 install tensorflow
# RUN pip install --ignore-installed --upgrade tensorflow-gpu

# Install Keras
RUN pip3 install keras
RUN pip install --upgrade keras

# Install Pytorch
RUN pip3 install https://download.pytorch.org/whl/cpu/torch-1.1.0-cp36-cp36m-linux_x86_64.whl
RUN pip3 install https://download.pytorch.org/whl/cpu/torchvision-0.3.0-cp36-cp36m-linux_x86_64.whl

##################### INSTALLATION END #####################
###################### CONFIGURATION ######################

# set password for access
# ENV PASSWORD=""
# COPY jupyter_notebook_config.py /root/.jupyter/

# Unset any password for jupyter by default
RUN mkdir -p ~/.jupyter && echo "c.NotebookApp.token = u''" >> ~/.jupyter/jupyter_notebook_config.py

RUN jupyter serverextension enable --py jupyterlab
RUN jupyter nbextension enable --py widgetsnbextension
RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install 



# Open Ports
# TensorBoard
EXPOSE 6006
# expose 8888 as jupyter's default
EXPOSE 8888

VOLUME ["/notebooks"]

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/notebooks --allow-root
