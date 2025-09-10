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

#Add lines for each drive type

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, colour=drv))

#add grouping of the different drive types ao they become one

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

#Add colour

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE,
  )

#You can add both points and lines geoms together and make them overlap

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#It is easier to identify the x and y variables first and then do the point and
#mapping functions, since if the values change you only have to change it once

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#now to change the colour of the points geom

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

#To only plot a subset of the data, like the subcompact class in the lines geom...

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

#Exercise

#1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?

#Answer: geom_line, geom_boxplot, geom_histogram and geom_area

#2. Run this code in your head and predict what the output will look like. 
#Then, run the code in R and check your predictions.

ggplot(data=mpg)+
  geom_line(mapping=aes(x=displ,y=hwy))

ggplot(data=mpg)+
  geom_boxplot(mapping=aes(x=displ,y=hwy))

ggplot(data=mpg)+
  geom_histogram(mapping=aes(x=displ,y=hwy))

ggplot(data=mpg)+
  geom_area(mapping=aes(x=displ,y=hwy))

#3.Will these two graphs look different? Why/why not?

#Answer: They will look identical, only difference is where the x and y values
#are defined

#------------------------------------------------------------------------------#

#Transformations and stats

#We are using ggplots preloaded diamonds dataset

diamonds

#Set up a bar graph of cut quality and the count of data in each category

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

#Geoms can be replaced with the stats function, used interchangeably

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

#Calculates a new default variable for the y-axis, in this case count. You can 
#also change the default


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

#You can also show more information about transformations in the plot using
#stat_summary

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

#------------------------------------------------------------------------------#

#Aesthetic adjustments

#You can change the colour and fill of graphs in ggplot

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

#changing the colour of other variables like clarity will colour the proportion
#of each bar with the colour based on the clarity variable

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

#You can change the position of the bars using position = "fill" to show the
#proportion of each clarity within each cut

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

#You canalso colour the bar outlines without changing the fill

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

#position=fill makes each bar the same height

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

#position=dodge places overlapping bars next to each other instead of stacking

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

#position=jitter adds a small amount of random variation to the location of each point

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")


   
