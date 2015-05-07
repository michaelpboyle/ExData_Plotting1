######################################################################################################################
## Get Data
######################################################################################################################
#### Download files (Using wget method for Linux OS)
projUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(projUrl,destfile = "./proj1Data.zip",method="wget")
dateDownloaded <- date()
print(dateDownloaded)   ## Record download date

## Unzip (extract) files
unzip("./proj1Data.zip",list=FALSE)
######################################################################################################################

######################################################################################################################
## Read file.
hh_pwr_consump <- read.table("./household_power_consumption.txt",header=TRUE,na.strings="?",sep=";")
hh_pwr_consump$Date1 <- as.Date(hh_pwr_consump$Date,format="%d/%m/%Y")
hh_pwr_consump2 <- hh_pwr_consump[hh_pwr_consump$Date1 %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")),]
hh_pwr_consump2$DateTm <- strptime(paste(hh_pwr_consump2$Date,hh_pwr_consump2$Time),"%d/%m/%Y %H:%M:%S")

## Make plot
png("./plot3.png",width=480,height=480)
plot(hh_pwr_consump2$DateTm,hh_pwr_consump2$Sub_metering_3
    ,xlab=""
    ,ylab="Energy sub metering"
    ,ylim=c(0,38)
    ,type="n")
axis(2,at=c(0,10,20,30))
points(hh_pwr_consump2$DateTm,hh_pwr_consump2$Sub_metering_1,type="l",col="black")
points(hh_pwr_consump2$DateTm,hh_pwr_consump2$Sub_metering_2,type="l",col="red")
points(hh_pwr_consump2$DateTm,hh_pwr_consump2$Sub_metering_3,type="l",col="blue")
legend("topright",lty,lwd=1
      ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
      ,col=c("black","red","blue")
      )
dev.off()
