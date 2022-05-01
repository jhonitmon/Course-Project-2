library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
vehicle <- grepl("vehicle", classcode$SCC.Level.Two, ignore.case=TRUE)
factors <- classcode[vehicle,]$SCC
pm25 <- pm25data[pm25data$SCC %in% factors,]
bc_df <- pm25 %>% subset(fips == "24510") %>% group_by(year,fips) %>% summarise(sum(Emissions))
lac_df <- pm25 %>% subset(fips == '06037') %>% group_by(year,fips) %>% summarise(sum(Emissions))
names(bc_df)[3] <- "Emissions"
names(lac_df)[3] <- "Emissions"
final_df <- rbind(bc_df, lac_df)
plot <- ggplot(data = final_df,aes(fill = fips,x = year,y = Emissions, xlab = "Year", ylab = "Total Emissions", main = "Total Emissions by Vehicles in Baltimore City")) + geom_bar(stat = "identity") + labs(fill = "Location") + scale_fill_discrete(labels = c("Los Angeles County", "Baltimore City")) + geom_line() + geom_point() +
  scale_x_discrete(limit=c(1999,2002,2005,2008))
print(plot)
ggsave("plot6.png",scale = 2)
