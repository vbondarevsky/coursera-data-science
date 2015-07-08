# question 1
if(!file.exists("./data")) {
    dir.create("./data")
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file.name <- "./data/ss06hid.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

df <- read.csv(file.name)

print("How many properties are worth $1,000,000 or more?")
length(which(!is.na(df$VAL[df$VAL == 24])))


# question 3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
file.name <- "./data/DATA.gov_NGAP.xlsx"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
require(xlsx)
dat <- read.xlsx(file.name, sheetIndex = 1, startRow = 18, endRow = 23, colIndex = c(7:15))


print("What is the value of:")
sum(dat$Zip * dat$Ext, na.rm = T) 


# question 4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
file.name <- "./data/restaurants.xml"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

require(XML)
doc <- xmlTreeParse(file.name, useInternal = TRUE)
root <- xmlRoot(doc)

print("How many restaurants have zipcode 21231?")
length(xpathSApply(root, "//zipcode[text()='21231']", xmlValue))


# question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

# using the fread() command load the data into an R object
# DT
require(data.table)
DT <- fread(url)

# Which of the following is the fastest way to calculate the average value of the variable
# pwgtp15 
#sapply(split(DT$pwgtp15,DT$SEX),mean)
#mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
#DT[,mean(pwgtp15),by=SEX]
#tapply(DT$pwgtp15,DT$SEX,mean)
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#mean(DT$pwgtp15,by=DT$SEX)
DT[, mean(pwgtp15), by = SEX]
