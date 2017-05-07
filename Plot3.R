#Setting work directory
setwd("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/Course5_Week1/Assignment_Course5_Week1")
getwd()
#We need only 1/2/2007 up to 2/2.2007
#on copying the file to excel the records that we need to work with are from record 66637 up to record 69516
#variables are 
#1. Date (dd/mm/yy)
#2. time (hh:mm:ss)
#3.Global_active_power: household global minute-averaged active power (in kilowatt)
#4. Global_reactive_power (in kilowatt)
#5.	Voltage (in volt)
#6.	Global_intensity(in ampere)
#7.	Sub_metering_1: (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#8.	Sub_metering_2: (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#9.	Sub_metering_3: (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#****We need to plot a histogram for the Global_active_power

#create a dataframe
df <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, sep = ";")
#get the names of the columns by reading first row
name <- sapply(read.table("household_power_consumption.txt", nrow = 1, sep = ";"), as.character)
#set the names of the elements in the data frame to the names of the columns

names(df) <- name
# change the format of date and time as required by professor in exercise
df$DateTime <- strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

#win.graph() is the name of the Windows graphics device.
#win.graph(width = 200, height = 200)
win.graph(200,200)

# plot date time against sub_metering_1
with(df, plot(DateTime, Sub_metering_1, 
              type = "n", 
              xlab = "Day Ttime", 
              ylab = "Energy sub metering" , 
              axes = F, 
              frame.plot=TRUE))
#Specify the x axis, Specify the points that the labels thu, fri, sat will be displyaed at
axis(1, at=c(as.numeric(min(df$DateTime)), as.numeric(min(df$DateTime))+86400
             , as.numeric(min(df$DateTime))+2*86400), labels=c("Thu", "Fri", "Sat"))
#Specify the y axis
axis(2, yaxs = "r")
#plotting date time vs sub metering_1 type is a line
with(df, points(DateTime, Sub_metering_1, type = "l"))

#plotting date time vs sub metering_2 type is a line and the color is red
with(df, points(DateTime, Sub_metering_2, type = "l", col = "red"))
#plotting date time vs sub metering_2 type is a line and the color is blue
with(df, points(DateTime, Sub_metering_3, type = "l", col = "blue"))

#specify the location of the legend top right
# colors is specified in a vector 
# legend is specified in a vecor listing the names of the variables
legend("topright", 
       pch = "¢w", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
