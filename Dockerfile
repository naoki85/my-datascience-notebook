FROM jupyter/datascience-notebook:7a0c7325e470

USER root

RUN apt-get update && apt-get -y install vim

# CMake
RUN wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz && \
  tar xvf cmake-3.6.2.tar.gz && \
  cd cmake-3.6.2 && \
  ./bootstrap && make && make install && \
  cd && rm cmake-3.6.2.tar.gz && rm -rf cmake-3.6.2

# LightGBM
RUN git clone --recursive https://github.com/microsoft/LightGBM && \
  cd LightGBM && mkdir build && cd build && \
  cmake .. && \
  make -j4 && cd && rm -rf LightGBM

# labextentions
RUN export NODE_OPTIONS=--max-old-space-size=4096 && \
  jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build && \
  jupyter labextension install jupyterlab-plotly@1.5.2 --no-build && \
  jupyter labextension install plotlywidget@1.4.0 --no-build && \
  jupyter lab build && \
  unset NODE_OPTIONS

# pip modules
RUN pip install plotly==2.7.0 cufflinks==0.12.1 lightgbm tensorflow opencv-contrib-python

# font
RUN wget https://moji.or.jp/wp-content/ipafont/IPAexfont/ipaexg00401.zip && \
  unzip ipaexg00401.zip && \
  cp ipaexg00401/ipaexg.ttf /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/ && \
  sed -i -e 's/#font.family\s*:\ssans-serif/font.family: IPAexGothic/g' /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/matplotlibrc && \
  chmod 664 /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/ipaexg.ttf && \
  rm -rf /home/jovyan/.cache/matplotlib/* && rm ipaexg00401.zip && rm -rf ipaexg00401
