# The R script is a result from the assignment for Week 1 in the Module Exploratory Data Analysis

# The script uses data from the UC Irvine Machine Learning Repository. In particular, 
# the "Individual household electric power consumption Data Set" is used

# Description: Measurements of electric power consumption in one household with a one-minute 
# sampling rate over a period of almost 4 years. Different electrical quantities and some 
# sub-metering values are available.

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:

# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to 
# the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to 
# the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to 
# an electric water-heater and an air-conditioner.

# Step 1: Reading the Data set

# Setting the working directory for the file and load library

library(datasets)
setwd("~/Datasciencecoursera/Module 4 Exploratory Data Analysis/exdata_data_household_power_consumption")

# Reading the household data file

household_df <- read.table("household_power_consumption.txt",  sep = ";", quote="", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# remove the NA's

household_df <- household_df[!is.na(household_df[,"Sub_metering_1"]),]
household_df <- household_df[!is.na(household_df[,"Sub_metering_2"]),]
household_df <- household_df[!is.na(household_df[,"Sub_metering_3"]),]

# converting the date of the measurement which was in the file as 'day/month/year with four digits'

household_df[,"Date"] <- as.Date(household_df[,"Date"], "%d/%m/%Y")

# make variables for the dates between which the data has to be shown

day1 <- as.Date("2007-02-01", "%Y-%m-%d")
day2 <- as.Date("2007-02-02", "%Y-%m-%d")

# Make a time series as a basis for the x axis in the plot

presentation_data <- household_df[((household_df[,"Date"]== day1) | (household_df[,"Date"]== day2)), c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

presentation_data[,"Date_time_object"] <- paste(presentation_data[,"Date"], presentation_data[,"Time"])

time_object_string <- strptime(presentation_data[,"Date_time_object"], format = "%Y-%m-%d %H:%M:%S")

plot(time_object_string, presentation_data[, "Sub_metering_1"], pch=".", ylab="Energy Sub Metering", xlab= " ",  lwd=1)

lines(time_object_string, presentation_data[, "Sub_metering_1"])
lines(time_object_string, presentation_data[, "Sub_metering_2"], col = "red")
lines(time_object_string, presentation_data[, "Sub_metering_3"], col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= c(1,1,1), col = c("black", "red", "blue"), lwd= c(1,1,1))

dev.copy(png, "plot3.png")
dev.off()

