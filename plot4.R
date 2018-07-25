setwd("~/")

# to download a file
td = tempdir()
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tf = tempfile(tmpdir=td, fileext=".zip")
download.file(fileUrl1, tf)

# unzip the file and assign to a variable "mydata" for a specific date period 1-2 feb
unzip(tf, files=NULL, exdir="~/ExploDataAnal", overwrite=TRUE)

mydataheader<-read.table("~/ExploDataAnal/household_power_consumption.txt",header = TRUE,sep = ";",nrows = 1)

mydata<-read.table("~/ExploDataAnal/household_power_consumption.txt",header = FALSE,sep = ";",
                   stringsAsFactors = FALSE,skip = 66637,nrows = 24*60*2,col.names = colnames(mydataheader),na.strings = "?")

        mydata$DateTime<-as.POSIXct(paste(mydata$Date,mydata$Time),format="%d/%m/%Y %H:%M:%S")

# open png device and create a plot, export to the file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
        Sys.setlocale("LC_ALL", "English")
        par(mfrow = c(2, 2), mar = c(4, 4, 2, 1),lty=1,lwd=1,pch=0)       
        with(mydata,{
                plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
                plot(DateTime,Voltage,type="l",xlab="",ylab="Voltage")
                with(mydata,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
                        with(mydata,lines(DateTime,Sub_metering_1,col="black"))
                        with(mydata,lines(DateTime,Sub_metering_2,col="red"))
                        with(mydata,lines(DateTime,Sub_metering_3,col="blue"))
                        legend("topright", pch = "-", col = c("black","red","blue"), 
                                legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))  
                plot(DateTime,Global_reactive_power,type="l",xlab="",ylab="Global Reactive Power")
        })
dev.off()