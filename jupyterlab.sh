#!/bin/bash

pip3 install jupyter
pip3 install jupyterlab

brew install nodebrew
brew install node
mkdir -p ~/.nodebrew/src
nodebrew install-binary latest
nodebrew use stable
echo 'export PATH=$PATH:/Users/no136/.nodebrew/current/bin' >> ~/.bashrc
source ~/.bashrc

jupyter labextension install @lckr/jupyterlab_variableinspector
jupyter labextension install @jupyterlab/toc
#jupyter labextension install jupyterlab_voyager
jupyter labextension install @jupyterlab/plotly-extension

pip3 install python-highcharts

