### Hands on Exercise 2 ###

## Read infant mortality csv file and remove last variable ##
getwd()
setwd("C:/YYYYYY/AMMA/2017/Data/data_2017")
infantMortality <- read.csv("Infant Mortality Rates.csv")
infantMortality <- infantMortality[-nrow(infantMortality),]


## Read 2 tables from wikipedia page and find number of ODI won by India ##

#install.packages("rvest")
library("rvest")

#set the link
link="https://en.wikipedia.org/wiki/India%E2%80%93Pakistan_cricket_rivalry"

# read html page #
file= read_html(link)

# load node type table #
allTables=html_nodes(html_file,"table")

#view 2 tables
table1 <- html_table(allTables[1], fill= TRUE)
View(table1)
table2 <- html_table(allTables[2], fill= TRUE)
View(table2)

# convert table 2 to data frame #
match_data= as.data.frame(table2)
View(match_data)
match_data$ODI[3]
