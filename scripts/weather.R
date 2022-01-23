# ==============================================================================
#
# weather.R
# Author: Carl Delfin
# License: MIT
# 
# ==============================================================================

if (!"jsonlite" %in% installed.packages()) {
  user_input <- readline("The R package jsonlite is required, do you wish to install? (y/n) ")
  if (user_input != "y") stop("Aborting")
  install.packages("jsonlite")
} else {
  
  bash_args <- commandArgs(trailingOnly = TRUE)
  gps_data <- jsonlite::fromJSON(paste0("https://geocode.xyz/", bash_args[1], "?json=1"))
  gps_coords <- paste0("lat=", round(as.numeric(gps_data$latt), 4), "&lon=", round(as.numeric(gps_data$longt), 4))
  weather_data <- jsonlite::fromJSON(paste0("https://api.met.no/weatherapi/locationforecast/2.0/complete?", gps_coords))
  instant_data <- weather_data$properties$timeseries$data$instant[1, ]
  next_1_hr_data <- weather_data$properties$timeseries$data$next_1_hours$details[1, ]
  next_6_hr_data <- weather_data$properties$timeseries$data$next_6_hours$details[1, ]

  cat(paste0(
    "---------------------------------------------------\n",
    "Weather report for ", bash_args[1], "\n",
    "---------------------------------------------------\n",
    "\033[0;1;33mTemperature:\033[37m                 ", instant_data$air_temperature, "° C\n",
    "\033[0;1;33mTemperature (in 6 hours):\033[37m    ", next_6_hr_data$air_temperature_min, "° to ", next_6_hr_data$air_temperature_max, "° C\n",
    "\033[0;1;33mPrecipitation (in 1 hour):\033[37m   ", next_1_hr_data$probability_of_precipitation, "% (", next_1_hr_data$precipitation_amount_min, " to ", next_1_hr_data$precipitation_amount_max, " mm)\n",
    "\033[0;1;33mPrecipitation (in 6 hours):\033[37m  ", next_6_hr_data$probability_of_precipitation, "% (", next_6_hr_data$precipitation_amount_min, " to ", next_6_hr_data$precipitation_amount_max, " mm)\n",
    "\033[0;1;33mWind speed:\033[37m                  ", instant_data$wind_speed, " m/s\n",
    "\033[0;1;33mWind direction:\033[37m              ", instant_data$wind_from_direction, "°\n",
    "\033[0;1;33mCloud coverage:\033[37m              ", instant_data$cloud_area_fraction, "%\n",
    "\033[0;1;33mFog coverage:\033[37m                ", instant_data$fog_area_fraction, "%\n",
    "\033[0;1;33mUV index:\033[37m                    ", instant_data$ultraviolet_index_clear_sky, "\n",
    "\033[0;1;33mHumidity:\033[37m                    ", instant_data$relative_humidity, "%\n",
    "\033[0;1;33mPressure:\033[37m                    ", instant_data$air_pressure_at_sea_level, " hPa\n",
    "---------------------------------------------------\n"))
}
