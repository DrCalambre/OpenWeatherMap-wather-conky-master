#!/bin/bash

# -------------------------------------------------------------------
# File: openWeatherMap-weather.sh
# Type: Bash Shell Script
# By Julio Alberto Lascano http://drcalambre.blogspot.com/
#________          _________        .__                ___.                  
#\______ \_______  \_   ___ \_____  |  | _____    _____\_ |_________   ____  
# |    |  \_  __ \ /    \  \/\__  \ |  | \__  \  /     \| __ \_  __ \_/ __ \ 
# |    `   \  | \/ \     \____/ __ \|  |__/ __ \|  Y Y  \ \_\ \  | \/\  ___/ 
#/_______  /__|     \______  (____  /____(____  /__|_|  /___  /__|    \___  >
#        \/                \/     \/          \/      \/    \/            \/ 
#
# Last modified:2022-09-15
# -------------------------------------------------------------------
# RGL : Rio Gallegos city, Argentina lat= -51.6226&lon=-69.2181
# To get information in JSON format: https://openweathermap.org/current#current_JSON
# For help: https://openweathermap.org/current#parameter
# -------------------------------------------------------------------
# 5 day weather forecast: https://openweathermap.org/forecast5
# You can search weather forecast for 5 days with data every 3 hours by geographic coordinates. 
# All weather data can be obtained in JSON and XML formats.
# [cnt]	optional A number of days, which will be returned in the API response (from 1 to 16)
# Example of API call: http://api.openweathermap.org/data/2.5/forecast/daily?q=London&cnt=3&appid={API key}
# -------------------------------------------------------------------
# API call
# api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key} 
# https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
# -------------------------------------------------------------------------------------------------------------------------
# get the {lat}{lon} coordinates from https://openweathermap.org/ corresponding to your location and replace as appropriate
# in the same way you will have to do it with the {API key} that you will obtain after registering.
# -------------------------------------------------------------------------------------------------------------------------
# Current Weather
urlweather="https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&units=metric&lang=es"
# Extended forecast Weather
urlforecast="api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&cnt=3&appid={API key}&units=metric&lang=es"

curl ${urlweather} -s -o ~/.cache/openweathermap.json
curl ${urlforecast} -s -o ~/.cache/openweathermap-forecast.json
