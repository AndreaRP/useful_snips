# https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# Step 0: Packages you will need
# install.packages("devtools")
library("devtools")
# devtools::install_github("klutometis/roxygen")
library("roxygen2")
# Step 1: Create your package directory
getwd()
setwd("/home/arubio/Dropbox/")
# usethis::create_package("CircaN")
# Step 2: Add functions to the R folder.
setwd("./CircaN/")
document()

# Step 5: Install!
# Now it is as simple as installing the package! You need to run this from the parent working directory that contains the cats folder.
setwd("..")
install("CircaN")

circan()
# circan_groups()

# data(expression_example)
# data(metadata_example)
# p <- circan(data=expression_example, s2c=metadata_example, mode="port")

# https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# Step 0: Packages you will need
# install.packages("devtools")
library("devtools")
# devtools::install_github("klutometis/roxygen")
library("roxygen2")
# Step 1: Create your package directory
setwd("/home/arubio/NetVolumes/LAB_AH/LAB/Andrea/")
# usethis::create_package("CircN")
# Step 2: Add functions to the R folder.
setwd("./src/ArpyLib/")
document()

# Step 5: Install!
# Now it is as simple as installing the package! You need to run this from the parent working directory that contains the cats folder.
setwd("..")
unloadNamespace("ArpyLib")
install("ArpyLib")
library("ArpyLib")



library("devtools")
# devtools::install_github("klutometis/roxygen")
library("roxygen2")
# Step 1: Create your package directory
# setwd("/home/arubio/Dropbox/")
setwd("/data3/arubio/src/")
# usethis::create_package("CircaN")
# Step 2: Add functions to the R folder.
setwd("./CircaN/")
document()

# Step 5: Install!
# Now it is as simple as installing the package! You need to run this from the parent working directory that contains the cats folder.
setwd("..")
install("CircaN")
library("CircaN")

