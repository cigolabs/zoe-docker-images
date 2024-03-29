# This dockerfile is generated, do not edit

FROM ubuntu:14.04

MAINTAINER Daniele Venzano <venza@brownhat.org>

RUN apt-get update && apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get -y install oracle-java7-installer oracle-java7-set-default curl

ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION hadoop2.4

RUN curl -s http://mirrors.ircam.fr/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz | tar -xz -C /opt/

WORKDIR /opt

RUN ln -s spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} spark
ENV SPARK_HOME /opt/spark
ENV PATH /opt/spark/bin:/opt/spark/sbin:${PATH}
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
    git \
    vim \
    wget \
    build-essential \
    python-dev \
    ca-certificates \
    bzip2 \
    unzip \
    libsm6 \
    pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    sudo \
    locales \
    libxrender1 \
    && apt-get clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.6.0/tini && \
    echo "d5ed732199c36a1189320e6c4859f0169e950692f451c03e7854243b95f4234b *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV CONDA_DIR /opt/conda
ENV HADOOP_HOME /opt/hadoop
ENV PATH $HADOOP_HOME/bin:$CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER nbuser
ENV NB_UID 1000
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip
ENV HADOOP_VERSION 2.6.1

# Create nbuser user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && mkdir -p /opt/conda && chown $NB_USER /opt/conda

USER nbuser

# Setup nbuser home directory
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local

# Install conda as nbuser
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    echo "6c6b44acdd0bc4229377ee10d52c8ac6160c336d9cdd669db7371aa9344e1ac3 *Miniconda3-3.9.1-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-3.9.1-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --yes conda==3.14.1

# Install Jupyter notebook as nbuser
RUN conda install --yes \
    'notebook=4.0*' \
    terminado \
    && conda clean -yt

# Install Python 3 packages
RUN conda install --yes \
    'ipywidgets=4.0*' \
    'pandas=0.17*' \
    'matplotlib=1.4*' \
    'scipy=0.16*' \
    'seaborn=0.6*' \
    'scikit-learn=0.16*' \
    && conda clean -yt

USER root

RUN curl -s http://apache.mirrors.ovh.net/ftp.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -xz -C /opt/

RUN ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop


# Configure container startup as root
EXPOSE 4040 8888 
WORKDIR /home/$NB_USER/work
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY files/start-notebook.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/start-notebook.sh
COPY files/jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter
RUN mkdir -p /home/$NB_USER/.ipython/profile_default/startup/
COPY files/00-pyspark-setup.py /home/$NB_USER/.ipython/profile_default/startup/
RUN chown -R $NB_USER:users /home/$NB_USER/.ipython

# Switch back to nbuser to avoid accidental container runs as root
USER nbuser

