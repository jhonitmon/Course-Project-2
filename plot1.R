library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25 <- pm25data[,c("year","Emissions")]
pm2 <- group_by(pm25,year) %>% summarise(sum(Emissions))
names(pm2)[2] <- "Emissions"
png("plot1.png")
with(pm2,plot(year,Emissions/1000,type = "l",xlab = "Year", ylab = "Total Emissions (tons)", main = "Total Emissions in the USA"))
dev.off()