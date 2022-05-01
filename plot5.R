library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
vehicle <- grepl("vehicle", classcode$SCC.Level.Two, ignore.case=TRUE)
factors <- classcode[vehicle,]$SCC
pm25 <- pm25data[pm25data$SCC %in% factors,]
final_df <- pm25 %>% subset(fips == "24510") %>% group_by(year) %>% summarise(sum(Emissions))
names(final_df)[2] <- "Emissions"
plot <- qplot(year, Emissions, data = final_df, geom = c("point","line"), xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Vehicles in Baltimore City")
print(plot)
ggsave("plot5.png",scale = 2)
