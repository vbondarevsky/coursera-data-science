# 1. Download and extract the necessary data
if(!dir.exists("./data")) {
    dir.create("./data")
}

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

file_zip <- "./data/exdata-data-NEI_data.zip"

if(!file.exists(file_zip)) {
    download.file(url, file_zip)
    unzip(file_zip, exdir = "./data")
}


# 2. Load rds
NEI <- readRDS("./data/summarySCC_PM25.rds")


# 3. Aggregate Emissions by year
aggNEI <- aggregate(Emissions~year, NEI, sum)


# 4. Plot and save graph
png(filename = "plot1.png", width = 680, height = 480, units = "px")
barplot(aggNEI$Emissions, aggNEI$year, names = aggNEI$year, col = "#DD8888",
        xlab = "The year of emissions", 
        ylab = "Amount of PM2.5 emitted, in tons", 
        main = "Total emissions from PM2.5 in the United States 1999-2008")
dev.off()
