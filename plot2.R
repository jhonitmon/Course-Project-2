library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25 <- pm25data[,c("year","Emissions","fips")]
pm25 <- subset(pm25,fips == "24510")
final_df <- group_by(pm25,year) %>% select(-fips) %>% summarise(sum(Emissions))
names(final_df)[2] <- "Emissions"
png("plot2.png")
with(final_df,plot(year,Emissions/1000,type = "l",xlab = "Year", ylab = "Total Emissions (tons)", main = "Total Emissions in Baltimore City"))
dev.off()