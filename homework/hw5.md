---
title: "Homework 5"
author: "Joel Ledford"
date: "2024-02-03"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries

```r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    

```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```


```r
names(superhero_powers)
```

```
##   [1] "hero_names"                   "Agility"                     
##   [3] "Accelerated Healing"          "Lantern Power Ring"          
##   [5] "Dimensional Awareness"        "Cold Resistance"             
##   [7] "Durability"                   "Stealth"                     
##   [9] "Energy Absorption"            "Flight"                      
##  [11] "Danger Sense"                 "Underwater breathing"        
##  [13] "Marksmanship"                 "Weapons Master"              
##  [15] "Power Augmentation"           "Animal Attributes"           
##  [17] "Longevity"                    "Intelligence"                
##  [19] "Super Strength"               "Cryokinesis"                 
##  [21] "Telepathy"                    "Energy Armor"                
##  [23] "Energy Blasts"                "Duplication"                 
##  [25] "Size Changing"                "Density Control"             
##  [27] "Stamina"                      "Astral Travel"               
##  [29] "Audio Control"                "Dexterity"                   
##  [31] "Omnitrix"                     "Super Speed"                 
##  [33] "Possession"                   "Animal Oriented Powers"      
##  [35] "Weapon-based Powers"          "Electrokinesis"              
##  [37] "Darkforce Manipulation"       "Death Touch"                 
##  [39] "Teleportation"                "Enhanced Senses"             
##  [41] "Telekinesis"                  "Energy Beams"                
##  [43] "Magic"                        "Hyperkinesis"                
##  [45] "Jump"                         "Clairvoyance"                
##  [47] "Dimensional Travel"           "Power Sense"                 
##  [49] "Shapeshifting"                "Peak Human Condition"        
##  [51] "Immortality"                  "Camouflage"                  
##  [53] "Element Control"              "Phasing"                     
##  [55] "Astral Projection"            "Electrical Transport"        
##  [57] "Fire Control"                 "Projection"                  
##  [59] "Summoning"                    "Enhanced Memory"             
##  [61] "Reflexes"                     "Invulnerability"             
##  [63] "Energy Constructs"            "Force Fields"                
##  [65] "Self-Sustenance"              "Anti-Gravity"                
##  [67] "Empathy"                      "Power Nullifier"             
##  [69] "Radiation Control"            "Psionic Powers"              
##  [71] "Elasticity"                   "Substance Secretion"         
##  [73] "Elemental Transmogrification" "Technopath/Cyberpath"        
##  [75] "Photographic Reflexes"        "Seismic Power"               
##  [77] "Animation"                    "Precognition"                
##  [79] "Mind Control"                 "Fire Resistance"             
##  [81] "Power Absorption"             "Enhanced Hearing"            
##  [83] "Nova Force"                   "Insanity"                    
##  [85] "Hypnokinesis"                 "Animal Control"              
##  [87] "Natural Armor"                "Intangibility"               
##  [89] "Enhanced Sight"               "Molecular Manipulation"      
##  [91] "Heat Generation"              "Adaptation"                  
##  [93] "Gliding"                      "Power Suit"                  
##  [95] "Mind Blast"                   "Probability Manipulation"    
##  [97] "Gravity Control"              "Regeneration"                
##  [99] "Light Control"                "Echolocation"                
## [101] "Levitation"                   "Toxin and Disease Control"   
## [103] "Banish"                       "Energy Manipulation"         
## [105] "Heat Resistance"              "Natural Weapons"             
## [107] "Time Travel"                  "Enhanced Smell"              
## [109] "Illusions"                    "Thirstokinesis"              
## [111] "Hair Manipulation"            "Illumination"                
## [113] "Omnipotent"                   "Cloaking"                    
## [115] "Changing Armor"               "Power Cosmic"                
## [117] "Biokinesis"                   "Water Control"               
## [119] "Radiation Immunity"           "Vision - Telescopic"         
## [121] "Toxin and Disease Resistance" "Spatial Awareness"           
## [123] "Energy Resistance"            "Telepathy Resistance"        
## [125] "Molecular Combustion"         "Omnilingualism"              
## [127] "Portal Creation"              "Magnetism"                   
## [129] "Mind Control Resistance"      "Plant Control"               
## [131] "Sonar"                        "Sonic Scream"                
## [133] "Time Manipulation"            "Enhanced Touch"              
## [135] "Magic Resistance"             "Invisibility"                
## [137] "Sub-Mariner"                  "Radiation Absorption"        
## [139] "Intuitive aptitude"           "Vision - Microscopic"        
## [141] "Melting"                      "Wind Control"                
## [143] "Super Breath"                 "Wallcrawling"                
## [145] "Vision - Night"               "Vision - Infrared"           
## [147] "Grim Reaping"                 "Matter Absorption"           
## [149] "The Force"                    "Resurrection"                
## [151] "Terrakinesis"                 "Vision - Heat"               
## [153] "Vitakinesis"                  "Radar Sense"                 
## [155] "Qwardian Power Ring"          "Weather Control"             
## [157] "Vision - X-Ray"               "Vision - Thermal"            
## [159] "Web Creation"                 "Reality Warping"             
## [161] "Odin Force"                   "Symbiote Costume"            
## [163] "Speed Force"                  "Phoenix Force"               
## [165] "Molecular Dissipation"        "Vision - Cryo"               
## [167] "Omnipresent"                  "Omniscient"
```


```r
superhero_powers <- clean_names(superhero_powers)
```


```r
superhero_info <- clean_names(superhero_info)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

