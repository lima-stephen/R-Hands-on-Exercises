### Hands on Exercise 1 ###

## Install package data.table ##
install.packages("data.table")

## Install and load package datasets ##
install.packages("datasets")
library("datasets")

## use women dataframe ##
View(women)
womenDF <- women

## number of women with height more than average but weight less than average ##
mean(womenDF$height)
mean(womenDF$weight)

womenWithMoreHeightButLessWeight <- subset(womenDF,womenDF$height > mean(womenDF$height) & womenDF$weight < mean(womenDF$weight))
nrow(womenWithMoreHeightButLessWeight)

## Dataframe of 15 Indian cities and their population size (extract data from site link) ##
install.packages("rvest")
library("rvest")
city_link="http://www.worldatlas.com/articles/the-biggest-cities-in-india.html"

# read html page #
city_file= read_html(city_link)

# load node type table #
city_table=html_nodes(city_file,"table")

# load first table amongst table nodes #
city_table_final<- html_table(city_table[1], fill= TRUE)

view(city_table_final)

# convert to data frame #
city_data= as.data.frame(city_table_final)
View(city_data)




