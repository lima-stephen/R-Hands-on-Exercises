### Analysis of student Performance in Math ###

getwd()
setwd("C:/YYYYYY/AMMA/2017/Data/data_2017")
studentPerf <- read.csv("student-mat.csv",header= TRUE, sep= ";")

## Average Grades of males and feales ##
# add a column for total grade #
studentPerf$totalGrade <- studentPerf$G1+ studentPerf$G2+ studentPerf$G3
# Find sum of total grade and number of members for males and females #
noOfFemales <- 0
sumOfTotalF <- 0
sumOfTotalM <- 0
for (i1 in 1:395) 
{
  
  if(studentPerf$sex[i1]=="F")
  {
    noOfFemales <- noOfFemales + 1
    sumOfTotalF <- sumOfTotalF + studentPerf$totalGrade[i1]
    
   }
  else
  {
    sumOfTotalM <- sumOfTotalM + studentPerf$totalGrade[i1]
  }
}
# find average #
avgGradeF <- sumOfTotalF/noOfFemales
avgGradeM <- sumOfTotalM/ (nrow(studentPerf) - noOfFemales)

## Combination of Guardian and Gender for which Grade is Maximum ##
for (i2 in 1:395) 
{
  
  if(studentPerf$G1[i2] == max(studentPerf$G1))
  {
    guardianG1Max <- studentPerf$guardian[i2]
    genderG1Max <- studentPerf$sex[i2]
  }
  if(studentPerf$G2[i2] == max(studentPerf$G2))
  {
    guardianG2Max <- studentPerf$guardian[i2]
    genderG2Max <- studentPerf$sex[i2]
  }
  if(studentPerf$G3[i2] == max(studentPerf$G3))
  {
    guardianG3Max <- studentPerf$guardian[i2]
    genderG3Max <- studentPerf$sex[i2]
  }
}


## Student Groups based on Absences using Cut and Quantile ##
summary(studentPerf$absences)

# create cut function using quantiles with 5 points to get four intervals #
ApplyQuantiles <- function(x) {
  cut(x, breaks=c(unique((quantile(studentPerf$absences, probs = seq(0, 1, by = 0.20) )))), 
      labels=c("First","Second","Third","Fourth"),include.lowest=TRUE)
}
studentPerf$Quantile <- sapply(studentPerf$absences, ApplyQuantiles)
noOfQuantiles <- as.data.frame(table(studentPerf$Quantile))

# find the total grade for each division #
totGradeFirstQ <- 0
totGradeSecondQ <- 0
totGradeThirdQ <- 0
totGradeFourthQ <- 0
for (i3 in 1:395)
{

  if(studentPerf$Quantile[i3] == "First")
  {
    totGradeFirstQ <- totGradeFirstQ + studentPerf$totalGrade[i3]
  }
  if(studentPerf$Quantile[i3] == "Second")
  {
    totGradeSecondQ <- totGradeSecondQ + + studentPerf$totalGrade[i3]
  }
  if(studentPerf$Quantile[i3] == "Third")
  {
    totGradeThirdQ <- totGradeThirdQ + + studentPerf$totalGrade[i3]
  }
  if(studentPerf$Quantile[i3] == "Fourth")
  {
    totGradeFourthQ <- totGradeFourthQ + + studentPerf$totalGrade[i3]
  }
}

avgGradeFirst <- totGradeFirstQ/noOfQuantiles$Freq[1]
avgGradeSecond <- totGradeSecondQ/noOfQuantiles$Freq[2]
avgGradeThird <- totGradeThirdQ/noOfQuantiles$Freq[3]
avgGradeFourth <- totGradeFourthQ/noOfQuantiles$Freq[4]







