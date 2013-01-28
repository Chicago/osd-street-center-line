README
======
The City of Chicago is releasing selected datasets from the [data portal](http://data.cityofchicago.org, 'Chicago Data Portal') under the MIT License (see below). This repository contains:
1. Data in a GeoJSON format.
2. Examples of importing data into R, Python, and Ruby.
3. Instructions to transform data from the data portal to data in the repository.

Working with GeoJSON Data
=========================
The data was released as a [GeoJSON](http://www.geojson.org/geojson-spec.html) file. Below are some simple instructions which will show you how to load GeoJSON in R, Python, and Ruby.

R
---
Find an example script [here](https://github.com/Chicago/osd-street-center-line/blob/master/examples/Importing%20GeoJSON%20R%20Demo.R, 'Importing GeoJSON data to R'). This example will import the data in R and create a couple of maps.

Instructions:
1. Install the "rgdal" library to let R read and translate the data from GeoJSON to a Shapefile. We will use "ggplot2" library to transform the spatial data frame to a regular data frame--and to make a map.
    ```r
    install.packages(c("rgdal","ggplot2"))
    ```
2. Load the libraries:
    ```r
    library(rgdal)
    library(rgdal)
    ```
3. Import data to a spatial dataframe. City data is typically created using the transverse Mercator projection.
    ```r
    ogrInfo("U:\\Open Source Data\\Bike Routes\\Bikeroutes3.json", layer="OGRGeoJSON")
    bikes.shapefile <- readOGR(dsn="U:\\Open Source Data\\Bike Routes\\Bikeroutes3.json", layer="OGRGeoJSON", p4s="+proj=tmerc +ellps=WGS84")
    ```
4. Ensure the map works:
    ```r
    plot(bikes.shapefile)
    ```
5. Lets convert the spatial dataframe to a typical dataframe.
    ```r
    bikes.table <- fortify(bikes.shapefile)
    ```
6. Review the new dataframe.
    ```r
    head(bikes.table)
    ```
7. Plot the data.
    ```r
    ggplot(bikes.table, aes(x=long, y=lat, group=group)) + geom_path()
    ```
Here is the output you should expect from the plot() command:
![plot(transportation.shapefile)](https://github.com/Chicago/osd-street-center-line/blob/master/examples/R-plot-street-center-lines.png)
Here is the outout you should expect from the ggplot() command:
![ggplot(transportation.df, aes(x=long, y=lat, group=group))+geom_path()](https://github.com/Chicago/osd-street-center-line/blob/master/examples/R-ggplot-street-center-lines.png)
    
Python
------
Find an example script [here](https://github.com/Chicago/osd-street-center-line/blob/master/examples/Importing%20GeoJSON%20Python%20Demo.py, 'Importing GeoJSON data to Python Demo').

1. Load the necessary json and pprint libraries.
	```python
	import json
	from pprint import pprint
	```
2. Open GeoJSON data file.
	```python
	transportation_json = open('PATH\TO\osd-street-center-line\data\Transportation.json', 'r')
	```
3. Load GeoJSON file.
	```python
	transportation = json.load(transportation_json)
	```
4. Check first few lines of data (repeat this command several times).
	```python
	transportation.readline()
	```
5. Close the open GeoJSON file.
	```python
	json.close(transportation_json)
	```

Ruby
----


Differences between data portal and this repository
===================================================
Though the data in this repository is also available on Chicago's data portal, the data in this repository is different in several ways. First, the data within this repository is released under the MIT License. Second, this data has been edited to remove internal codes which do not provide useful information. Third, after changes were made to the dataset, the original shapefile was converted to GeoJSON using [GDAL's](http://www.gdal.org/, 'Geospatial Data Abstraction Library') [ogr2ogr](http://www.gdal.org/ogr2ogr.html)

The folder "Transformations" contains the necessary code to transform data on the portal to the release in this repository.

License
=======
This data is released under the [MIT License](http://opensource.org/licenses/MIT, 'MIT License'). See LICENSE.txt.