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

tot.emissions.year <- NEI |> 
  group_by(year) |> 
  summarize(total_emissions = sum(Emissions, na.rm=TRUE))

head(tot.emissions.year)

#emission dropped from 7.3 ton to 3.5 ton.

png (filename = "plot1.png", width=800, height = 600)

#creating the plot1
with(tot.emissions.year, # plot data 
     plot(x = year, 
          y = total_emissions, 
          ylab = "Total Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in the US by Year",
          cex = 2,
          pch = 2,
          col = "red",
          lwd = 3))

#closing the PNG device
dev.off()
