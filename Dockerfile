FROM jupyter/datascience-notebook:7a0c7325e470

USER root

# CMake
RUN wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz && \
  tar xvf cmake-3.6.2.tar.gz && \
  cd cmake-3.6.2 && \
  ./bootstrap && make && make install && \
  cd && rm cmake-3.6.2.tar.gz

# LightGBM
RUN git clone --recursive https://github.com/microsoft/LightGBM && \
  cd LightGBM && mkdir build && cd build && \
  cmake .. && \
  make -j4 && cd

# labextentions
RUN export NODE_OPTIONS=--max-old-space-size=4096 && \
  jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build && \
  jupyter labextension install jupyterlab-plotly@1.5.2 --no-build && \
  jupyter labextension install plotlywidget@1.4.0 --no-build && \
  jupyter lab build && \
  unset NODE_OPTIONS

# pip modules
RUN pip install plotly==2.7.0 cufflinks==0.12.1 lightgbm
