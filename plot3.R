

#
# Exploratory Data Analysis - Week 1 - Project 1 - Plot 3
#
# May 11, 2020 - Inselbuch
#    new module

#rm(list=ls())

# load the data set
fn = "c:/users/frank.inselbuch/git/coursera/Data Exploration/Data/household_power_consumption.txt"

#
#  2,075,259 observations of 9 variables
#
# names(powerData)
# "Date"                  "Time"                  "Global_active_power"
# "Global_reactive_power" "Voltage"               "Global_intensity"
# "Sub_metering_1"        "Sub_metering_2"       
# "Sub_metering_3"  
#

# takes a while, so don't do it again and again
if (exists("powerData")) {
   print("Using cached data")
} else
   powerData <- read.table(fn,header=TRUE,sep=';',na.strings="?",stringsAsFactors=FALSE)



# subset the data to use only those two days
if (exists("twoDays")) {
   print("Using cached data")
} else {
   # create a timestamp with both the date and time
   powerData$Timestamp = strptime(paste(powerData$Date,powerData$Time,sep=" "),
   "%d/%m/%Y %H:%M:%S")

   # we only want data from 2007-02-01 and 2007-02-02
   start_time <- strptime("01/31/2007 23:59:59","%m/%d/%Y %H:%M:%S")
   end_time <- strptime("02/03/2007 0:00:00","%m/%d/%Y %H:%M:%S")
   twoDays <- subset(powerData,Timestamp>start_time & Timestamp < end_time)
}

par(mar=c(5,4,3,10))

with(twoDays, {
   plot(Timestamp,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=NA);
   points(Timestamp,Sub_metering_2,type="l",col="red");
   points(Timestamp,Sub_metering_3,type="l",col="blue")
}
)

legend("topright",col=c("black","red","blue"),
      legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      lty=1,text.width=strwidth("Sub_metering_2")*1.5)



# spurge it out as a png with the correct dimensions
dev.copy(png,file="plot3.png",width=480,height=480)

#close the png device
dev.off()