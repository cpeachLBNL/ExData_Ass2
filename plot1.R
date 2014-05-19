## Plot 1:  Have Total Emissions Decreased in US from 1999 to 2008?

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")

#Create dataframe with year and Emissions columns and sum emissions by year
dfYearlyEmissions <- aggregate( x=list("Emissions"=NEI$Emissions), 
                                by=list("year"=NEI$year),
                                FUN = sum )

#Create plot and save as PNG file
png(filename = "plot1.png", width = 480, height = 480)
plot (dfYearlyEmissions$year, dfYearlyEmissions$Emissions, type="p", col="blue", pch=19,
      main="Total Emissions in United States\nfrom 1999 to 2008",
      xlab="Year", 
      ylab=expression("Total Emissions from PM"[2.5]))

#Fit a linear regression line to this data, to show trend
model <- lm(Emissions~year, dfYearlyEmissions) 
abline(model, lwd = 2, col="red")  #plot line onto same plot
dev.off()