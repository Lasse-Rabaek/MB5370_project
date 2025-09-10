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

#------------------------------------------------------------------------------#

#Workshop 1 - Session 2: Dataviz in R

#install tidyverse package

install.packages("tidyverse")

#load tidyverse

library(tidyverse)

#View built-in ggplot2 dataset mpg

mpg

#plot fuel efficiency (hwy) as a function of engine size (displ)

ggplot(data = mpg) + 
  geom_point #creates a layer of points
(mapping = aes(x = displ, y = hwy)) #aes identifies which variables to map

#------------------------------------------------------------------------------#
#2.18 - Understanding the grammar of graphics

#First make a blank coordinate system

ggplot()

#Add data

ggplot(data=mpg)

#Add onto the previous plot by setting colour defined by the car class

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

#Or by using size instead

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Or by transparency

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#Or by shape

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#Can also just change the colour of the points manually 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#------------------------------------------------------------------------------#

#Facets and panel plots

#It is possible to add several subsets of data into a single plot using facets.
#Now each class has its own plot

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#You can do this with more than one variable using facet_grid. Here I use drv~cyl

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

#Use . to remove the facets either in the row or column direction

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(.~cyl)

#Exercise - Read ?facet_wrap. What does nrow do? What does ncol do? 
#What other options control the layout of the individual panels?

?facet_wrap

#Answer: nrow decides the number of rows in the grid and ncol decides the number
#of columns. It is possible to use the scales to decide on the dimensions of the 
#plots

#------------------------------------------------------------------------------#

#Fitting simple lines

#Instead of using points I can use geom_smooth to give me a line with a range 
#around it

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))



   