```r
tabyl(superhero_info, publisher)
```

```
##          publisher   n     percent valid_percent
##        ABC Studios   4 0.005449591   0.005563282
##          DC Comics 215 0.292915531   0.299026426
##  Dark Horse Comics  18 0.024523161   0.025034771
##       George Lucas  14 0.019073569   0.019471488
##      Hanna-Barbera   1 0.001362398   0.001390821
##      HarperCollins   6 0.008174387   0.008344924
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##       Image Comics  14 0.019073569   0.019471488
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##      Marvel Comics 388 0.528610354   0.539638387
##          Microsoft   1 0.001362398   0.001390821
##       NBC - Heroes  19 0.025885559   0.026425591
##          Rebellion   1 0.001362398   0.001390821
##           Shueisha   4 0.005449591   0.005563282
##      Sony Pictures   2 0.002724796   0.002781641
##         South Park   1 0.001362398   0.001390821
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
##          Wildstorm   3 0.004087193   0.004172462
##               <NA>  15 0.020435967            NA
```

2. Notice that we have some neutral superheros! Who are they? List their names below.  

```r
neutral <- superhero_info %>% filter(alignment=="neutral")
```


```r
neutral$name
```

```
##  [1] "Bizarro"         "Black Flash"     "Captain Cold"    "Copycat"        
##  [5] "Deadpool"        "Deathstroke"     "Etrigan"         "Galactus"       
##  [9] "Gladiator"       "Indigo"          "Juggernaut"      "Living Tribunal"
## [13] "Lobo"            "Man-Bat"         "One-Above-All"   "Raven"          
## [17] "Red Hood"        "Red Hulk"        "Robin VI"        "Sandman"        
## [21] "Sentry"          "Sinestro"        "The Comedian"    "Toad"
```

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superhero_info %>% select("name", "alignment", "race")
```

```
## # A tibble: 734 × 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ℹ 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
not_human <- superhero_info %>% filter(race!="Human")
```


```r
not_human$name
```

```
##   [1] "Abe Sapien"                "Abin Sur"                 
##   [3] "Abomination"               "Abraxas"                  
##   [5] "Ajax"                      "Alien"                    
##   [7] "Amazo"                     "Angel"                    
##   [9] "Angel Dust"                "Anti-Monitor"             
##  [11] "Anti-Venom"                "Apocalypse"               
##  [13] "Aqualad"                   "Aquaman"                  
##  [15] "Archangel"                 "Ardina"                   
##  [17] "Atlas"                     "Atlas"                    
##  [19] "Aurora"                    "Azazel"                   
##  [21] "Beast"                     "Beyonder"                 
##  [23] "Big Barda"                 "Bill Harken"              
##  [25] "Bionic Woman"              "Birdman"                  
##  [27] "Bishop"                    "Bizarro"                  
##  [29] "Black Bolt"                "Black Canary"             
##  [31] "Black Flash"               "Blackout"                 
##  [33] "Blackwulf"                 "Blade"                    
##  [35] "Blink"                     "Bloodhawk"                
##  [37] "Boba Fett"                 "Boom-Boom"                
##  [39] "Brainiac"                  "Brundlefly"               
##  [41] "Cable"                     "Cameron Hicks"            
##  [43] "Captain Atom"              "Captain Marvel"           
##  [45] "Captain Planet"            "Captain Universe"         
##  [47] "Carnage"                   "Century"                  
##  [49] "Cerebra"                   "Chamber"                  
##  [51] "Colossus"                  "Copycat"                  
##  [53] "Crystal"                   "Cyborg"                   
##  [55] "Cyborg Superman"           "Cyclops"                  
##  [57] "Darkseid"                  "Darkstar"                 
##  [59] "Darth Maul"                "Darth Vader"              
##  [61] "Data"                      "Dazzler"                  
##  [63] "Deadpool"                  "Deathlok"                 
##  [65] "Demogoblin"                "Doc Samson"               
##  [67] "Donatello"                 "Donna Troy"               
##  [69] "Doomsday"                  "Dr Manhattan"             
##  [71] "Drax the Destroyer"        "Etrigan"                  
##  [73] "Evil Deadpool"             "Evilhawk"                 
##  [75] "Exodus"                    "Faora"                    
##  [77] "Fin Fang Foom"             "Firestar"                 
##  [79] "Franklin Richards"         "Galactus"                 
##  [81] "Gambit"                    "Gamora"                   
##  [83] "Garbage Man"               "Gary Bell"                
##  [85] "General Zod"               "Ghost Rider"              
##  [87] "Gladiator"                 "Godzilla"                 
##  [89] "Goku"                      "Gorilla Grodd"            
##  [91] "Greedo"                    "Groot"                    
##  [93] "Guy Gardner"               "Havok"                    
##  [95] "Hela"                      "Hellboy"                  
##  [97] "Hercules"                  "Hulk"                     
##  [99] "Human Torch"               "Husk"                     
## [101] "Hybrid"                    "Hyperion"                 
## [103] "Iceman"                    "Indigo"                   
## [105] "Ink"                       "Invisible Woman"          
## [107] "Jar Jar Binks"             "Jean Grey"                
## [109] "Jubilee"                   "Junkpile"                 
## [111] "K-2SO"                     "Killer Croc"              
## [113] "Kilowog"                   "King Kong"                
## [115] "King Shark"                "Krypto"                   
## [117] "Lady Deathstrike"          "Legion"                   
## [119] "Leonardo"                  "Living Tribunal"          
## [121] "Lobo"                      "Loki"                     
## [123] "Magneto"                   "Man of Miracles"          
## [125] "Mantis"                    "Martian Manhunter"        
## [127] "Master Chief"              "Medusa"                   
## [129] "Mera"                      "Metallo"                  
## [131] "Michelangelo"              "Mister Fantastic"         
## [133] "Mister Knife"              "Mister Mxyzptlk"          
## [135] "Mister Sinister"           "MODOK"                    
## [137] "Mogo"                      "Mr Immortal"              
## [139] "Mystique"                  "Namor"                    
## [141] "Nebula"                    "Negasonic Teenage Warhead"
## [143] "Nina Theroux"              "Nova"                     
## [145] "Odin"                      "One-Above-All"            
## [147] "Onslaught"                 "Parademon"                
## [149] "Phoenix"                   "Plantman"                 
## [151] "Polaris"                   "Power Girl"               
## [153] "Power Man"                 "Predator"                 
## [155] "Professor X"               "Psylocke"                 
## [157] "Q"                         "Quicksilver"              
## [159] "Rachel Pirzad"             "Raphael"                  
## [161] "Red Hulk"                  "Red Tornado"              
## [163] "Rhino"                     "Rocket Raccoon"           
## [165] "Sabretooth"                "Sauron"                   
## [167] "Scarlet Spider II"         "Scarlet Witch"            
## [169] "Sebastian Shaw"            "Sentry"                   
## [171] "Shadow Lass"               "Shadowcat"                
## [173] "She-Thing"                 "Sif"                      
## [175] "Silver Surfer"             "Sinestro"                 
## [177] "Siren"                     "Snake-Eyes"               
## [179] "Solomon Grundy"            "Spawn"                    
## [181] "Spectre"                   "Spider-Carnage"           
## [183] "Spock"                     "Spyke"                    
## [185] "Star-Lord"                 "Starfire"                 
## [187] "Static"                    "Steppenwolf"              
## [189] "Storm"                     "Sunspot"                  
## [191] "Superboy-Prime"            "Supergirl"                
## [193] "Superman"                  "Swamp Thing"              
## [195] "Swarm"                     "T-1000"                   
## [197] "T-800"                     "T-850"                    
## [199] "T-X"                       "Thanos"                   
## [201] "Thing"                     "Thor"                     
## [203] "Thor Girl"                 "Toad"                     
## [205] "Toxin"                     "Toxin"                    
## [207] "Trigon"                    "Triton"                   
## [209] "Ultron"                    "Utgard-Loki"              
## [211] "Vegeta"                    "Venom"                    
## [213] "Venom III"                 "Venompool"                
## [215] "Vision"                    "Warpath"                  
## [217] "Wolverine"                 "Wonder Girl"              
## [219] "Wonder Woman"              "X-23"                     
## [221] "Ymir"                      "Yoda"
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good_guys <- 
  superhero_info %>% 
  filter(alignment=="good")
