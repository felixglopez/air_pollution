#question 2 - Have the PM2.5 emissions decreased in Baltimore City, Maryland?
library(tidyverse)

## Loading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


total_emissions_baltimore <- NEI |>
  filter(fips == '24510') |> 
  group_by(year) |> 
  summarize(total_emissions_baltimore = sum(Emissions, na.rm=TRUE))

head(total_emissions_baltimore)

plot2 <- ggplot(data=total_emissions_baltimore, aes(x=year, y=total_emissions_baltimore))+
  geom_line(linetype='dashed', size=1, col='black')+
  labs(title = "Total Annual Emissions in Baltimore", y = "Total Annual Emissions [Tons]", x = "Year")+
  theme_classic()

#plot shows a (non-linear) decrease in total emissions in Baltimore City from 1999 to 2008
print(plot2)

#saving the plot2
ggsave(filename = "plot2.png", plot = plot2, width = 8, height = 6, units = "in", dpi = 300)


