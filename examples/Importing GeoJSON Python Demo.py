# TITLE: Importing GeoJSON Example in Python
# AUTHOR: Tom Schenk Jr., City of Chicago
# CREATED: 2013-01-23
# UPDATED: N/A
# NOTES: Quick example to import GeoJSON data in Python. Assumed a Transverse Mercator projection.
# MODULES: json, geojson

import json
from pprint import pprint
json_data = open('U:\Open Source Data\Bike Routes\Bikeroutes3.json', 'r')
bike_routes = json.load(json_data)
bikeRoutes
bikeRoutes.readline()