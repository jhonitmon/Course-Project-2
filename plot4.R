library(dplyr)
library(ggplot2)

pm25data <- readRDS("./data/summarySCC_PM25.rds")
classcode <- readRDS("./data/Source_Classification_Code.rds")
comb <- grepl("comb", classcode$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", classcode$SCC.Level.Four, ignore.case=TRUE)
coal_comb <- (comb & coal)
factors <- classcode[coal_comb,]$SCC
pm25 <- pm25data[pm25data$SCC %in% factors,]
final_df <- pm25 %>% group_by(year) %>% summarise(sum(Emissions))
names(final_df)[2] <- "Emissions"
plot <- qplot(year, Emissions/1000, data = final_df, geom = c("point","line"), xlab = "Year", ylab = "Total Emissions (tons)", main = "Total Emissions by Coal Combustion-related Sources")
print(plot)
ggsave("plot4.png",scale = 2)
