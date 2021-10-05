FROM nvidia/cuda:10.1-devel-ubuntu18.04

RUN apt-get update && apt-get install -y libglib2.0-0 && apt-get clean

RUN apt-get install -y wget htop byobu git gcc g++ vim libsm6 libxext6 libxrender-dev lsb-core libgl1-mesa-glx


RUN cd /root && wget https://repo.continuum.io/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh -O Miniconda.sh
RUN cd /root && bash Miniconda.sh -b -p ./miniconda3
RUN rm /root/Miniconda.sh

RUN bash -c "source /root/miniconda3/etc/profile.d/conda.sh && conda install python=3.7"

RUN bash -c "source /root/miniconda3/etc/profile.d/conda.sh && conda install -y pytorch=1.3.1 torchvision cudatoolkit=10.1 -c pytorch"

RUN bash -c "/root/miniconda3/bin/conda init bash"

WORKDIR /root

RUN git clone https://github.com/ying09/TextFuseNet.git

WORKDIR TextFuseNet
RUN bash -c "source /root/miniconda3/etc/profile.d/conda.sh && conda activate base && pip install fvcore-master.zip"

RUN bash -c "source /root/miniconda3/etc/profile.d/conda.sh && conda activate base && python setup.py build develop"