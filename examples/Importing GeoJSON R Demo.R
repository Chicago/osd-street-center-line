# TITLE: Importing GeoJSON Example in R
# AUTHOR: Tom Schenk Jr., City of Chicago
# CREATED: 2013-01-23
# UPDATED: 2013-01-31
# NOTES: Caution! The street centerline data is quite large and may take a long time to complete.
# LIBRARIES: rgdal, ggplot2

# Set working directory (e.g., "C:\\Users\\username\\downloads" or "~/downloads")
setwd("path\\to\\folder")

# Install and load libraries
## If you need to install the RGDAL and GGPLOT2 libraries, complete this step first, otherwise, skip:
install.packages(c("rgdal", "ggplot2"))

library(rgdal)	# Import data into a Spatial Data Frame in R
library(ggplot2)	# Transform data from Shapefile to Data Frame

# Import data to Spatial Dataframe	
ogrInfo("data\\Transportation.json", layer="OGRGeoJSON") # Checks projection type for readOGR(), number of rows (55747) and fields (44). Replace PATH\\TO with actual file path (e.g., C:\\Users\\username\\downloads)

transportation.shapefile <- readOGR(dsn="data\\Transportation.json", layer="OGRGeoJSON", p4s="+proj=tmerc +ellps=WGS84") # Imports data. Replace PATH\\TO with actual file path (e.g., C:\\Users\\username\\downloads)

head(transportation.shapefile) # Inspect the data structure.

plot(transportation.shapefile) # Test plot of spatial data frame.

# Fortify data to translate to Data Frame
transportation.df <- fortify(transportation.shapefile) # Caution, this is very memory intensive and may take several hours to complete

head(transportation.df) # Inspect the data structure

ggplot(transportation.df, aes(x=long, y=lat, group=group)) + geom_path() # Test plot of data frame.