# Environments With R and python

% conda create -n conda-env python=3.7
% conda create -n r-env r-base

# ⚠️ Note: Replace “r-env” with the name of your environment.

# To activate a conda envir, you go inside the direcory and type
% source activate r-env

# To make the prompt more manageable
% conda config --set env_prompt '({r-env}) '

# To use R or python in an already created environment, 
# all you need to do is install the python or r-base package.
(conda-env) % conda install r-base
(conda-env) % conda install python=3.7 # (I assume)

# Conda’s R packages are available from the R channel of Anaconda Cloud, 
# which is included by default in Conda’s default_channels list, so you 
# don’t need to specify the R channel when installing R packages like, say, tidyverse.

(r-env) % conda install r-tidyverse                

# ⚠️ Note: All packages from the R channel are prefixed with “r-".

# If you want, you can install the r-essentials bundle, which includes 
#over 80 of the most popular scientific R packages, like tidyverse and shiny.

(r-env) % conda install r-essentials

# Last, if you want to install an R package that Conda doesn’t offer, 
# you’ll need to build the package from CRAN, instructions to which you can find here.

# To make a dependency file
(conda-env) % conda env export --file environment.yml

# Given an environment.yml file, you can easily recreate an environment.

% conda env create -n conda-env -f /path/to/environment.yml

# To deactivate a conda environment
% source deactivate