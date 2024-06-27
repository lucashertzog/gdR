do_plot <- function(){

  # Subset the data to only include rows where the Indicator is "14.7.1"
  sdg1471 <- indat[Indicator=="14.7.1"]
  
  # Order the subsetted data by GeoAreaName in ascending order
  sdg1471 <- sdg1471[order(sdg1471$GeoAreaName, decreasing = FALSE)]
  
  # Display the unique GeoAreaNames in the subsetted and ordered data
  unique(sdg1471$GeoAreaName)
  
  # Further subset the data to only include rows where the GeoAreaName is "Indonesia"
  sdg1471_ind <- sdg1471[GeoAreaName=="Indonesia"]
  
  # Let's make a simple plot using base R
  plot(
    sdg1471_ind$TimePeriod,
    sdg1471_ind$Value
  )
  
  # Some improvements: 
  # type = "l"
  # col = "blue"
  # lwd = 2
  # main = "Sustainable Fisheries as a proportion of GDP in Indonesia"
  # xlab = "Year"
  # ylab = "(%)"
  
  # Comparing Indonesia with other countries, subsetting first
  sdg1471_comp <- sdg1471[GeoAreaName %in% c("Indonesia", "Malaysia", "Cook Islands")]

  # Create the plot using ggplot2
  ggplot(sdg1471_comp, 
         aes(x = TimePeriod, y = Value, color = GeoAreaName, group = GeoAreaName)) +
    geom_line(size = 1.2) +
    labs(title = "Sustainable Fisheries as a proportion of GDP",
         x = "Year",
         y = "(%)",
         color = "Country") +
    theme_minimal()
  
  # Include world averages for comparison
  sdg1471_comp_two <- sdg1471[GeoAreaName %in% c("Indonesia", "Malaysia", "Cook Islands", "World")]
  
  # Create the plot using ggplot2
 p <-  ggplot(sdg1471_comp_two, 
         aes(x = TimePeriod, y = Value, color = GeoAreaName, group = GeoAreaName)) +
    geom_line(size = 1.2) +
    labs(title = "Sustainable Fisheries as a proportion of GDP (including World average)",
         x = "Year",
         y = "(%)",
         color = "Country") +
    theme_minimal()
 
 ggsave("figures_and_tables/fig_plot.png", plot = p, width = 10, height = 6, dpi = 300, units = "in")
  
return(p)
}