```


```r
bad_guys <- 
  superhero_info %>% 
  filter(alignment=="bad")
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
good_guys %>% tabyl(race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Vampires?

```r
good_guys %>% filter(race=="Vampire")
```

```
## # A tibble: 2 × 10
##   name  gender eye_color race   hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr>  <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Angel Male   <NA>      Vampi… <NA>           NA Dark Hor… <NA>       good     
## 2 Blade Male   brown     Vampi… Black         188 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad_guys %>% filter(race=="Human" & gender=="Male" & height>=150)
```

```
## # A tibble: 36 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  2 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
##  3 Bane  Male   <NA>      Human <NA>          203 DC Comics <NA>       bad      
##  4 Blac… Male   black     Human No Hair       188 DC Comics <NA>       bad      
##  5 Bull… Male   blue      Human blond         183 Marvel C… <NA>       bad      
##  6 Cloc… Male   blue      Human Black         178 DC Comics <NA>       bad      
##  7 Cott… Male   brown     Human Black         183 Marvel C… <NA>       bad      
##  8 Dead… Male   brown     Human Brown         185 DC Comics <NA>       bad      
##  9 Diam… Male   brown     Human Black         193 Marvel C… <NA>       bad      
## 10 Doct… Male   brown     Human Brown         201 Marvel C… <NA>       bad      
## # ℹ 26 more rows
## # ℹ 1 more variable: weight <dbl>
```

9. Are there more good guys or bad guys with green hair?  

```r
good_guys %>% 
  filter(hair_color=="Green")
```

```
## # A tibble: 7 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Beast… Male   green     Human Green         173 DC Comics green      good     
## 2 Capta… Male   red       God … Green          NA Marvel C… <NA>       good     
## 3 Doc S… Male   blue      Huma… Green         198 Marvel C… <NA>       good     
## 4 Hulk   Male   green     Huma… Green         244 Marvel C… green      good     
## 5 Lyja   Female green     <NA>  Green          NA Marvel C… <NA>       good     
## 6 Polar… Female green     Muta… Green         170 Marvel C… <NA>       good     
## 7 She-H… Female green     Human Green         201 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```


```r
bad_guys %>% 
  filter(hair_color=="Green")
```

```
## # A tibble: 1 × 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Joker Male   green     Human Green         196 DC Comics white      bad      
## # ℹ 1 more variable: weight <dbl>
```


```r
table(superhero_info$hair_color, superhero_info$alignment)
```

```
##                   
##                    bad good neutral
##   Auburn             3   10       0
##   black              0    3       0
##   Black             42  108       8
##   Black / Blue       1    0       0
##   blond              1    2       0
##   Blond             11   85       1
##   Blue               1    1       1
##   Brown             27   55       4
##   Brown / Black      0    1       0
##   Brown / White      0    4       0
##   Brownn             1    0       0
##   Gold               1    0       0
##   Green              1    7       0
##   Grey               3    2       0
##   Indigo             0    1       0
##   Magenta            0    1       0
##   No Hair           35   37       3
##   Orange             0    2       0
##   Orange / White     0    1       0
##   Pink               0    1       0
##   Purple             3    1       1
##   Red                9   40       2
##   Red / Grey         1    0       0
##   Red / Orange       1    0       0
##   Red / White        0    1       0
##   Silver             0    3       0
##   Strawberry Blond   3    4       0
##   White             10   10       2
##   Yellow             0    2       0
```


```r
superhero_info %>% 
  tabyl(hair_color, alignment)
```

```
##        hair_color bad good neutral NA_
##            Auburn   3   10       0   0
##             black   0    3       0   0
##             Black  42  108       8   0
##      Black / Blue   1    0       0   0
##             blond   1    2       0   0
##             Blond  11   85       1   2
##              Blue   1    1       1   0
##             Brown  27   55       4   0
##     Brown / Black   0    1       0   0
##     Brown / White   0    4       0   0
##            Brownn   1    0       0   0
##              Gold   1    0       0   0
##             Green   1    7       0   0
##              Grey   3    2       0   0
##            Indigo   0    1       0   0
##           Magenta   0    1       0   0
##           No Hair  35   37       3   0
##            Orange   0    2       0   0
##    Orange / White   0    1       0   0
##              Pink   0    1       0   0
##            Purple   3    1       1   0
##               Red   9   40       2   0
##        Red / Grey   1    0       0   0
##      Red / Orange   1    0       0   0
##       Red / White   0    1       0   0
##            Silver   0    3       0   1
##  Strawberry Blond   3    4       0   0
##             White  10   10       2   1
##            Yellow   0    2       0   0
##              <NA>  53  114       2   3
```


```r
superhero_info %>% 
  filter(hair_color=="Green") %>% 
  group_by(alignment) %>% 
  summarise(n=n())
```

```
## # A tibble: 2 × 2
##   alignment     n
##   <chr>     <int>
## 1 bad           1
## 2 good          7
```


```r
superhero_info %>% 
  filter(hair_color=="Green") %>% 
  count(hair_color, alignment)
```

```
## # A tibble: 2 × 3
##   hair_color alignment     n
##   <chr>      <chr>     <int>
## 1 Green      bad           1
## 2 Green      good          7
```

10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  

```r
superhero_info %>% 
  filter(weight<50) %>% 
  arrange(weight)
```

```
## # A tibble: 19 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Iron… Male   blue      <NA>  No Hair        NA Marvel C… <NA>       bad      
##  2 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  3 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  4 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  5 Yoda  Male   brown     Yoda… White          66 George L… green      good     
##  6 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  7 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  8 Kryp… Male   blue      Kryp… White          64 DC Comics <NA>       good     
##  9 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
## 10 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
## 11 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
## 12 Robi… Male   blue      Human Black         137 DC Comics <NA>       good     
## 13 Wiz … <NA>   brown     <NA>  Black         140 Marvel C… <NA>       good     
## 14 Viol… Female violet    Human Black         137 Dark Hor… <NA>       good     
## 15 Fran… Male   blue      Muta… Blond         142 Marvel C… <NA>       good     
## 16 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 17 Hope… Female green     <NA>  Red           168 Marvel C… <NA>       good     
## 18 Jolt  Female blue      <NA>  Black         165 Marvel C… <NA>       good     
## 19 Snow… Female white     <NA>  Blond         178 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    

```r
superhero_info <- 
  superhero_info %>% 
  mutate(height_weight_ratio=height/weight)
```

12. Who has the highest height to weight ratio?  

```r
superhero_info %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  2 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  3 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  4 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
##  5 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  6 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
##  7 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
##  8 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  9 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 10 Yoda  Male   brown     Yoda… White          66 George L… green      good     
## # ℹ 724 more rows
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

13. How many superheros have a combination of agility, stealth, super_strength, stamina?

```r
superhero_powers %>%
  filter(agility & stealth & super_strength & stamina) %>%
  select(hero_names, agility, stealth, super_strength, stamina)
```

```
## # A tibble: 40 × 5
##    hero_names  agility stealth super_strength stamina
##    <chr>       <lgl>   <lgl>   <lgl>          <lgl>  
##  1 Alex Mercer TRUE    TRUE    TRUE           TRUE   
##  2 Angel       TRUE    TRUE    TRUE           TRUE   
##  3 Ant-Man II  TRUE    TRUE    TRUE           TRUE   
##  4 Aquaman     TRUE    TRUE    TRUE           TRUE   
##  5 Batman      TRUE    TRUE    TRUE           TRUE   
##  6 Black Flash TRUE    TRUE    TRUE           TRUE   
##  7 Black Manta TRUE    TRUE    TRUE           TRUE   
##  8 Brundlefly  TRUE    TRUE    TRUE           TRUE   
##  9 Buffy       TRUE    TRUE    TRUE           TRUE   
## 10 Cable       TRUE    TRUE    TRUE           TRUE   
## # ℹ 30 more rows
```


```r
superhero_powers %>% 
  select(hero_names, agility, stealth, super_strength, stamina) %>% 
  filter(agility==TRUE & stealth==TRUE & super_strength==TRUE & stamina==TRUE)
```

```
## # A tibble: 40 × 5
##    hero_names  agility stealth super_strength stamina
##    <chr>       <lgl>   <lgl>   <lgl>          <lgl>  
##  1 Alex Mercer TRUE    TRUE    TRUE           TRUE   
##  2 Angel       TRUE    TRUE    TRUE           TRUE   
##  3 Ant-Man II  TRUE    TRUE    TRUE           TRUE   
##  4 Aquaman     TRUE    TRUE    TRUE           TRUE   
##  5 Batman      TRUE    TRUE    TRUE           TRUE   
##  6 Black Flash TRUE    TRUE    TRUE           TRUE   
##  7 Black Manta TRUE    TRUE    TRUE           TRUE   
##  8 Brundlefly  TRUE    TRUE    TRUE           TRUE   
##  9 Buffy       TRUE    TRUE    TRUE           TRUE   
## 10 Cable       TRUE    TRUE    TRUE           TRUE   
## # ℹ 30 more rows
```

## Your Favorite
14. Pick your favorite superhero and let's see their powers!  

```r
superhero_powers %>%
  filter(hero_names == "Darth Vader") %>%
  select_if(all)  # Selects all columns where all values are TRUE
```

```
## Warning in .p(column, ...): coercing argument of type 'character' to logical
```

```
## # A tibble: 1 × 26
##   agility accelerated_healing durability stealth danger_sense marksmanship
##   <lgl>   <lgl>               <lgl>      <lgl>   <lgl>        <lgl>       
## 1 TRUE    TRUE                TRUE       TRUE    TRUE         TRUE        
## # ℹ 20 more variables: weapons_master <lgl>, intelligence <lgl>,
## #   telepathy <lgl>, energy_blasts <lgl>, super_speed <lgl>,
## #   electrokinesis <lgl>, enhanced_senses <lgl>, telekinesis <lgl>, jump <lgl>,
## #   astral_projection <lgl>, reflexes <lgl>, force_fields <lgl>,
## #   psionic_powers <lgl>, precognition <lgl>, enhanced_hearing <lgl>,
## #   hypnokinesis <lgl>, light_control <lgl>, illusions <lgl>, cloaking <lgl>,
## #   the_force <lgl>
```

15. Can you find your hero in the superhero_info data? Show their info!  

```r
superhero_info %>% 
  filter(name=="Darth Vader")
```

```
## # A tibble: 1 × 11
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Darth… Male   yellow    Cybo… No Hair       198 George L… <NA>       bad      
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
