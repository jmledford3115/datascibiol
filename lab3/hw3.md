---
title: "Homework 3"
author: "Type Your Name Here"
date: "2025-02-24"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and/or complete the exercises in RMarkdown. Please embed all of your code and push the final work to your repository. Your report should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run.  

## Load the tidyverse

``` r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
## ✔ purrr     1.0.4     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
options(scipen=999) # turn off scientific notation
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder and the reference is below.  

**Database of vertebrate home range sizes.**. 
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

``` r
homerange <- read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Rows: 569 Columns: 24
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (16): taxon, common.name, class, order, family, genus, species, primarym...
## dbl  (8): mean.mass.g, log10.mass, mean.hra.m2, log10.hra, dimension, preyma...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

**2. What are the dimensions of the dataframe?**  

``` r
dim(homerange)
```

```
## [1] 569  24
```

**3. Are there any NA's in the dataframe? Try using summary to determine which variables have more or less NA's.**

``` r
anyNA(homerange)
```

```
## [1] TRUE
```

**4. What are the names of the columns in the dataframe?**

``` r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

**5. Based on the summary output, do you see anything in the data that looks strange? Think like a biologist and consider the variables.**  

_Some of the variables have stange values, like -999_. 

**6. The `min` and `max` functions can be used to find the minimum and maximum values in a vector. Use these functions to find the minimum and maximum values for the variable `mean.mass.g`.**  

``` r
min(homerange$mean.mass.g)
```

```
## [1] 0.22
```


``` r
max(homerange$mean.mass.g)
```

```
## [1] 4000000
```

**7. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

``` r
homerange$taxon <- as.factor(homerange$taxon)
```


``` r
homerange$order <- as.factor(homerange$order)
```

**8. Use `select` to pull out the variables taxon and common.name.**  

``` r
select(homerange, taxon, common.name)
```

```
## # A tibble: 569 × 2
##    taxon         common.name            
##    <fct>         <chr>                  
##  1 lake fishes   american eel           
##  2 river fishes  blacktail redhorse     
##  3 river fishes  central stoneroller    
##  4 river fishes  rosyside dace          
##  5 river fishes  longnose dace          
##  6 river fishes  muskellunge            
##  7 marine fishes pollack                
##  8 marine fishes saithe                 
##  9 marine fishes lined surgeonfish      
## 10 marine fishes orangespine unicornfish
## # ℹ 559 more rows
```

**9. Use `filter` to pull out all mammals from the data.**

``` r
filter(homerange, taxon == "mammals")
```

```
## # A tibble: 238 × 24
##    taxon   common.name      class order family genus species primarymethod N    
##    <fct>   <chr>            <chr> <fct> <chr>  <chr> <chr>   <chr>         <chr>
##  1 mammals giant golden mo… mamm… afro… chrys… chry… trevel… telemetry*    <NA> 
##  2 mammals Grant's golden … mamm… afro… chrys… erem… granti  telemetry*    <NA> 
##  3 mammals pronghorn        mamm… arti… antil… anti… americ… telemetry*    <NA> 
##  4 mammals impala           mamm… arti… bovid… aepy… melamp… telemetry*    <NA> 
##  5 mammals hartebeest       mamm… arti… bovid… alce… busela… telemetry*    <NA> 
##  6 mammals barbary sheep    mamm… arti… bovid… ammo… lervia  telemetry*    <NA> 
##  7 mammals American bison   mamm… arti… bovid… bison bison   telemetry*    <NA> 
##  8 mammals European bison   mamm… arti… bovid… bison bonasus telemetry*    <NA> 
##  9 mammals goat             mamm… arti… bovid… capra hircus  telemetry*    <NA> 
## 10 mammals Spanish ibex     mamm… arti… bovid… capra pyrena… telemetry*    <NA> 
## # ℹ 228 more rows
## # ℹ 15 more variables: mean.mass.g <dbl>, log10.mass <dbl>,
## #   alternative.mass.reference <chr>, mean.hra.m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic.guild <chr>, dimension <dbl>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```

**10. What is the largest `mean.hra.m2` for mammals? This is a very large number! Which animal has this homerange? Look them up online and see if you can figure out why this number is so large.**

``` r
max(filter(homerange, taxon == "mammals")$mean.hra.m2)
```

```
## [1] 3550830977
```

## Knit and Upload
Please knit your work as a .pdf or .html file and upload to Canvas. Homework is due before the start of the next lab. No late work is accepted. Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  
