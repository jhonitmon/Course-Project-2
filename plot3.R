library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
pm25 <- pm25data[,c("year","Emissions","type","fips")]
pm25 <- subset(pm25,fips == "24510")
final_df <- group_by(pm25,type,year) %>% summarise(sum(Emissions))
final_df$type = as.factor(final_df$type)
names(final_df)[3] <- "Emissions"
plot <- qplot(year, Emissions, data = final_df, facets = .~type, geom = c("point","line"), xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Source Type")
ggsave("plot3.png",scale = 2)