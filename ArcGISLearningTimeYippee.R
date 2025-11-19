kniss_wd <- function (repo, folder=NULL) {
  if(missing(folder))
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("/Users/sylviakniss/Documents/GitHub")} else ("for Linux run: setwd('/home/[INSERT YOUR USERNAME]/GitHub')")
    },"/",repo, sep = "")))}
  else 
    
  {
    setwd(print(paste(if (Sys.info()[["sysname"]]=="Windows") {("C:/GitHub")} else {
      if (Sys.info()[["sysname"]]=="Darwin"){("/Users/sylviakniss/Documents/GitHub")} else ("for Linux run: setwd('/home/[INSERT YOUR USERNAME]/GitHub')")
    },"/",repo, "/", folder, sep = "")))}
}


kniss_wd(repo = "knisssj")


# https://www.usgs.gov/publications/waterdata-r-package-retrieval-analysis-and-anomaly-calculation-daily-hydrologic-time
# https://doi-usgs.github.io/dataRetrieval/articles/read_waterdata_functions.html



# https://rdocumentation.org/packages/riverdist/versions/0.17.0
install.packages("riverdist")
library(riverdist)

# I need to import a shape file in the happy place to do anything with this package





# USGS tutorial ####
install.packages("ggplot2")
library(ggplot2)

sites_information <- read_waterdata_monitoring_location(monitoring_location_id = "USGS-01491000")
site_info <- read_waterdata_monitoring_location(monitoring_location_id = "USGS-01491000",properties = c("monitoring_location_id","site_type","drainage_area","monitoring_location_name"))

knitr::kable(site_info)
sites_wi <- read_waterdata_monitoring_location(state_name = "Wisconsin", site_type = "Stream")

ggplot(data = sites_wi) + geom_sf() + theme_minimal()


install.packages("leaflet")
library(leaflet)

leaflet_crs <- "+proj=longlat +datum=WGS84" #default leaflet crs

leaflet(data = sites_wi |> 
          sf::st_transform(crs = leaflet_crs)) |> 
  addProviderTiles("CartoDB.Positron") |> 
  addCircleMarkers(popup = ~monitoring_location_name, radius = 0.1, opacity = 1)

ts_available <- read_waterdata_ts_meta(monitoring_location_id = "USGS-01491000", parameter_code = c("00060", "00010"))

pcode_info <- read_waterdata_parameter_codes(parameter_code =  "00660")

daily_modern <- read_waterdata_daily(monitoring_location_id = "USGS-01491000",
                                     parameter_code = c("00060", "00010"),
                                     statistic_id = "00003",
                                     time = c("2023-10-01", "2024-09-30"))

library(ggplot2)

ggplot(data = daily_modern) +
  geom_point(aes(x = time, y = value, 
                 color = approval_status)) +
  facet_grid(parameter_code ~ ., scale = "free") +
  theme_bw()


field_modern <- read_waterdata_field_measurements(monitoring_location_id = c("USGS-451605097071701",                                                  "USGS-263819081585801"),
                                                  time = c("2023-10-01", "2024-09-30"))

ggplot(data = field_modern) +
  geom_point(aes(x = time, y = value)) +
  facet_grid(parameter_code ~ monitoring_location_id, scale = "free") +
  theme_bw()

site <- "USGS-01491000"
pcode <- "00060"
latest_uv_data <- read_waterdata_latest_continuous(monitoring_location_id = site,
                                                   parameter_code = pcode)

cql <- '{
  "op": "and",
  "args": [
    {
      "op": "in",
        "args": [
          { "property": "state_name" },
          [ "Wisconsin", "Minnesota" ]
        ]
    },
    {
      "op": ">",
        "args": [
          { "property": "drainage_area" },
          1000
        ]
    }
  ]
}'

sites_mn_wi <- read_waterdata(service = "monitoring-locations", 
                              CQL = cql)

leaflet_crs <- "+proj=longlat +datum=WGS84" #default leaflet crs

pal <- colorNumeric("viridis", sites_mn_wi$drainage_area)

leaflet(data = sites_mn_wi |> 
          sf::st_transform(crs = leaflet_crs)) |> 
  addProviderTiles("CartoDB.Positron") |> 
  addCircleMarkers(popup = ~monitoring_location_name, 
                   color = ~ pal(drainage_area),
                   radius = 0.1,
                   opacity = 1) |> 
  addLegend(pal = pal,
            position = "bottomleft",
            title = "Drainage Area",
            values = ~drainage_area)

# A wildcard in CQL2 is %
# Here's how to get HUCs that fall within 02070010
cql_huc_wildcard <- '{
"op": "like",
"args": [
  { "property": "hydrologic_unit_code" },
  "02070010%"
]
}'

what_huc_sites <- read_waterdata(service = "monitoring-locations",
                                 CQL = cql_huc_wildcard)


