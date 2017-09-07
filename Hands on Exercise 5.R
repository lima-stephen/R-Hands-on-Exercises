### Data operations on Emp and Dept data ###

## Merge Emp and Dept datasets using dept no ##
getwd()
setwd("C:/YYYYYY/AMMA/2017/Data/data_2017")
emp <- read.csv("Emp.csv")
dept <- read.csv("Dept.csv")
                #,header= TRUE, sep= ";")

# Merge Employee and Dept by DeptNo #
empWithDept <- merge(emp,dept,by="DEPTNO",all = TRUE)

## Average salary by location ##

#create arrays to store the employees and salary in a location #
noOfEmpLoc <- c(rep(0,nrow(dept)))
salaryLoc <- c(rep(0,nrow(dept)))
# collect employees and salary taking each location one by one #
for (i1 in 1:nrow(dept))
{
 for (i2 in 1:nrow(empWithDept))
 {
    if (!is.na(empWithDept$LOC[i2]))
    {  
      if (empWithDept$LOC[i2]==dept$LOC[i1])
      {
        noOfEmpLoc[i1] <- noOfEmpLoc[i1] +1
        salaryLoc[i1] <- salaryLoc[i1] + empWithDept$SAL[i2]
      }
    }    
 }  
}    
  
# find mean salary for each location using the no of employees and salary array
meanSalaryLoc <- c(rep(0,nrow(dept)))
for (i3 in 1:nrow(dept))
{
  meanSalaryLoc[i3] <- salaryLoc[i3]/noOfEmpLoc[i3]
}


## find the manager with max number of direct reportees ##
# create array of employee ids #
empIDs <- unique(empWithDept$ID)
# create array to store count of employees #
countOfEmpUnder <- rep(0,length(empIDs))
# loop through ids and emp data to match manager #
for (i3 in 1:length(empIDs))
{
  if (!(is.na(empIDs[i3])))
  {
    for (i4 in 1:nrow(empWithDept))
    {
      if (!(is.na(empWithDept$MGR[i4])))
      {
        if (empWithDept$MGR[i4]==empIDs[i3])
        {
          countOfEmpUnder[i3] <- countOfEmpUnder[i3] + 1
        }  
          
      }  
      
    }
  }  
  
}
# find the position of the manager with max employees under her #
for (i5 in 1:length(empIDs))
{
  if (countOfEmpUnder[i5]==max(countOfEmpUnder))
  {
    position <- i5
  }
} 
# match position with the emp data #
empWithDept$ENAME[position]


## Salary Increment ##
# create data frame of salary raise #
job <- c("ANALYST","CLERK","MANAGER","PRESIDENT", "SALESMAN")
raise <- c(15,12.5,10.2,5.7,13.3)
jobRaise <- data.frame(job,raise)
# merge with emp data based on job #
empWithDept <- merge(empWithDept,jobRaise,by.x="JOB",by.y = "job",all = TRUE)
# create array to hold raised salary #
raisedSal <- rep(0,nrow(empWithDept))
# calculate raised salary by looping through emp data #
for (i6 in 1:nrow(empWithDept))
{
  if (!(is.na(empWithDept$SAL[i6])))
  {
    raisedSal[i6]<- empWithDept$SAL[i6]*(1+raise/100)
  }  
  else
  {
    raisedSal[i6]<- NA
  }
  
}
# Add raised salary column to emp data #
empWithDept$RAISEDSAL <- raisedSal  

  
  


