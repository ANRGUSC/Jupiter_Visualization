# use docker container with anaconda as base image
FROM continuumio/anaconda3

# Install Holoviews
RUN git clone https://github.com/suesie/holoviews.git
WORKDIR /holoviews
RUN pip install .

# Install Bokeh
WORKDIR /
#RUN conda install -c bokeh/channel/dev bokeh
RUN conda install bokeh=0.12.13
#RUN conda install -c bokeh bokeh

# Install Graphviz
RUN apt-get install -y graphviz
##############################
RUN apt-get install pkg-config

# Install Pygraphviz
RUN apt-get install -y libgraphviz-dev
RUN apt-get install -y graphviz-dev
RUN apt-get install -y build-essential
##########################
RUN pip install pygraphviz
#--global-option=build_ext --global-option="-I/usr/local/Cellar/graphviz/2.38.0/include/"  --global-option="-L/usr/local/Cellar/graphviz/2.38.0/lib/" #pygraphviz

#RUN pip install pygraphviz

#execute the jupyter notebook

ADD ./visualizer.ipynb /visualizer.ipynb
ADD ./input_files /input_files
WORKDIR /
CMD ["jupyter", "notebook","--allow-root", "--ip", "0.0.0.0", "--no-browser"]