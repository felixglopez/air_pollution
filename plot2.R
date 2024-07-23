#question 2 - Have the PM2.5 emissions decreased in Baltimore City, Maryland?
library(tidyverse)

## Loading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


tot.emissions.baltimore <- NEI %>%
  subset(fips == "24510") %>%
  group_by(year) %>%
  summarize(Total.Emissions.Baltimore = sum(Emissions, 
                                            na.rm = TRUE))
#saving the plot
png (filename = "plot2.png", width=800, height = 600)

with(tot.emissions.baltimore, 
     plot(x = year, 
          y = Total.Emissions.Baltimore, 
          ylab = "Total Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in Baltimore by Year",
          cex = 2,
          pch = 1,
          col = "green",
          lwd = 3))


#closing the PNG device
dev.off()



