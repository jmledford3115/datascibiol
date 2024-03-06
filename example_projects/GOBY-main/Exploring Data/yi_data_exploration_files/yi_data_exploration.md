---
title: "Yukari's Data Exploring"
output: 
  html_document: 
    keep_md: yes
date: "2023-02-26"
---



Libraries

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
## ✔ ggplot2 3.4.0      ✔ purrr   1.0.0 
## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
## ✔ tidyr   1.2.1      ✔ stringr 1.5.0 
## ✔ readr   2.1.3      ✔ forcats 0.5.2 
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(naniar)
library(janitor)
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

```r
library(here)
```

```
## here() starts at C:/Users/yukar/OneDrive/Desktop/GOBY-main
```

Load Data

```r
park_visibility <- readr::read_csv("C:/Users/yukar/OneDrive/Desktop/GOBY-main/Potential Data/Final Data .csv")
```

```
## Rows: 26633 Columns: 22
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (11): Dataset, SiteCode, Date, SiteName, State, ammNO3f_Unit, ammSO4f_Un...
## dbl (11): POC, Percentile, Latitude, Longitude, Elevation, ammNO3f_Val, ammS...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
glimpse(park_visibility)
```

```
## Rows: 26,633
## Columns: 22
## $ Dataset      <chr> "IMPRHR2", "IMPRHR2", "IMPRHR2", "IMPRHR2", "IMPRHR2", "I…
## $ SiteCode     <chr> "AGTI1", "AGTI1", "AGTI1", "AGTI1", "AGTI1", "AGTI1", "AG…
## $ POC          <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
## $ Date         <chr> "01/03/2011", "01/06/2011", "01/09/2011", "01/12/2011", "…
## $ Percentile   <dbl> 10, 10, 70, 10, 10, 10, 10, 10, 10, 50, 0, 30, 90, 10, 30…
## $ SiteName     <chr> "Agua Tibia", "Agua Tibia", "Agua Tibia", "Agua Tibia", "…
## $ Latitude     <dbl> 33.4636, 33.4636, 33.4636, 33.4636, 33.4636, 33.4636, 33.…
## $ Longitude    <dbl> -116.9706, -116.9706, -116.9706, -116.9706, -116.9706, -1…
## $ Elevation    <dbl> 507.5, 507.5, 507.5, 507.5, 507.5, 507.5, 507.5, 507.5, 5…
## $ State        <chr> "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA…
## $ ammNO3f_Val  <dbl> 0.44634, 0.06966, 1.72409, 0.26909, 0.04502, 0.07650, 0.0…
## $ ammNO3f_Unit <chr> "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3…
## $ ammSO4f_Val  <dbl> 0.16578, 0.18971, 1.64575, 0.21182, 0.09261, 0.13254, 0.1…
## $ ammSO4f_Unit <chr> "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3…
## $ ECf_Val      <dbl> 0.1010, 0.1536, 0.2011, 0.1017, 0.1202, 0.1528, 0.1018, 0…
## $ ECf_Unit     <chr> "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3…
## $ OMCf_Val     <dbl> 0.65988, 0.65016, 1.86570, 0.50094, 0.60552, 0.76230, 0.4…
## $ OMCf_Unit    <chr> "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3…
## $ SOILf_Val    <dbl> 0.12392, 0.12221, 0.13866, 0.22845, 0.17952, 0.25427, 0.2…
## $ SOILf_Unit   <chr> "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3", "ug/m^3…
## $ SVR_Val      <dbl> 217.30695, 238.28668, 83.81186, 218.84126, 245.69277, 228…
## $ SVR_Unit     <chr> "km", "km", "km", "km", "km", "km", "km", "km", "km", "km…
```
Clean Column Names

```r
park_visibility <-
  park_visibility %>% 
  clean_names()
names(park_visibility)
```

```
##  [1] "dataset"       "site_code"     "poc"           "date"         
##  [5] "percentile"    "site_name"     "latitude"      "longitude"    
##  [9] "elevation"     "state"         "amm_no3f_val"  "amm_no3f_unit"
## [13] "amm_so4f_val"  "amm_so4f_unit" "e_cf_val"      "e_cf_unit"    
## [17] "om_cf_val"     "om_cf_unit"    "soi_lf_val"    "soi_lf_unit"  
## [21] "svr_val"       "svr_unit"
```
Deal with NA's

```r
park_visibility <-
  park_visibility %>% 
  na_if("-999")
```

Separate Dates

```r
park_visibility <-
  park_visibility %>% 
  separate("date", into = c("month", "day", "year"), sep = "/")
```

Playing around with data and making a sample graph

```r
park_visibility %>% 
  filter(year == "2011") %>% 
  group_by(month, site_name) %>% 
  summarise(mean_amm_no3f_val = mean(amm_no3f_val, na.rm = T)) %>% 
  ggplot(aes(x = month, y = mean_amm_no3f_val, color = site_name)) +
  geom_boxplot() +
  labs(x = "Month",
       y = "Average Ammonium Nitrate",
       title = "Average Ammonium Nitrate per Month in 2011")
```

```
## `summarise()` has grouped output by 'month'. You can override using the
## `.groups` argument.
```

![](yi_data_exploration_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

What does percentile refer to? Percentile visibility? 

```r
park_visibility %>% 
  count(site_name, percentile)
```

```
## # A tibble: 138 × 3
##    site_name       percentile     n
##    <chr>                <dbl> <int>
##  1 Agua Tibia               0   495
##  2 Agua Tibia              10   165
##  3 Agua Tibia              30   161
##  4 Agua Tibia              50   185
##  5 Agua Tibia              70   161
##  6 Agua Tibia              90   172
##  7 Bliss SP (TRPA)          0   212
##  8 Bliss SP (TRPA)         10   222
##  9 Bliss SP (TRPA)         30   215
## 10 Bliss SP (TRPA)         50   245
## # … with 128 more rows
```

More messing with data

```r
park_visibility %>% 
  filter(site_name == "Yosemite NP") %>% 
  group_by(year) %>% 
  summarise(mean_amm_so4f_val = mean(amm_so4f_val, na.rm = T)) %>% 
  ggplot(aes(x = year, y = mean_amm_so4f_val)) +
  geom_col() +
  labs(x = "Year",
       y = "Average Ammonium Sulfate",
       title = "Average Ammonium Sulfate in Yosemite National Park by Year")
```

![](yi_data_exploration_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

