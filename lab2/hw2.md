---
title: "Homework 2"
author: "Key"
date: "2026-01-03"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and/or complete the exercises in RMarkdown. Please embed all of your code and push the final work to your repository. Your report should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run.

## Load the library

``` r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.6
## ✔ forcats   1.0.1     ✔ stringr   1.6.0
## ✔ ggplot2   4.0.1     ✔ tibble    3.3.0
## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
## ✔ purrr     1.2.0     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

**1. Objects in R are a way in which we can store data or operations. Make a new object `pi` as 3.14159. You should now see the object `pi` in the environment window in the top right.** 


**2. Write a code chunk that divides `pi` by 2. Use the help command `?` to learn how to use the `round` function to limit your result to 3 significant digits.**  


**3. Calculate the mean for the numbers 2, 8, 4, 6, 7, 4, 9, 9, 10. Please start by making a new object `x` that holds these values then use `mean` to perform the calculation.**  




**4. Make three new vectors that show the name, height in feet, and height in meters of the five tallest mountains in the world.**


**5. Combine these vectors into a data frame called `mountains`.**


**6. What is the mean height of the mountains in feet?**


**7. When were each of these mountains first climbed (i.e. in what year)? Make a new vector `first_climbed` and add it to the `mountains` data frame.**




**8. How many times have each of these mountains been climbed? Make a new vector `summits` and add it to the `mountains` data frame.**


**9. Which mountain has the highest number of fatalities? Make a new vector `fatalities` and add it to the `mountains` data frame.**


**10. Write your data frame to a .csv file.**


## Knit and Upload
Please knit your work as a .pdf or .html file and upload to Canvas. Homework is due before the start of the next lab. No late work is accepted. Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  
