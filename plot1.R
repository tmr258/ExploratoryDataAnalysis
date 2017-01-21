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

household_df <- household_df[!is.na(household_df[,"Global_active_power"]),]

# converting the date of the measurement which was in the file as 'day/month/year with four digits'

household_df[,"Date"] <- as.Date(household_df[,"Date"], "%d/%m/%Y")

# make variables for the dates between which the data has to be shown

day1 <- as.Date("2007-02-01", "%Y-%m-%d")
day2 <- as.Date("2007-02-02", "%Y-%m-%d")

# Select the row for the correct date (as specified in the assignment)

presentation_data <- household_df[((household_df[,"Date"]== day1) | (household_df[,"Date"]== day2)),"Global_active_power"]

# Generate the histogram with the correct labels and in color red

hist(presentation_data, col= "red", main= "Global Active Power", xlab="Global Active Power (kilowatts)")

# copy to a PNG file and close the handle

dev.copy(png, "plot1.png")
dev.off()

