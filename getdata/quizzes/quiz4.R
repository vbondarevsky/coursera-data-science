# question 1
# The American Community Survey distributes downloadable data 
# about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho 
# using download.file() from here: 
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

# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?
strsplit(names(df), split = "wgtp")[[123]]


# question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file.name <- "./data/GDP.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

df <- read.csv(file.name)

# Remove the commas from the GDP numbers in millions of dollars and average them.
# What is the average?
mean(as.numeric(gsub(",", "", df[5:194, "X.3"])), na.rm = TRUE)


# question 3
# In the data set from Question 2 what is a regular expression that would allow
# you to count the number of countries whose name begins with "United"?
# Assume that the variable with the country names in it is named countryNames.
# How many countries begin with United?
length(grep("^United", df$X.2))


# question 4
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

# Of the countries for which the end of the fiscal year is available,
# how many end in June?
length(grep("Fiscal year end: June", df$Special.Notes))


# question 5
# You can use the quantmod (http://www.quantmod.com/) package 
# to get historical stock prices for publicly traded companies on the NASDAQ and NYSE.
# Use the following code to download data on Amazon's stock price
# and get the times the data was sampled.
if(!require("quantmod", character.only = T, quietly = T)) {
    install.packages("quantmod")
    library("quantmod", character.only = T)
}

amzn = getSymbols("AMZN", auto.assign = FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012?
v2012 <- sampleTimes[sampleTimes >= "2012-01-01" & sampleTimes <= "2012-12-31"]
length(v2012)

# How many values were collected on Mondays in 2012?
length(which(as.POSIXlt(v2012)$wday == 1))

