## Plot 5:  How have emissions from motor vehicle sources in Baltimore City changed from 1999 to 2008?
library(ggplot2)

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create filtered dataframe with year and emissions columns and sum emissions by year
NEI_Baltimore <- NEI[NEI$fips == "24510", ]
SCC_MV <- SCC[grep(".*Veh.*", SCC$EI.Sector), "SCC"]
NEI_Baltimore_MV <- NEI_Baltimore[NEI_Baltimore$SCC %in% SCC_MV, ]
dfYearlyEmissions <- aggregate( x=list("Emissions"=NEI_Baltimore_MV$Emissions), 
                                by=list("year"=NEI_Baltimore_MV$year),
                                FUN = sum )

#Create plot and save as PNG file
png(filename = "plot5.png", width = 480, height = 480)
qplot(year, Emissions, data=dfYearlyEmissions, geom=c("point")) +
  geom_smooth(method='lm') + 
  ggtitle("Emissions from Motor Vehicle Sources \nin Baltimore City from 1999 to 2008")

dev.off()