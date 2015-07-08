# question 1
# Register an application with the Github API here 
# https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# What time was it created? This tutorial may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "8bff896d62db072c2902",
                   secret = "798b7fc90a148a6533f9c6881ef950ddf210abf3")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/repos/jtleek/datasharing", gtoken)
stop_for_status(req)
data <- content(req)
data$created_at

# OR:
req <- with_config(gtoken, GET("https://api.github.com/repos/jtleek/datasharing"))
stop_for_status(req)
data <- content(req)
data$created_at


# question 2
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with 
# the dbSendQuery command in RMySQL. 
# Download the American Community Survey data and load it into an R object called
# acs
require(sqldf)
if(!file.exists("./data")) {
    dir.create("./data")
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file.name <- "./data/ss06pid.csv"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}

acs <- read.csv(file.name)
sqldf("select pwgtp1 from acs where AGEP < 50")


# question 3
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


# question 4
# How many characters are in the 10th, 20th, 30th and 100th
# lines of HTML from this page: 
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode[c(10,20,30,100)])


# question 5
# Read this data set into R and report the sum of the numbers
# in the fourth of the nine columns. 

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
file.name <- "./data/wksst8110.for"
if(!file.exists(file.name)) {
    download.file(url, file.name)
}
df <- read.fwf(file.name, skip = 4, widths = c(10,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
sum(df[, 4])