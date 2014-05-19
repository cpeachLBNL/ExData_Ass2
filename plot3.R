## Plot 3:  Which of the 4 sources of emissions have Decreased in Baltimore City from 1999 to 2008?
library(ggplot2)

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")

#Create filtered dataframe with year and emissions columns and sum emissions by year
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
dfYearlyEmissionsByType <- aggregate( x=list("Emissions"=NEI_Baltimore$Emissions), 
                                      by=NEI_Baltimore[,c("year", "type")],
                                      FUN = sum )

#Create plot and save as PNG file
png(filename = "plot3.png", width = 480, height = 480)
qplot(year, Emissions, data=dfYearlyEmissionsByType, facets=.~type, geom=c("point")) +
  geom_smooth(method='lm') + 
  ggtitle("Total Emissions by Type in Baltimore City from 1999 to 2008")

dev.off()