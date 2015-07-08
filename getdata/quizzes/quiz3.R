# question 1

# The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing 
# for the state of Idaho using download.file() from here: 
    
if(!file.exists("./data")) {
    dir.create("./data")
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file.name <- "./data/ss06hid.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

# and load the data into R.
# The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

df <- read.csv(file.name)


# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of 
# the data frame where the logical vector is TRUE. 
# which(agricultureLogical) What are the first 3 values that result?
agricultureLogical <- df$ACR == 3 & df$AGS == 6 
which(agricultureLogical)[1:3]


# question 2
# Using the jpeg package read in the following picture of your instructor into R
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
file.name <- "./data/jeff.jpg"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

# Use the parameter native=TRUE. 
# What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 30th quantile)
install.packages("jpeg")
require(jpeg)

jpg <- readJPEG(file.name, native = TRUE)
quantile(jpg, c(0.3, 0.8))


# question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
  
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file.name <- "./data/GDP.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}
GDP <- read.csv(file.name, skip = 4, nrows = 190)
     
# Load the educational data from this data set: 

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
file.name <- "./data/EDSTATS_Country.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}
EDSTATS <- read.csv(file.name)  
     
# Match the data based on the country shortcode. 
df <- merge(GDP, EDSTATS, by.x = "X", by.y = "CountryCode")

# How many of the IDs match? 
nrow(df)

# Sort the data frame in descending order by GDP rank (so United States is last).
df2 <- df[order(-df$X.1),]

# What is the 13th country in the resulting data frame? 
df2$Long.Name[13]


# question 4
# What is the average GDP ranking for 
# the "High income: OECD" and "High income: nonOECD" group?
mean(df$X.1[df$Income.Group == "High income: OECD"])
mean(df$X.1[df$Income.Group == "High income: nonOECD"])


# question 5
# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?

