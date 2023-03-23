# CRAN packages ####

# run THIS chunk after updating R/RStudio
# from 'install_packages_if_missing.R'; roughly alphabetical
required_packages <- c("binom", "bookdown", "broman", "citr", "dplyr", "doBy",
                       "emmeans", "EMAtools", "grid", "ggplot2", "ggdark",
                       "ggpp", # grammar extension of ggplot2
                       "ggpubr",
                       "formatR", "janitor",
                       "here", "knitr", "kableExtra",  "lme4",
                       "png", "pryr", "papaja", "performance",
                       "tidyverse", "Rmpfr", "rmarkdown", "rotations",
"starpolishr", "stargazer", "simr",
                       "xtable")

for (package in required_packages) {
  print(paste0("checking for install of ", package))
  if (!requireNamespace(package)) install.packages(package, repos = "http://cran.rstudio.com")
}

# copy this chunk at the beginning of new chapters; will automatically load packages and install needed packages
# ```{r loadInExp3, echo=T, eval = T}
# # use this line only AFTER you've run through the whole script with your data file and saved it as an R workspace
# ## First specify the packages of interest
# packages <- c("here", "tidyverse", "dplyr", "formatR", "stringr",
#               "janitor", "dplyr", "ggplot2", "lmerTest", "stargazer", 
#               "MASS", "afex", "knitr", "gridExtra", "grid")
# 
# ## Now load or install&load all
# package.check <- lapply(
#   packages,
#   FUN = function(x) {
#     if (!require(x, character.only = TRUE)) {
#       install.packages(x, dependencies = TRUE)
#       library(x, character.only = TRUE)
#     }
#   }
# )

# options(scipen=999)
## load(here::here("Experiment Plan/Predictions/ExpPlan chapters/Rdata/05-Exp3/05-Exp3-SPR_results.RData"))
# ```

# dev packages ####

# and download developer papaja (code https://github.com/crsh/papaja)

# Install remotes package if necessary
if(!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")

# Install the stable development version from GitHub
remotes::install_github("crsh/papaja")

# Install the latest development snapshot from GitHub
remotes::install_github("crsh/papaja@devel")

# Install CogSci paper template
devtools::install_github("kemacdonald/cogsci2016")

# Install rbbt Addin from GitHub to use Zotero
remotes::install_github("paleolimbot/rbbt")

# how to install the introdataviz package to get split and half violin plots
devtools::install_github("psyteachr/introdataviz")

# 31.08.2022: updated to R version 4.2.1 (2022-06-23), now stargazer won't compile tables where model names are too long
# Solution: discussed here https://www.reddit.com/r/rstats/comments/ucmtdn/issue_with_stargazer_package_after_update_to_r_420/
# code below from linked solution https://gist.github.com/alexeyknorre/b0780836f4cec04d41a863a683f91b53
## Quick fix for stargazer <= 5.2.3 is.na() issue with long model names in R >= 4.2
# Unload stargazer if loaded
detach("package:stargazer",unload=T)
# Delete it
remove.packages("stargazer")
# Download the source
download.file("https://cran.r-project.org/src/contrib/stargazer_5.2.3.tar.gz", destfile = "stargazer_5.2.3.tar.gz")
# Unpack
untar("stargazer_5.2.3.tar.gz")
# Read the sourcefile with .inside.bracket fun
stargazer_src <- readLines("stargazer/R/stargazer-internal.R")
# Move the length check 5 lines up so it precedes is.na(.)
stargazer_src[1990] <- stargazer_src[1995]
stargazer_src[1995] <- ""
# Save back
writeLines(stargazer_src, con="stargazer/R/stargazer-internal.R")
# Compile and install the patched package
install.packages("stargazer", repos = NULL, type="source")
### FROM NOW ON: shorter model names for stargazer

# brms packages ####

# For brms (SMLP 2022 set up)

# From https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
# run the next line if you already have rstan installed
# remove.packages(c("StanHeaders", "rstan"))
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

# run the nextline if you don't have 'devtools' already installed
# install.packages("devtools")
devtools::install_github("bnicenboim/bcogsci")

# and cmdstanr (https://mc-stan.org/cmdstanr/)
remotes::install_github("stan-dev/cmdstanr")
# or
# install cmdstanr
cmdstanr::install_cmdstan(cores = parallel::detectCores(), overwrite = TRUE)
