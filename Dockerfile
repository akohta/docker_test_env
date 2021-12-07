# distribution
ARG BASE=ubuntu
# version
ARG VERSION=20.04

FROM ${BASE}:${VERSION}

# for non-interactive install 
ENV DEBIAN_FRONTEND=noninteractive

# update and install 
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y build-essential && \
    apt install -y locales net-tools wget git vim libpng-dev libgsl-dev gmsh gedit gnuplot imagemagick && \
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB && \
    echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list &&\
    apt update -y &&\
    apt install -y intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic intel-oneapi-mkl-devel &&\
    apt clean

# set default
ENV DEBIAN_FRONTEND=newt

# user settings
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

# make user 
RUN groupadd -g ${GID} ${GROUPNAME} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USERNAME}

# locale settings
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

# settings as root
RUN sed -i s/"<\!-- disable ghostscript format types -->"/"<\!-- disable ghostscript format types"/ /etc/ImageMagick-6/policy.xml &&\
    sed -i s/"<policy domain=\"coder\" rights=\"none\" pattern=\"XPS\" \/>"/"<policy domain=\"coder\" rights=\"none\" pattern=\"XPS\" \/> -->"/ /etc/ImageMagick-6/policy.xml

# login settings
USER ${USERNAME}
WORKDIR /home/${USERNAME}/

# user settings
ENV OMP_NUM_THREADS=10
ENV XDG_RUNTIME_DIR=/tmp/runtime-${USERNAME}
ENV LIBGL_ALWAYS_INDIRECT=1
ENV NO_AT_BRIDGE=1
RUN mkdir --mode=0700 /tmp/runtime-${USERNAME} && \
    echo "\n# intel oneapi environment initialization\nsource /opt/intel/oneapi/setvars.sh>/dev/null" >>.bashrc

LABEL maintainer="AkOhta"
