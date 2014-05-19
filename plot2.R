## Plot 2:  Have Total Emissions Decreased in Baltimore City from 1999 to 2008?

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")

#Create filtered dataframe with year and Emissions columns and sum emissions by year
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
dfYearlyEmissions <- aggregate( x=list("Emissions"=NEI_Baltimore$Emissions), 
                                      by=list("year"=NEI_Baltimore$year),
                                      FUN = sum )

#Create plot and save as PNG file
png(filename = "plot2.png", width = 480, height = 480)
plot (dfYearlyEmissions$year, dfYearlyEmissions$Emissions, type="p", col="blue", pch=19,
      main="Total Emissions in Baltimore City\nfrom 1999 to 2008",
      xlab="Year", 
      ylab=expression("Total Emissions from PM"[2.5]))

#Fit a linear regression line to this data, to show trend
model <- lm(Emissions~year, dfYearlyEmissions) 
abline(model, lwd = 2, col="red")  #plot line onto same plot
dev.off()