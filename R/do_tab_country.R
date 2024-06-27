do_tab_country <- function(
    indat,
    country
){
# Filter the input data for the specified country  
foo <- indat[GeoAreaName == country]

# Select specific columns from the filtered data
foo14 <- foo[, .(Indicator,
                 SeriesDescription,
                 TimePeriod,
                 Source)]

# Convert TimePeriod column to numeric for easier calculations
foo14[, NumericTimePeriod := as.numeric(TimePeriod)]

# Calculate min and max year for each SeriesDescription using TimePeriod
time_ranges <- foo14[, .(
  StartYear = min(NumericTimePeriod, na.rm = TRUE),
  EndYear = max(NumericTimePeriod, na.rm = TRUE)
), by = SeriesDescription]

# Create a time range string (e.g., "2000-2020" or "2000" if start and end year are the same)
time_ranges[, TimeRange := ifelse(StartYear == EndYear, as.character(StartYear), paste(StartYear, EndYear, sep = "-"))]

# Merge the new time range back to the main data.table
foo14 <- merge(foo14, time_ranges, by = "SeriesDescription", all.x = TRUE)

# Drop temporary columns that are no longer needed
foo14[, NumericTimePeriod := NULL]
foo14[, StartYear := NULL]
foo14[, EndYear := NULL]
foo14[, TimePeriod := NULL]

# Keep unique rows based on SeriesDescription
unq <- unique(foo14, by = "SeriesDescription")

# Select the final columns to include in the output
unq <- unq[, .(Indicator, SeriesDescription, TimeRange, Source)]

# Define the output file name based on the country
out_name <- paste0("figures_and_tables/", country, "_SDG_14.csv")

# Write the data to a CSV file
fwrite(unq, out_name)

return(unq)
}