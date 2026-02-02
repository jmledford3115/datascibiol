This is the FAO Fishery and Aquaculture Reference Data repository.


file naming:
-------------

- CL_*   "code-lists": contains the identifier and mapping to other codes and descriptions; 

- HCL_*  "hierarchical code-lists": contains the grouping information, a pointer (foreign key) from the reference object (parent) to the children

- FSJ_*  FishStat metadata; we use it to define FishStatJ and the query panel

- DSD_* "Data Structure Definition": describes how information in a specific dataset is structured. It defines the dimensions, measures and their related attributes. 

raw data download:
*.csv  "time-series" file with the name <DATASET>_<TIMESERIES>.csv 

By convention, the decimal separator in the column "Value" is set to the dot character (.) which might conflict with users-specific locale settings.
Please also note that values have no thousands' separator. 

All information contents in the files in CSV (comma-separated values) formatted as UTF-8. 
To open these files in Excel, go to the menu
Data->From Text and select File origin "65001: Unicode UTF-8" and comma delimiter

When using time-series data, in order to obtain the aggregates presented in the 
summary tables of the "FAO Yearbook of Fishery and Aquaculture Statistics" which exclude production figures 
for aquatic plants, crocodiles, aq. mammals, pearls and mother-of-pearl, corals and sponges data should be filtered using a Custom Group:
"Aquatic animals (Fish, crustaceans and molluscs, etc)"(1801).

Please note that the list of species disseminated here, reflects the ASFIS standarad compatible with the data being published.
As such, it does not adhere entirely to ASFIS due to differing publication schedules.

TERMS OF USE/LICENSE:
--------------------
https://www.fao.org/contact-us/terms/db-terms-of-use/en

As stated in Article 1 of its Constitution, the Food and Agriculture Organization of the United Nations (“FAO”) “shall collect, analyse, interpret, 
and disseminate information related to nutrition, food, and agriculture”. In this regard, FAO creates and maintains corporate statistical databases on topics 
related to its mandate and encourages their use for statistical, scientific, research and evidence-based decision-making purposes. Accordingly, all FAO corporate 
statistical databases provide datasets free of charge, in machine-readable format on FAO’s corporate website. They are subject to the Statistical Database terms 
of use of this agreement (“Database terms”) and the Terms and Conditions regarding the Reuse of Web content (https://www.fao.org/contact-us/terms/en), 
which are incorporated herein by reference.

FAO encourages you to use datasets contained in FAO corporate statistical databases for research, statistical, scientific and evidence-based decision-making purposes. 
You may access, download, create copies, adapt and re-disseminate datasets subject to these Database terms. Unless specified otherwise in their metadata or webpage, 
all datasets disseminated through FAO corporate statistical databases (see examples in Annex 1) are licensed under the Creative Commons Attribution-4.0 International 
licence (CC BY 4.0) available here as complemented by the Terms of Use outlined below. In other words, when you access, download, or otherwise extract any data or 
datasets from these databases, you agree to comply with the terms and conditions of the CC BY 4.0 licence and all terms specified in the additional terms of use outlined below.
https://creativecommons.org/licenses/by/4.0/legalcode.en


COPYRIGHT & DISCLAIMER CLAUSES
-----------------------------
All requests for translation and adaptation rights, and for resale and other commercial use rights should be made via www.fao.org/contact-us/licence-request or addressed to copyright@fao.org.

The designations employed and the presentation of material in this information product do not imply the expression of any opinion whatsoever on the part of the Food and Agriculture Organization of the United Nations (FAO) concerning the legal or development status of any country, territory, city or area or of its authorities, or concerning the delimitation of its frontiers or boundaries. The mention of specific companies or products of manufacturers, whether or not these have been patented, does not imply that these have been endorsed or recommended by FAO in preference to others of a similar nature that are not mentioned.

FAO declines all responsibility for errors or deficiencies in the database or software or in the documentation accompanying it, for program maintenance and upgrading as well as for any damage that may arise from them. FAO also declines any responsibility for updating the data and assumes no responsibility for errors and omissions in the data provided. Users are, however, kindly asked to report any errors or deficiencies in this product to FAO.
The word "countries" appearing in the text refers to countries, territories and areas without distinction. 
The designations employed and the presentation of material in the map(s) do not imply the expression of any opinion whatsoever on the part of FAO concerning the legal or constitutional status of any country, territory or sea area, or concerning the delimitation of frontiers.

For comments, views and suggestions relating to this data, please email to:
Email: Fish-Statistics-Inquiries@fao.org

(c) FAO 2025
