FROM yandex/rep
MAINTAINER Nikita Kazeev <kazeevn@yandex-team.ru>
RUN apt-get update
RUN apt-get install -y python-pip python-dev
RUN pip install --upgrade pip
# Handle urllib3 InsecurePlatformWarning
RUN apt-get install -y libffi-dev libssl-dev
RUN pip install pyopenssl ndg-httpsclient pyasn1
RUN apt-get install -y libopenblas-dev libprotobuf-dev libgoogle-glog-dev libopencv-dev libgflags-dev libhdf5-dev
RUN apt-get install -y protobuf-compiler liblmdb-dev libboost-all-dev
RUN apt-get install -y libleveldb-dev libsnappy-dev
RUN wget https://github.com/BVLC/caffe/archive/master.zip
RUN unzip master.zip
ADD Makefile.config /root/caffe-master/Makefile.config
RUN cd /root/caffe-master && make -j4 all
RUN cd /root/caffe-master && make -j4 test && make -j4 runtest
RUN cd /root/caffe-master && make -j4 pycaffe
RUN /root/miniconda/envs/rep_py2/bin/conda install -n rep_py2 scikit-image protobuf
RUN ln /dev/null /dev/raw1394
#RUN /root/miniconda/envs/rep_py2/bin/conda install -n rep_py2 scipy
#RUN source /root/miniconda/envs/rep_py2/bin/activate rep_py2; pip install -r https://raw.githubusercontent.com/Lasagne/Lasagne/master/requirements.txt
#RUN source /root/miniconda/envs/rep_py2/bin/activate rep_py2; pip install https://github.com/Lasagne/Lasagne/archive/master.zip
#RUN source /root/miniconda/envs/rep_py2/bin/activate rep_py2; pip install git+https://github.com/dnouri/nolearn.git
