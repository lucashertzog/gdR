do_tab_country <- function(
    indat,
    country
){
  
foo <- indat[GeoAreaName == country]

foo14 <- foo[, .(Indicator,
                 SeriesDescription,
                 TimePeriod,
                 Source)]

foo14[, NumericTimePeriod := as.numeric(TimePeriod)]

# Calculate min and max year for each SeriesDescription using TimePeriod
time_ranges <- foo14[, .(
  StartYear = min(NumericTimePeriod, na.rm = TRUE),
  EndYear = max(NumericTimePeriod, na.rm = TRUE)
), by = SeriesDescription]

# Create a time range string
time_ranges[, TimeRange := ifelse(StartYear == EndYear, as.character(StartYear), paste(StartYear, EndYear, sep = "-"))]

# Merge the new time range back to the main data.table
foo14 <- merge(foo14, time_ranges, by = "SeriesDescription", all.x = TRUE)

# Drop the temporary column
foo14[, NumericTimePeriod := NULL]
foo14[, StartYear := NULL]
foo14[, EndYear := NULL]
foo14[, TimePeriod := NULL]

unq <- unique(foo14, by = "SeriesDescription")

unq <- unq[, .(Indicator, SeriesDescription, TimeRange, Source)]

out_name <- paste0("data_derived/", country, "_SDG_14.csv")
fwrite(unq, out_name)

return(unq)
}