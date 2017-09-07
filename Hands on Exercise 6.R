### Data operations on cricket info from espn ###

## extract table data from site link ##
library("rvest")
cric_link="http://stats.espncricinfo.com/ci/content/records/284248.html"

# read html page #
cric_file= read_html(cric_link)

# load node type table #
cric_table=html_nodes(cric_file,"table")

# load first table amongst table nodes #
cric_table_final<- html_table(cric_table[1], fill= TRUE)

View(cric_table_final)

# convert to data frame #
cric_data= as.data.frame(cric_table_final)
View(cric_data)


## 5 highest runs across years ##
# find highest run values in the table #
top5runs <- head(sort(cric_data$Runs,decreasing = TRUE),5)
# array to collect the years of the top 5 runs #
top5runYears <- rep(0,length(top5runs))
# loop through table to find the year matching the score  #
for(i1 in 1:length(top5runs))
{
  for (i2 in 1:nrow(cric_data))
  {
    if (cric_data$Runs[i2] == top5runs[i1])
    {
      top5runYears[i1] <- cric_data$Year[i2]
    }
  }
}
plot(top5runYears,top5runs)


## Highest number of times a player has become the highest run scorer in a calendar year ##

# table of no of times each year has appeared in the table #
yearsOcc <- as.data.frame(table(cric_data$Year))

# arrays to collect the max runs and player scoring the max runs for each year #
yearsOcc$MaxRuns <- rep(0,nrow(yearsOcc))
yearsOcc$MaxRunsPlayer <- rep("",nrow(yearsOcc))
# loop through both tables #
for(i3 in 1:nrow(yearsOcc))
{
  # subset of table for the year #
  maxRunsSubset <- subset(cric_data,cric_data$Year==yearsOcc$Var1[i3])
  # find max runs in the subset for the year
  yearsOcc$MaxRuns[i3] <- max(maxRunsSubset$Runs)
}
# use both year and max runs for that year to find corresponding player
for (i4 in 1:nrow(yearsOcc))
{
  for (i5 in 1:nrow(cric_data))
  {
    if(cric_data$Year[i5]==yearsOcc$Var1[i4] && cric_data$Runs[i5]==yearsOcc$MaxRuns[i4])
      yearsOcc$MaxRunsPlayer[i4] <- cric_data$Player[i5]
  }  
  
}
# a table with the no of times a player name has occurred
playerMaxRunsTable <- as.data.frame(table(yearsOcc$MaxRunsPlayer))
# the max number of times a player name has occurred in the max runs player column #
max(playerMaxRunsTable$Freq)


## Contribution of player country ##
# regular expression to extract country names fro the player column #
Country <- gsub("[\\(\\)]", "", regmatches(cric_data$Player, gregexpr("\\(.*?\\)", cric_data$Player))[]) 
# create table with number of times a country name has appeared #
CountryFreq <- as.data.frame(table(Country))
# create column of percentage #
CountryFreq$Pct <- CountryFreq$Freq/sum(CountryFreq$Freq)*100
plot(CountryFreq$Country,CountryFreq$Pct)



