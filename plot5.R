

#QUESTION 5
## LOADING THE DATASETS (NEED TO BE IN WORKING DIRECTORY)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#SAME MERGIN STRATEGY. Getting word via grep
vehicle.scc <- SCC[grep("[Vv]eh", SCC$Short.Name), ]

#subseting to baltimore and merging both datasets before calculating total emisions
emissions.motor.baltimore <- NEI %>% 
  subset(fips == "24510" & NEI$SCC %in% vehicle.scc$SCC) %>%
  merge(y = vehicle.scc, by.x = "SCC", by.y = "SCC") %>%
  group_by(year) %>%
  summarize(Vehicle.Emissions.Type = sum(Emissions, na.rm = TRUE))

emissions.motor.baltimore.2008 <- emissions.motor.baltimore[emissions.motor.baltimore$year  == 2008, 2]
emissions.motor.baltimore.1999 <- emissions.motor.baltimore[emissions.motor.baltimore$year  == 1999, 2]

variation.baltimore <- emissions.motor.baltimore.2008 - emissions.motor.baltimore.1999

#Answer: emission in baltimore decreased by 258 tons, from 1999 to 2008

#lets see it in a plot
plot5 <- ggplot(emissions.motor.baltimore, aes(year, Vehicle.Emissions.Type)) +
  geom_point(color = "blue", 
             size = 4) + 
  xlab("Year") +
  ylab("Total Emissions [Tons]") +
  ggtitle("Total Annual Vehicle Emissions in Baltimore City")

print(plot5)
#Yes, emissions from motor vehicle declined from 1999-2008 in Baltimore

#saving the plot5
ggsave(filename = "plot5.png", plot = plot5, width = 8, height = 6, units = "in", dpi = 300)


