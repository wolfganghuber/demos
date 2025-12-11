library("suncalc")
library("ggplot2")
library("dplyr")

# Heidelberg coordinates
lat = 49.38
lon = 8.71

# Generate dates for this year 
dates = seq(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day")

# Calculate sunrise and sunset times
suntimes = suncalc::getSunlightTimes(
  date = dates,
  lat = lat, lon = lon,
  tz = "Europe/Berlin"
)

# Extract hour of day as decimal (e.g., 6.5 = 6:30 AM)
hour = function(x) as.numeric(format(x, "%H")) + as.numeric(format(x, "%M")) / 60 + as.numeric(format(x, "%S")) / 3600

suntimes = mutate(suntimes, 
   sunriseHour = hour(sunrise),
   sunsetHour  = hour(sunset))

EarliestNight = slice_min(suntimes, sunsetHour)
LatestDay     = slice_max(suntimes, sunriseHour)

ggplot(suntimes, aes(x = sunriseHour, y = sunsetHour, label = format(date))) + 
  geom_point(col = "#b0b0b0") +
  geom_path(col = "lightblue") +
  geom_point(data = EarliestNight, col = "red") +
  geom_point(data = LatestDay, col = "red") +
  geom_text(data = EarliestNight, vjust = "top") +
  geom_text(data = LatestDay, hjust = "right") +
  xlab("Sunrise (hour)") + ylab("Sunset (hour)") +
  ggtitle("Sunrise vs Sunset Times in Heidelberg") 

ggsave("sunrise+set.png", width = 160, height = 160, units = "mm")