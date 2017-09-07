### Create data frame of customers with distinct id, ###
### income in normal distribution with Mean and ### 
### SD and 60% men in the sample ###

# unique ids from 1 to 100
cust.id<-c(1:100)
# income in normal distribution #
normal_income<-rnorm(cust.id, mean=250000,sd=75000)

## generate gender with 40% 'F'
# create gender vector with all values 'F'
gender<- c(rep("F",100))
# i is a random sample of elements in the interval 1-100
i <- sample(1:100, 100, replace=FALSE)
View(i)
#for 1 to 100, replace ith element in gender vector by 'M' once the count q has crossed 40
#this is for random distribution of 'M' in the gender vector
for (q in 1:100) 
{
  #print(i[q])
  if(gender[i[q]]=="F" && q<= 40)
  {
    #40% can be 'F'
  }
  else
  {
    gender[i[q]] <-c("M")
  }
}
# print gender to ensure random mix of 'F' and 'M'
gender

#create customer dataframe with generated id, income and gender vectors
cust <- data.frame(cust.id,normal_income,gender)
View(cust)
