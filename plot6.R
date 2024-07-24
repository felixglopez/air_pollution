#QUESTION 6 

## LOADING THE DATASETS (NEED TO BE IN WORKING DIRECTORY)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#getting vector with emissions by motor vehicles via grep
vehicle.scc <- SCC[grep("[Vv]eh", SCC$Short.Name), ]

#subeting and merging the datasets
emissions.motor.la <- NEI %>% 
  subset(fips == "06037" & NEI$SCC %in% vehicle.scc$SCC) %>%
  merge(y = vehicle.scc, by.x = "SCC", by.y = "SCC") %>%
  group_by(year) %>%
  summarize(Vehicle.Emissions.Type = sum(Emissions, na.rm = TRUE))

#emisions in baltimore and LA
emissions.motor.baltimore2 <- cbind(emissions.motor.baltimore, "City" = rep("Baltimore", 4))
emissions.motor.la2 <- cbind(emissions.motor.la, "City" = rep("LA", 4))

#binding LA and BA data into a single dataset
emissions.motor.comp <- rbind(emissions.motor.baltimore2, emissions.motor.la2)

#creating plot 6
plot6 <- ggplot(emissions.motor.comp, aes(year, Vehicle.Emissions.Type, col = City)) +
  geom_point(size = 4) +
  xlab("Year") +
  ylab("Total Emissions [Tons]") +
  ggtitle("Comparison of Total Annual Vehicle Emissions in Baltimore and Los Angeles")

#clearly the emissions in LA is higher than in Baltimore
#
print(plot6)
ggsave(filename ="plot6.png", plot=plot6, width = 8, height=6, units = "in", dpi = 300)

#showing the difference in numbers
#calculating emissions in both cities in the extreme years
emissions.motor.la.2008 <- emissions.motor.la[emissions.motor.la$year  == 2008, 2]
emissions.motor.la.1999 <- emissions.motor.la[emissions.motor.la$year  == 1999, 2]
emissions.motor.ba.2008 <- emissions.motor.baltimore[emissions.motor.baltimore$year  == 2008, 2]
emissions.motor.ba.1999 <- emissions.motor.baltimore[emissions.motor.baltimore$year  == 1999, 2]


#showing the variation
#LA emissions *increased* by 163 tons
delta.la <- emissions.motor.la.2008 - emissions.motor.la.1999 
#Baltimore emissions *decreased* by 258 tons
delta.baltimore <- emissions.motor.ba.2008- emissions.motor.ba.1999
abs(delta.la) > abs(delta.baltimore)
#answer: Baltimore observed biggest variation over time.