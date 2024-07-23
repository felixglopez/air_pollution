#QUESTION 4
## LOADING THE DATASETS (NEED TO BE IN WORKING DIRECTORY)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#assigning a vector to identify coal originated energy
SCC.coal.comb <- SCC[grep("[Cc]oal",SCC$EI.Sector),]

#merging the variable filtered with the NEI dataset
NEI.sub.coal <- subset(NEI, 
                       NEI$SCC %in% SCC.coal.comb$SCC)


NEI.coal.comb <- merge(x = NEI.sub.coal, 
                       y = SCC, 
                       by.x = "SCC", 
                       by.y = "SCC")

#calculating total PM25 emissions from coal
NEI.coal.comb.tot <- NEI.coal.comb %>% 
  group_by(year) %>%
  summarize(Total.Coal.Comb = sum(Emissions, na.rm = TRUE))

head(NEI.coal.comb.tot)

NEI.coal.comb.plot <- ggplot(NEI.coal.comb.tot, aes(year, Total.Coal.Comb))

plot4 <- NEI.coal.comb.plot + 
  geom_point(color = "black", 
             size = 4) + 
  xlab("Year") +
  ylab("Total Emissions [Tons]") +
  ggtitle("Total Annual Coal Combustion Emissions in the US")


plot4
#saving the plot 4
ggsave(filename = "plot4.png", plot = plot4, width = 8, height = 6, units = "in", dpi = 300)
