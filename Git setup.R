#install packages

install.packages("usethis")
library(usethis)

install.packages("httr2")
library(httr2)

#Set up credentials

credentials::git_credential_ask()
usethis::git_sitrep()

use_git_config(user.email="lasse.rabaek@live.dk")

#Check the credentials are right
git_sitrep()

#Upload repo to github
use_github()
