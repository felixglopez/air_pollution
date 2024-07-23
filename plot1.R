setwd("~/OneDrive/IPEA/licenca capacitacao 2024/Data Science Specialization/files/exdata_data_NEI_data")
library(tidyverse)

#QUESTION 1

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
str(NEI)
range(NEI$year)
summary(NEI$Emissions, na.rm=TRUE)
mean(is.na(NEI$Emissions))

View(SCC)

#question 1
plot(NEI$Emissions)

total_emissions_year <- NEI |> 
  group_by(year) |> 
  summarize(total_emissions = sum(Emissions, na.rm=TRUE))

head(total_emissions_year)

#emission dropped from 7.3 ton to 3.5 ton.


plot1 <- ggplot(data=total_emissions_year, aes(x=year, y=total_emissions))+
  geom_point(pch=0, size=5, col='blue')+
  labs(title = "Total Annual Emissions in the US by Year", y = "Total Annual Emissions [Tons]", x = "Year")+
  theme_classic()

#saving the plot1
ggsave(filename = "plot1.png", plot = plot1, width = 8, height = 6, units = "in", dpi = 300)
