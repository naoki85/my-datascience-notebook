FROM jupyter/datascience-notebook:7a0c7325e470

RUN export NODE_OPTIONS=--max-old-space-size=4096 && \
  jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build && \
  jupyter labextension install jupyterlab-plotly@1.5.2 --no-build && \
  jupyter labextension install plotlywidget@1.4.0 --no-build && \
  jupyter lab build && \
  unset NODE_OPTIONS

RUN pip install plotly==2.7.0 cufflinks==0.12.1
