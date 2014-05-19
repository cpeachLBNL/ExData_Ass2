## Plot 4:  How have emissions from coal combustion sources in US changed from 1999 to 2008?
library(ggplot2)

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create filtered dataframe with year and emissions columns and sum emissions by year
SCC_Coal <- SCC[grep("Fuel Comb - .* - Coal", SCC$EI.Sector), "SCC"]
NEI_Coal <- NEI[NEI$SCC %in% SCC_Coal, ]
dfYearlyEmissions <- aggregate( x=list("Emissions"=NEI_Coal$Emissions), 
                                by=list("year"=NEI_Coal$year),
                                FUN = sum )

#Create plot and save as PNG file
png(filename = "plot4.png", width = 480, height = 480)
qplot(year, Emissions, data=dfYearlyEmissions, geom=c("point")) +
  geom_smooth(method='lm') + 
  ggtitle("Emissions from Coal Combustion Sources \nin United States from 1999 to 2008")

dev.off()