## Plot 6:  Which city (Baltimore vs L.A.) has greater change in emissions from motor vehicle sources from 1999 to 2008?
library(ggplot2)
library(scales)

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create filtered dataframe with year and emissions columns and sum emissions by year
dfCounties <- data.frame(fips=c("24510", "06037"), countyName=c("Baltimore City", "Los Angeles"))
NEI_Counties <- NEI[NEI$fips %in% dfCounties$fips, ]
SCC_MV <- SCC[grep(".*Veh.*", SCC$EI.Sector), "SCC"]
NEI_Counties_MV <- NEI_Counties[NEI_Counties$SCC %in% SCC_MV, ]
dfYearlyEmissions <- aggregate( x=list("Emissions"=NEI_Counties_MV$Emissions), 
                                by=list("year"=NEI_Counties_MV$year,  
                                        "fips"=NEI_Counties_MV$fips),
                                FUN = sum )

for (fips in dfCounties$fips) {
  #Calculate the percent change vs 1999 emission values for each county
  dfYearlyEmissions$Percent.Change[dfYearlyEmissions$fips==fips] <- 
    dfYearlyEmissions$Emissions[dfYearlyEmissions$fips==fips] / 
    dfYearlyEmissions$Emissions[(dfYearlyEmissions$fips==fips & dfYearlyEmissions$year=="1999")]
  #Add the real County Name
  dfYearlyEmissions$county[dfYearlyEmissions$fips==fips] <- as.character(dfCounties$countyName[dfCounties$fips==fips])
}

#Create plot and save as PNG file
png(filename = "plot6.png", width = 480, height = 480)
qplot(year, Percent.Change, data=dfYearlyEmissions, facets=.~county, geom=c("point")) +
  geom_smooth(method='lm') + 
  scale_y_continuous(labels=percent_format()) + 
  ggtitle("Percent Change in Emissions from Motor Vehicle Sources \nin Baltimore City and Los Angeles from 1999 to 2008")

dev.off()