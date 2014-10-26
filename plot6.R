#check if the variable already exists
if (!"NEI" %in% ls()){
        NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()){
        SCC <- readRDS("./data/Source_Classification_Code.rds")
}
baltimoreLA <- NEI[NEI$fips == "24510" | NEI$fips == "06047", ]
library(ggplot2)

png(filename = "plot6.png", width = 480, height = 480, units = "px")
vehicle <- grep("motor", SCC$Short.Name, ignore.case = T)
vehicle <- SCC[vehicle, ]
vehicle <- baltimoreLA[baltimoreLA$SCC %in% vehicle$SCC, ]

g <- ggplot(vehicle, aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y = "sum") + 
        ylab("Total emissions") + ggtitle("Total emissions' comparission between Baltimore and LA") +
        scale_colour_discrete(name ="City", label = c("Los Angeles", "Baltimore"))

dev.off()
