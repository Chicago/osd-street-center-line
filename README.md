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
1. Set the working directory to the location of the downloaded repository.
```r
setwd("path\\to\\folder")
```
2. Install the "rgdal" library to let R read and translate the data from GeoJSON to a Shapefile. We will use "ggplot2" library to transform the spatial data frame to a regular data frame--and to make a map.
    ```r
    install.packages(c("rgdal","ggplot2"))
    ```
3. Load the libraries:
    ```r
    library(rgdal)
    library(ggplot2)
    ```
4. Import data to a spatial dataframe. City data is typically created using the transverse Mercator projection.
    ```r
    ogrInfo("data\\Transportation.json", layer="OGRGeoJSON")
    transportation.shapefile <- readOGR(dsn="data\\Transportation.json", layer="OGRGeoJSON", p4s="+proj=tmerc +ellps=WGS84")
    ```
5. Ensure the map works:
    ```r
    plot(bikes.shapefile)
    ```
6. Lets convert the spatial dataframe to a typical dataframe.
    ```r
    transportation.table <- fortify(transportation.shapefile)
    ```
7. Review the new dataframe.
    ```r
    head(transportation.table)
    ```
8. Plot the data.
    ```r
    ggplot(transportation.table, aes(x=long, y=lat, group=group)) + geom_path()
    ```
Here is the output you should expect from the plot() command:
![plot(transportation.shapefile)](/examples/R-plot-street-center-lines.png)
Here is the outout you should expect from the ggplot() command:
![ggplot(transportation.df, aes(x=long, y=lat, group=group))+geom_path()](/examples/R-ggplot-street-center-lines.png)
    
Python
------
Find an example script [here](https://github.com/Chicago/osd-street-center-line/blob/master/examples/Importing%20GeoJSON%20Python%20Demo.py, 'Importing GeoJSON data to Python Demo').

1. Load the necessary json and pprint libraries.
	```python
	import json
	```
2. Open GeoJSON data file.
	```python
	transportation_json = open('PATH/TO/osd-street-center-line/data/Transportation.json', 'r')
	```
3. Check first few lines of data (repeat this command several times)
    ```python
    transportation.readline()
    ```
4. Load GeoJSON file.
	```python
	transportation = json.load(transportation_json)
	```
5. Close the open GeoJSON file.
	```python
	json.close(transportation_json)
	```

Ruby
----

An example ruby script is provided to show loading GeoJSON and running spatial analysis using the RGeo suite. A simple Gemfile is provided to make getting the dependencies and using them easy.

        $ cd PATH/TO/osd-street-center-line/examples/ruby
        $ bundle
        $ ruby example.rb

This example script filters the `Transportation.json` to street segments within a 500ft buffer of 50 W Washington.


Differences between data portal and this repository
===================================================
Though the data in this repository is also available on Chicago's data portal, the data in this repository is different in several ways. First, the data within this repository is released under the MIT License. Second, this data has been edited to remove internal codes which do not provide useful information. Third, after changes were made to the dataset, the original shapefile was converted to GeoJSON using [GDAL's](http://www.gdal.org/, 'Geospatial Data Abstraction Library') [ogr2ogr](http://www.gdal.org/ogr2ogr.html)

The translation from portal to repository involves several steps. First, the original DBF file is transformed using OpenRefine to elminate unhelpful columns and clean data. The "Transformatons" folder contains the corresponding JSON, which contains the detailed list of changes made to the original table.

The resulting shapefile is then translated to GeoJSON using the ogr2ogr from the GDAL application. The transformation is completed in the command prompt:
```bat
ogr2ogr -f "GeoJSON" Transortation_ogr.json /path/to/portal/data/Transportation.shp
```
Unfortunately, ogr2ogr outputs in machine, but not human-readable files. We use Python's simplejson.tool to transform the data to the final JSON file.
```bat
type Transportation_ogr.json | python -m simplejson.tool > Transportation.json
```

The folder "Transformations" contains the necessary code to transform data on the portal to the release in this repository.

License
=======
This data is released under the [MIT License](http://opensource.org/licenses/MIT, 'MIT License'). See LICENSE.txt.