what_huc_sites$hydrologic_unit_code <- as.factor(what_huc_sites$hydrologic_unit_code)
pal <- colorFactor("viridis", what_huc_sites$hydrologic_unit_code)

leaflet(data = what_huc_sites |> 
          sf::st_transform(crs = leaflet_crs)) |> 
  addProviderTiles("CartoDB.Positron") |> 
  addCircleMarkers(popup = ~monitoring_location_name, 
                   color = ~ pal(hydrologic_unit_code),
                   radius = 0.1,
                   opacity = 1) 


# Terra thing ####
# https://www.r-bloggers.com/2024/10/comparison-of-spatial-patterns-in-continuous-raster-data-for-overlapping-regions-using-r/
install.packages("terra")
library(terra)
ndvi2018_tartu = rast("https://github.com/Nowosad/comparing-spatial-patterns-2024/raw/refs/heads/main/data/ndvi2018_tartu.tif")
ndvi2023_tartu = rast("https://github.com/Nowosad/comparing-spatial-patterns-2024/raw/refs/heads/main/data/ndvi2023_tartu.tif")
plot(ndvi2018_tartu, main = "Tartu (2000)")
plot(ndvi2023_tartu, main = "Tartu (2018)")

ndvi_diff = ndvi2023_tartu - ndvi2018_tartu
plot(ndvi_diff)

plot_div = function(r, ...){
  r_range = range(values(r), na.rm = TRUE, finite = TRUE)
  max_abs = max(abs(r_range))
  new_range = c(-max_abs, max_abs)
  plot(r, col = hcl.colors(100, palette = "prgn"), range = new_range, ...)
}
plot_div(ndvi_diff)

ndvi_diff = ndvi2023_tartu - ndvi2018_tartu
hist(ndvi_diff)

install.packages("yardstick")
library(yardstick)
ndvi_rmse = rmse_vec(values(ndvi2023_tartu)[, 1], values(ndvi2018_tartu)[, 1])
ndvi_rmse

install.packages("diffeR")
library(diffeR)
ndvi_mad = MAD(ndvi2023_tartu, ndvi2018_tartu)
ndvi_mad$Total

ndvi_cor = focalPairs(c(ndvi2023_tartu, ndvi2018_tartu), w = 5, fun = "pearson", na.rm = TRUE)
plot_div(ndvi_cor)

install.packages("geodiv")
library(geodiv)
window = matrix(1, nrow = 5, ncol = 5)
ndvi2018_tartu_sa_mw = focal_metrics(ndvi2018_tartu, window = window,
                                     metric = "sa", progress = FALSE)
ndvi2023_tartu_sa_mw = focal_metrics(ndvi2023_tartu, window = window,
                                     metric = "sa", progress = FALSE)
ndvi_diff_sa_mw = ndvi2023_tartu_sa_mw$sa - ndvi2018_tartu_sa_mw$sa
plot_div(ndvi_diff_sa_mw)

install.packages("rasterdiv")
library(rasterdiv)
ndvi2018_tartu_int = as.int(ndvi2018_tartu * 100)
ndvi2023_tartu_int = as.int(ndvi2023_tartu * 100)
ndvi2018_tartu_rao = paRao(ndvi2018_tartu_int, window = 5, progBar = FALSE)
ndvi2023_tartu_rao = paRao(ndvi2023_tartu_int, window = 5, progBar = FALSE)
ndvi_rao_diff = ndvi2023_tartu_rao[[1]][[1]] - ndvi2018_tartu_rao[[1]][[1]]
plot_div(ndvi_rao_diff)
ndvi_diff = ndvi2023_tartu - ndvi2018_tartu
ndvi_diff_autocor = autocor(ndvi_diff, method = "moran", global = FALSE)
plot_div(ndvi_diff, main = "Difference")
plot_div(ndvi_diff_autocor, main = "Moran's I of the difference")

install.packages("SSIMmap")
library(SSIMmap)
ndvi_ssim = ssim_raster(ndvi2018_tartu, ndvi2023_tartu, global = FALSE, w = 5)
plot_div(ndvi_ssim[[1]])

install.packages("waywiser")
library(waywiser)
cell_sizes = seq(50, 300, by = 50)
ndvi_multi_scale = ww_multi_scale(truth = ndvi2018_tartu, estimate = ndvi2023_tartu,
                                  metrics = list(yardstick::rmse), 
                                  cellsize = cell_sizes,
                                  progress = FALSE)
ndvi_multi_scale

library(diffeR)
ndvi_mad = MAD(ndvi2023_tartu, ndvi2018_tartu, eval = "multiple")
ndvi_mad

library(SSIMmap)
ssim_raster(ndvi2018_tartu, ndvi2023_tartu, global = TRUE)





