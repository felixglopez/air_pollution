#question 3 - Increases and decreases in emissions by type, in Baltimore.

## Loading the files (files must be in working directory)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_emission_type <- NEI |> 
  filter(fips=='24510') |> 
  group_by(year, type) |> 
  summarize(total_type = sum(Emissions, na.rm=TRUE))

head(total_emission_type, n=20)

plot3 <- ggplot(data=total_emission_type, aes(x=year, y=total_type, col=type))+
  geom_line(color = 'blue', size = 1, alpha = 1/3)+
  facet_grid(.~type)+
labs(title = "PM2.5 Emissions in Baltimore City, by type", y = "Total emissions", x = "year")

#observed decrease in the following types: nonpoint, non-road and on-road. Increase in type "point"
print(plot3)

#saving the plot
ggsave(filename = "plot3.png", plot = plot3, width = 8, height = 6, units = "in", dpi = 300)


