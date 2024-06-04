# OpenWeatherMap-wather-conky-master

conky with openWeatherMap API plus a compass to indicate wind direction and moon phases using perl

More info: https://drcalambre.blogspot.com/2023/09/conky-implementando-perl-para-las-fases.html

Although my blog is in Spanish, there is a language translator for a better understanding. 

Best regards 

;)

* * *
# **Update in 02/06/24**
**calculate if it is spring, summer, autumn or winter.**

## Description of the Script
GetStation.sh
This script calculates the current season (whether spring, summer, fall or winter) and the days remaining 
for the next season based on the current location.

Get Latitude: The script utilizes the ipinfo.io service to obtain the latitude of the user's current location.

Determine Hemisphere: 
Based on the obtained latitude, the script determines whether the user is in the northern or southern hemisphere.

Get Current Date: The script obtains the current date in the YYYY-MM-DD format.

Set Season Start Dates:

For the Northern Hemisphere:

Spring: March 21
Summer: June 21
Autumn: September 21
Winter: December 21

For the Southern Hemisphere:

Spring: September 21
Summer: December 21
Autumn: March 21
Winter: June 20

Calculate Current and Next Season: 
The script compares the current date with the season start dates to determine the current season and the next season.

Calculate Remaining Days for Next Season: 
The script calculates the number of days remaining until the start of the next season.
Determine Text for Remaining Days: Depending on the number of remaining days, the script generates 
appropriate text (e.g., "one day until" or "X days until").

Copy Season Icons: 
The script copies the corresponding icons for the current season and the next season to the user's temporary directory.

Show Results: Finally, the script displays the current season, the icon of the current season, the next season, the icon 
of the next season, and the text for the remaining days.


## Screenshots
![conky from my antiX desktop](screenshot/screenshot_conk_current_and_next_station.jpg)

![conky from my antiX desktop](screenshot/screenshot_conky.jpg)

The desktop wallpaper is a photograph of a sunset on one of my bicycle rides along the Rio Gallegos coastal (Argentina).
![conky from my antiX desktop](screenshot/screenshot_antix_rox-icewm_desktop.jpg
)


## The new icons for the stations:
![conky from my antiX desktop](screenshot/spring.png
![conky from my antiX desktop](screenshot/summer.png
![conky from my antiX desktop](screenshot/autumn.png
![conky from my antiX desktop](screenshot/winter.png
