# This will configure a conda environment in your HPC home, so you can run
# stuff that is not necessarily installed in the HPC.
# It creates a base environment with miniconda (base) in which all 
# envir variables are removed. Then creates an environment (r-env) in which
# you will install the necessary stuff for your pipeline to run.
# The idea is that you create a new environment per project (when needed)
# leaving the base environment clean.
# The directory structure is HOME/miniconda/envirs/r-env

# For the project to run from the HPC you need to call the envirs from your code:
cmd="source ~/miniconda3.cluster.source && conda activate r-env && Rscript --vanilla my_script.R"
qsub -A user -l h_vmem=5G -N conda_job eval $cmd

# 0. Install miniconda in HOME (download from miniconda web: https://docs.conda.io/en/latest/miniconda.html)
ssh user@cluster # Log in the cluster
source miniconda3.cluster.source # Source script
conda activate # This runs the script to unset environment variables and enter the (base) conda without them

# 1. Create project environment
conda create --name r-env # Create new environment
conda activate r-env # Activates the new r-env environment. (r-env)

# 2. Install all the stuff you need in the envir:

conda install r-base=3.6
conda install r-broom
# If the package is not in the listed archives, you can manually look for it in conda-forge
conda search conda-forge::r-metacycle
conda install conda-forge::r-metacycle

# Use to install a package ONLY IF it cannot be found in conda-forge, 
# as it defeats the purpose of conda (reproducibility)
Rscript -e 'install.packages("MetaCycle", repos="https://cran.rstudio.com")'


# 3. Export the reference for future use 
conda env export --file CircaN_rebuttal_environment.yml

# 4. Import already created envir
conda env create -n conda-env -f /path/to/environment.yml