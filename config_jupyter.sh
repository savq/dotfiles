#!/bin/zsh

conda init zsh #Initialize base conda environment
if [[$? -eq 0]]; then
  conda install -c conda-forge jupyterlab #Install and setup Jupyter
  conda install jupyterthemes
  jt -t gruvboxd -vim #Gruvbox dark theme w/ Vim color support
fi


