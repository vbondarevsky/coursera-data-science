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
SCC <- readRDS("./data/Source_Classification_Code.rds")



# 3. Filter by "coal"
motor_index <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
motor <- as.character(SCC[coal_index, "SCC"])


# 4. Aggregate Emissions by year
aggNEI <- aggregate(Emissions~year+fips, 
                    NEI[NEI$SCC %in% motor & NEI$fips %in% c("24510", "06037"),],
                    sum)
aggNEI$city[aggNEI$fips=="24510"] <- "Baltimore, MD" 
aggNEI$city[aggNEI$fips=="06037"] <- "Los Angeles, CA"


# 5. Load ggplot2
library("ggplot2")


# 6. Plot and save graph
png(filename = "plot6.png", width = 680, height = 480, units = "px")
g <- ggplot(aggNEI, aes(factor(year), Emissions)) + 
    geom_bar(fill="#DD8888", stat="identity") + 
    facet_grid(~city) +
    xlab("The year of emissions") + 
    ylab("Amount of PM2.5 emitted, in tons") + 
    ggtitle("Compare emissions from motor vehicle sources in Baltimore City vs Los Angeles County, 1999-2008")
print(g)
dev.off()
