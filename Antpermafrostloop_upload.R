#Loop over each site

#Tools/Directory
setwd("~/Dropbox/r_projects/mdv_winter_warming")
library(lubridate)
knitr::opts_knit$set(global.device = TRUE)

#Creating the for loop. List of locations and their urls. Then we have to run each one through the LTER frame and make it so that all align. Each data set has its own url which makes it tricky.
#going to remove any data that is not used

#Data
locations <- c("Lake Bonney", "Explorers Cove", "Lake Brownworth", "Lake Fryxell", "Lake Hoare", "Lake Vanda", "Lake Vida", "Miers Valley", "Mount Fleming", "Taylor Glacier", "Canada Glacier", "Commonwealth Glacier", "Howard Glacier",  "Friis Hills")

for(location in locations){

if(location == "Lake Bonney"){
  
  pdf('LakeBonneygraphs.pdf')
  
  # Package ID: knb-lter-mcm.7103.10 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Bonney Meteorological Station (BOYM), McMurdo Dry Valleys, Antarctica (1993-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/2dd262e53ebc79fcedcde214b3b53e03" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "AVG_AIRT1M",     
                   "STD_AIRT1M",     
                   "MIN_AIRT1M",     
                   "MAX_AIRT1M",     
                   "N_AIRT1M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$AVG_AIRT1M)=="factor") dt1$AVG_AIRT1M <-as.numeric(levels(dt1$AVG_AIRT1M))[as.integer(dt1$AVG_AIRT1M) ]               
  if (class(dt1$AVG_AIRT1M)=="character") dt1$AVG_AIRT1M <-as.numeric(dt1$AVG_AIRT1M)
  if (class(dt1$STD_AIRT1M)=="factor") dt1$STD_AIRT1M <-as.numeric(levels(dt1$STD_AIRT1M))[as.integer(dt1$STD_AIRT1M) ]               
  if (class(dt1$STD_AIRT1M)=="character") dt1$STD_AIRT1M <-as.numeric(dt1$STD_AIRT1M)
  if (class(dt1$MIN_AIRT1M)=="factor") dt1$MIN_AIRT1M <-as.numeric(levels(dt1$MIN_AIRT1M))[as.integer(dt1$MIN_AIRT1M) ]               
  if (class(dt1$MIN_AIRT1M)=="character") dt1$MIN_AIRT1M <-as.numeric(dt1$MIN_AIRT1M)
  if (class(dt1$MAX_AIRT1M)=="factor") dt1$MAX_AIRT1M <-as.numeric(levels(dt1$MAX_AIRT1M))[as.integer(dt1$MAX_AIRT1M) ]               
  if (class(dt1$MAX_AIRT1M)=="character") dt1$MAX_AIRT1M <-as.numeric(dt1$MAX_AIRT1M)
  if (class(dt1$N_AIRT1M)=="factor") dt1$N_AIRT1M <-as.numeric(levels(dt1$N_AIRT1M))[as.integer(dt1$N_AIRT1M) ]               
  if (class(dt1$N_AIRT1M)=="character") dt1$N_AIRT1M <-as.numeric(dt1$N_AIRT1M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(AVG_AIRT1M)
  summary(STD_AIRT1M)
  summary(MIN_AIRT1M)
  summary(MAX_AIRT1M)
  summary(N_AIRT1M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/f90a9c0143cde585f524ef250572f05e" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PPT",     
                   "STD_PPT",     
                   "MIN_PPT",     
                   "MAX_PPT",     
                   "N_PPT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)                                   
  if (class(dt2$AVG_PPT)=="factor") dt2$AVG_PPT <-as.numeric(levels(dt2$AVG_PPT))[as.integer(dt2$AVG_PPT) ]               
  if (class(dt2$AVG_PPT)=="character") dt2$AVG_PPT <-as.numeric(dt2$AVG_PPT)
  if (class(dt2$STD_PPT)=="factor") dt2$STD_PPT <-as.numeric(levels(dt2$STD_PPT))[as.integer(dt2$STD_PPT) ]               
  if (class(dt2$STD_PPT)=="character") dt2$STD_PPT <-as.numeric(dt2$STD_PPT)
  if (class(dt2$MIN_PPT)=="factor") dt2$MIN_PPT <-as.numeric(levels(dt2$MIN_PPT))[as.integer(dt2$MIN_PPT) ]               
  if (class(dt2$MIN_PPT)=="character") dt2$MIN_PPT <-as.numeric(dt2$MIN_PPT)
  if (class(dt2$MAX_PPT)=="factor") dt2$MAX_PPT <-as.numeric(levels(dt2$MAX_PPT))[as.integer(dt2$MAX_PPT) ]               
  if (class(dt2$MAX_PPT)=="character") dt2$MAX_PPT <-as.numeric(dt2$MAX_PPT)
  if (class(dt2$N_PPT)=="factor") dt2$N_PPT <-as.numeric(levels(dt2$N_PPT))[as.integer(dt2$N_PPT) ]               
  if (class(dt2$N_PPT)=="character") dt2$N_PPT <-as.numeric(dt2$N_PPT)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PPT <- ifelse((trimws(as.character(dt2$AVG_PPT))==trimws("Null")),NA,dt2$AVG_PPT)               
  suppressWarnings(dt2$AVG_PPT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PPT))==as.character(as.numeric("Null"))),NA,dt2$AVG_PPT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PPT)
  summary(STD_PPT)
  summary(MIN_PPT)
  summary(MAX_PPT)
  summary(N_PPT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/538210dd8ee15b1fe13512eb8d5e487c" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_LWRADIN2",     
                   "STD_LWRADIN2",     
                   "MIN_LWRADIN2",     
                   "MAX_LWRADIN2",     
                   "N_LWRADIN2",     
                   "AVG_LWRADOUT",     
                   "STD_LWRADOUT",     
                   "MIN_LWRADOUT",     
                   "MAX_LWRADOUT",     
                   "N_LWRADOUT",     
                   "AVG_LWRADOUT2",     
                   "STD_LWRADOUT2",     
                   "MIN_LWRADOUT2",     
                   "MAX_LWRADOUT2",     
                   "N_LWRADOUT2",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_PAR)=="factor") dt3$AVG_PAR <-as.numeric(levels(dt3$AVG_PAR))[as.integer(dt3$AVG_PAR) ]               
  if (class(dt3$AVG_PAR)=="character") dt3$AVG_PAR <-as.numeric(dt3$AVG_PAR)
  if (class(dt3$STD_PAR)=="factor") dt3$STD_PAR <-as.numeric(levels(dt3$STD_PAR))[as.integer(dt3$STD_PAR) ]               
  if (class(dt3$STD_PAR)=="character") dt3$STD_PAR <-as.numeric(dt3$STD_PAR)
  if (class(dt3$MIN_PAR)=="factor") dt3$MIN_PAR <-as.numeric(levels(dt3$MIN_PAR))[as.integer(dt3$MIN_PAR) ]               
  if (class(dt3$MIN_PAR)=="character") dt3$MIN_PAR <-as.numeric(dt3$MIN_PAR)
  if (class(dt3$MAX_PAR)=="factor") dt3$MAX_PAR <-as.numeric(levels(dt3$MAX_PAR))[as.integer(dt3$MAX_PAR) ]               
  if (class(dt3$MAX_PAR)=="character") dt3$MAX_PAR <-as.numeric(dt3$MAX_PAR)
  if (class(dt3$N_PAR)=="factor") dt3$N_PAR <-as.numeric(levels(dt3$N_PAR))[as.integer(dt3$N_PAR) ]               
  if (class(dt3$N_PAR)=="character") dt3$N_PAR <-as.numeric(dt3$N_PAR)
  if (class(dt3$AVG_LWRADIN)=="factor") dt3$AVG_LWRADIN <-as.numeric(levels(dt3$AVG_LWRADIN))[as.integer(dt3$AVG_LWRADIN) ]               
  if (class(dt3$AVG_LWRADIN)=="character") dt3$AVG_LWRADIN <-as.numeric(dt3$AVG_LWRADIN)
  if (class(dt3$STD_LWRADIN)=="factor") dt3$STD_LWRADIN <-as.numeric(levels(dt3$STD_LWRADIN))[as.integer(dt3$STD_LWRADIN) ]               
  if (class(dt3$STD_LWRADIN)=="character") dt3$STD_LWRADIN <-as.numeric(dt3$STD_LWRADIN)
  if (class(dt3$MIN_LWRADIN)=="factor") dt3$MIN_LWRADIN <-as.numeric(levels(dt3$MIN_LWRADIN))[as.integer(dt3$MIN_LWRADIN) ]               
  if (class(dt3$MIN_LWRADIN)=="character") dt3$MIN_LWRADIN <-as.numeric(dt3$MIN_LWRADIN)
  if (class(dt3$MAX_LWRADIN)=="factor") dt3$MAX_LWRADIN <-as.numeric(levels(dt3$MAX_LWRADIN))[as.integer(dt3$MAX_LWRADIN) ]               
  if (class(dt3$MAX_LWRADIN)=="character") dt3$MAX_LWRADIN <-as.numeric(dt3$MAX_LWRADIN)
  if (class(dt3$N_LWRADIN)=="factor") dt3$N_LWRADIN <-as.numeric(levels(dt3$N_LWRADIN))[as.integer(dt3$N_LWRADIN) ]               
  if (class(dt3$N_LWRADIN)=="character") dt3$N_LWRADIN <-as.numeric(dt3$N_LWRADIN)
  if (class(dt3$AVG_LWRADIN2)=="factor") dt3$AVG_LWRADIN2 <-as.numeric(levels(dt3$AVG_LWRADIN2))[as.integer(dt3$AVG_LWRADIN2) ]               
  if (class(dt3$AVG_LWRADIN2)=="character") dt3$AVG_LWRADIN2 <-as.numeric(dt3$AVG_LWRADIN2)
  if (class(dt3$STD_LWRADIN2)=="factor") dt3$STD_LWRADIN2 <-as.numeric(levels(dt3$STD_LWRADIN2))[as.integer(dt3$STD_LWRADIN2) ]               
  if (class(dt3$STD_LWRADIN2)=="character") dt3$STD_LWRADIN2 <-as.numeric(dt3$STD_LWRADIN2)
  if (class(dt3$MIN_LWRADIN2)=="factor") dt3$MIN_LWRADIN2 <-as.numeric(levels(dt3$MIN_LWRADIN2))[as.integer(dt3$MIN_LWRADIN2) ]               
  if (class(dt3$MIN_LWRADIN2)=="character") dt3$MIN_LWRADIN2 <-as.numeric(dt3$MIN_LWRADIN2)
  if (class(dt3$MAX_LWRADIN2)=="factor") dt3$MAX_LWRADIN2 <-as.numeric(levels(dt3$MAX_LWRADIN2))[as.integer(dt3$MAX_LWRADIN2) ]               
  if (class(dt3$MAX_LWRADIN2)=="character") dt3$MAX_LWRADIN2 <-as.numeric(dt3$MAX_LWRADIN2)
  if (class(dt3$N_LWRADIN2)=="factor") dt3$N_LWRADIN2 <-as.numeric(levels(dt3$N_LWRADIN2))[as.integer(dt3$N_LWRADIN2) ]               
  if (class(dt3$N_LWRADIN2)=="character") dt3$N_LWRADIN2 <-as.numeric(dt3$N_LWRADIN2)
  if (class(dt3$AVG_LWRADOUT)=="factor") dt3$AVG_LWRADOUT <-as.numeric(levels(dt3$AVG_LWRADOUT))[as.integer(dt3$AVG_LWRADOUT) ]               
  if (class(dt3$AVG_LWRADOUT)=="character") dt3$AVG_LWRADOUT <-as.numeric(dt3$AVG_LWRADOUT)
  if (class(dt3$STD_LWRADOUT)=="factor") dt3$STD_LWRADOUT <-as.numeric(levels(dt3$STD_LWRADOUT))[as.integer(dt3$STD_LWRADOUT) ]               
  if (class(dt3$STD_LWRADOUT)=="character") dt3$STD_LWRADOUT <-as.numeric(dt3$STD_LWRADOUT)
  if (class(dt3$MIN_LWRADOUT)=="factor") dt3$MIN_LWRADOUT <-as.numeric(levels(dt3$MIN_LWRADOUT))[as.integer(dt3$MIN_LWRADOUT) ]               
  if (class(dt3$MIN_LWRADOUT)=="character") dt3$MIN_LWRADOUT <-as.numeric(dt3$MIN_LWRADOUT)
  if (class(dt3$MAX_LWRADOUT)=="factor") dt3$MAX_LWRADOUT <-as.numeric(levels(dt3$MAX_LWRADOUT))[as.integer(dt3$MAX_LWRADOUT) ]               
  if (class(dt3$MAX_LWRADOUT)=="character") dt3$MAX_LWRADOUT <-as.numeric(dt3$MAX_LWRADOUT)
  if (class(dt3$N_LWRADOUT)=="factor") dt3$N_LWRADOUT <-as.numeric(levels(dt3$N_LWRADOUT))[as.integer(dt3$N_LWRADOUT) ]               
  if (class(dt3$N_LWRADOUT)=="character") dt3$N_LWRADOUT <-as.numeric(dt3$N_LWRADOUT)
  if (class(dt3$AVG_LWRADOUT2)=="factor") dt3$AVG_LWRADOUT2 <-as.numeric(levels(dt3$AVG_LWRADOUT2))[as.integer(dt3$AVG_LWRADOUT2) ]               
  if (class(dt3$AVG_LWRADOUT2)=="character") dt3$AVG_LWRADOUT2 <-as.numeric(dt3$AVG_LWRADOUT2)
  if (class(dt3$STD_LWRADOUT2)=="factor") dt3$STD_LWRADOUT2 <-as.numeric(levels(dt3$STD_LWRADOUT2))[as.integer(dt3$STD_LWRADOUT2) ]               
  if (class(dt3$STD_LWRADOUT2)=="character") dt3$STD_LWRADOUT2 <-as.numeric(dt3$STD_LWRADOUT2)
  if (class(dt3$MIN_LWRADOUT2)=="factor") dt3$MIN_LWRADOUT2 <-as.numeric(levels(dt3$MIN_LWRADOUT2))[as.integer(dt3$MIN_LWRADOUT2) ]               
  if (class(dt3$MIN_LWRADOUT2)=="character") dt3$MIN_LWRADOUT2 <-as.numeric(dt3$MIN_LWRADOUT2)
  if (class(dt3$MAX_LWRADOUT2)=="factor") dt3$MAX_LWRADOUT2 <-as.numeric(levels(dt3$MAX_LWRADOUT2))[as.integer(dt3$MAX_LWRADOUT2) ]               
  if (class(dt3$MAX_LWRADOUT2)=="character") dt3$MAX_LWRADOUT2 <-as.numeric(dt3$MAX_LWRADOUT2)
  if (class(dt3$N_LWRADOUT2)=="factor") dt3$N_LWRADOUT2 <-as.numeric(levels(dt3$N_LWRADOUT2))[as.integer(dt3$N_LWRADOUT2) ]               
  if (class(dt3$N_LWRADOUT2)=="character") dt3$N_LWRADOUT2 <-as.numeric(dt3$N_LWRADOUT2)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_PAR <- ifelse((trimws(as.character(dt3$AVG_PAR))==trimws("Null")),NA,dt3$AVG_PAR)               
  suppressWarnings(dt3$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt3$AVG_PAR))
  dt3$STD_PAR <- ifelse((trimws(as.character(dt3$STD_PAR))==trimws("Null")),NA,dt3$STD_PAR)               
  suppressWarnings(dt3$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_PAR))==as.character(as.numeric("Null"))),NA,dt3$STD_PAR))
  dt3$MIN_PAR <- ifelse((trimws(as.character(dt3$MIN_PAR))==trimws("Null")),NA,dt3$MIN_PAR)               
  suppressWarnings(dt3$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt3$MIN_PAR))
  dt3$MAX_PAR <- ifelse((trimws(as.character(dt3$MAX_PAR))==trimws("Null")),NA,dt3$MAX_PAR)               
  suppressWarnings(dt3$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt3$MAX_PAR))
  dt3$STD_LWRADIN <- ifelse((trimws(as.character(dt3$STD_LWRADIN))==trimws("Null")),NA,dt3$STD_LWRADIN)               
  suppressWarnings(dt3$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN))
  dt3$MIN_LWRADIN <- ifelse((trimws(as.character(dt3$MIN_LWRADIN))==trimws("Null")),NA,dt3$MIN_LWRADIN)               
  suppressWarnings(dt3$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN))
  dt3$MAX_LWRADIN <- ifelse((trimws(as.character(dt3$MAX_LWRADIN))==trimws("Null")),NA,dt3$MAX_LWRADIN)               
  suppressWarnings(dt3$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN))
  dt3$STD_LWRADIN2 <- ifelse((trimws(as.character(dt3$STD_LWRADIN2))==trimws("Null")),NA,dt3$STD_LWRADIN2)               
  suppressWarnings(dt3$STD_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN2))
  dt3$MIN_LWRADIN2 <- ifelse((trimws(as.character(dt3$MIN_LWRADIN2))==trimws("Null")),NA,dt3$MIN_LWRADIN2)               
  suppressWarnings(dt3$MIN_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN2))
  dt3$MAX_LWRADIN2 <- ifelse((trimws(as.character(dt3$MAX_LWRADIN2))==trimws("Null")),NA,dt3$MAX_LWRADIN2)               
  suppressWarnings(dt3$MAX_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN2))
  dt3$STD_LWRADOUT <- ifelse((trimws(as.character(dt3$STD_LWRADOUT))==trimws("Null")),NA,dt3$STD_LWRADOUT)               
  suppressWarnings(dt3$STD_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT))
  dt3$MIN_LWRADOUT <- ifelse((trimws(as.character(dt3$MIN_LWRADOUT))==trimws("Null")),NA,dt3$MIN_LWRADOUT)               
  suppressWarnings(dt3$MIN_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADOUT))
  dt3$MAX_LWRADOUT <- ifelse((trimws(as.character(dt3$MAX_LWRADOUT))==trimws("Null")),NA,dt3$MAX_LWRADOUT)               
  suppressWarnings(dt3$MAX_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADOUT))
  dt3$STD_LWRADOUT2 <- ifelse((trimws(as.character(dt3$STD_LWRADOUT2))==trimws("Null")),NA,dt3$STD_LWRADOUT2)               
  suppressWarnings(dt3$STD_LWRADOUT2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT2))
  dt3$AVG_SWRADIN <- ifelse((trimws(as.character(dt3$AVG_SWRADIN))==trimws("Null")),NA,dt3$AVG_SWRADIN)               
  suppressWarnings(dt3$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADIN))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_LWRADIN2)
  summary(STD_LWRADIN2)
  summary(MIN_LWRADIN2)
  summary(MAX_LWRADIN2)
  summary(N_LWRADIN2)
  summary(AVG_LWRADOUT)
  summary(STD_LWRADOUT)
  summary(MIN_LWRADOUT)
  summary(MAX_LWRADOUT)
  summary(N_LWRADOUT)
  summary(AVG_LWRADOUT2)
  summary(STD_LWRADOUT2)
  summary(MIN_LWRADOUT2)
  summary(MAX_LWRADOUT2)
  summary(N_LWRADOUT2)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/4e7f895ed7d443a7530fa108fb6af21b" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/a4e90e00d1117ada14035715e5acf10e" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SNOWHT",     
                   "STD_SNOWHT",     
                   "MIN_SNOWHT",     
                   "MAX_SNOWHT",     
                   "N_SNOWHT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SNOWHT)=="factor") dt5$AVG_SNOWHT <-as.numeric(levels(dt5$AVG_SNOWHT))[as.integer(dt5$AVG_SNOWHT) ]               
  if (class(dt5$AVG_SNOWHT)=="character") dt5$AVG_SNOWHT <-as.numeric(dt5$AVG_SNOWHT)
  if (class(dt5$STD_SNOWHT)=="factor") dt5$STD_SNOWHT <-as.numeric(levels(dt5$STD_SNOWHT))[as.integer(dt5$STD_SNOWHT) ]               
  if (class(dt5$STD_SNOWHT)=="character") dt5$STD_SNOWHT <-as.numeric(dt5$STD_SNOWHT)
  if (class(dt5$MIN_SNOWHT)=="factor") dt5$MIN_SNOWHT <-as.numeric(levels(dt5$MIN_SNOWHT))[as.integer(dt5$MIN_SNOWHT) ]               
  if (class(dt5$MIN_SNOWHT)=="character") dt5$MIN_SNOWHT <-as.numeric(dt5$MIN_SNOWHT)
  if (class(dt5$MAX_SNOWHT)=="factor") dt5$MAX_SNOWHT <-as.numeric(levels(dt5$MAX_SNOWHT))[as.integer(dt5$MAX_SNOWHT) ]               
  if (class(dt5$MAX_SNOWHT)=="character") dt5$MAX_SNOWHT <-as.numeric(dt5$MAX_SNOWHT)
  if (class(dt5$N_SNOWHT)=="factor") dt5$N_SNOWHT <-as.numeric(levels(dt5$N_SNOWHT))[as.integer(dt5$N_SNOWHT) ]               
  if (class(dt5$N_SNOWHT)=="character") dt5$N_SNOWHT <-as.numeric(dt5$N_SNOWHT)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SNOWHT)
  summary(STD_SNOWHT)
  summary(MIN_SNOWHT)
  summary(MAX_SNOWHT)
  summary(N_SNOWHT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/1d35c69228ee34b66bc5dfc89e6e347c" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)
  if (class(dt6$AVG_SOILT0CM)=="factor") dt6$AVG_SOILT0CM <-as.numeric(levels(dt6$AVG_SOILT0CM))[as.integer(dt6$AVG_SOILT0CM) ]               
  if (class(dt6$AVG_SOILT0CM)=="character") dt6$AVG_SOILT0CM <-as.numeric(dt6$AVG_SOILT0CM)
  if (class(dt6$STD_SOILT0CM)=="factor") dt6$STD_SOILT0CM <-as.numeric(levels(dt6$STD_SOILT0CM))[as.integer(dt6$STD_SOILT0CM) ]               
  if (class(dt6$STD_SOILT0CM)=="character") dt6$STD_SOILT0CM <-as.numeric(dt6$STD_SOILT0CM)
  if (class(dt6$MIN_SOILT0CM)=="factor") dt6$MIN_SOILT0CM <-as.numeric(levels(dt6$MIN_SOILT0CM))[as.integer(dt6$MIN_SOILT0CM) ]               
  if (class(dt6$MIN_SOILT0CM)=="character") dt6$MIN_SOILT0CM <-as.numeric(dt6$MIN_SOILT0CM)
  if (class(dt6$MAX_SOILT0CM)=="factor") dt6$MAX_SOILT0CM <-as.numeric(levels(dt6$MAX_SOILT0CM))[as.integer(dt6$MAX_SOILT0CM) ]               
  if (class(dt6$MAX_SOILT0CM)=="character") dt6$MAX_SOILT0CM <-as.numeric(dt6$MAX_SOILT0CM)
  if (class(dt6$N_SOILT0CM)=="factor") dt6$N_SOILT0CM <-as.numeric(levels(dt6$N_SOILT0CM))[as.integer(dt6$N_SOILT0CM) ]               
  if (class(dt6$N_SOILT0CM)=="character") dt6$N_SOILT0CM <-as.numeric(dt6$N_SOILT0CM)
  if (class(dt6$AVG_SOILT5CM)=="factor") dt6$AVG_SOILT5CM <-as.numeric(levels(dt6$AVG_SOILT5CM))[as.integer(dt6$AVG_SOILT5CM) ]               
  if (class(dt6$AVG_SOILT5CM)=="character") dt6$AVG_SOILT5CM <-as.numeric(dt6$AVG_SOILT5CM)
  if (class(dt6$STD_SOILT5CM)=="factor") dt6$STD_SOILT5CM <-as.numeric(levels(dt6$STD_SOILT5CM))[as.integer(dt6$STD_SOILT5CM) ]               
  if (class(dt6$STD_SOILT5CM)=="character") dt6$STD_SOILT5CM <-as.numeric(dt6$STD_SOILT5CM)
  if (class(dt6$MIN_SOILT5CM)=="factor") dt6$MIN_SOILT5CM <-as.numeric(levels(dt6$MIN_SOILT5CM))[as.integer(dt6$MIN_SOILT5CM) ]               
  if (class(dt6$MIN_SOILT5CM)=="character") dt6$MIN_SOILT5CM <-as.numeric(dt6$MIN_SOILT5CM)
  if (class(dt6$MAX_SOILT5CM)=="factor") dt6$MAX_SOILT5CM <-as.numeric(levels(dt6$MAX_SOILT5CM))[as.integer(dt6$MAX_SOILT5CM) ]               
  if (class(dt6$MAX_SOILT5CM)=="character") dt6$MAX_SOILT5CM <-as.numeric(dt6$MAX_SOILT5CM)
  if (class(dt6$N_SOILT5CM)=="factor") dt6$N_SOILT5CM <-as.numeric(levels(dt6$N_SOILT5CM))[as.integer(dt6$N_SOILT5CM) ]               
  if (class(dt6$N_SOILT5CM)=="character") dt6$N_SOILT5CM <-as.numeric(dt6$N_SOILT5CM)
  if (class(dt6$AVG_SOILT10CM)=="factor") dt6$AVG_SOILT10CM <-as.numeric(levels(dt6$AVG_SOILT10CM))[as.integer(dt6$AVG_SOILT10CM) ]               
  if (class(dt6$AVG_SOILT10CM)=="character") dt6$AVG_SOILT10CM <-as.numeric(dt6$AVG_SOILT10CM)
  if (class(dt6$STD_SOILT10CM)=="factor") dt6$STD_SOILT10CM <-as.numeric(levels(dt6$STD_SOILT10CM))[as.integer(dt6$STD_SOILT10CM) ]               
  if (class(dt6$STD_SOILT10CM)=="character") dt6$STD_SOILT10CM <-as.numeric(dt6$STD_SOILT10CM)
  if (class(dt6$MIN_SOILT10CM)=="factor") dt6$MIN_SOILT10CM <-as.numeric(levels(dt6$MIN_SOILT10CM))[as.integer(dt6$MIN_SOILT10CM) ]               
  if (class(dt6$MIN_SOILT10CM)=="character") dt6$MIN_SOILT10CM <-as.numeric(dt6$MIN_SOILT10CM)
  if (class(dt6$MAX_SOILT10CM)=="factor") dt6$MAX_SOILT10CM <-as.numeric(levels(dt6$MAX_SOILT10CM))[as.integer(dt6$MAX_SOILT10CM) ]               
  if (class(dt6$MAX_SOILT10CM)=="character") dt6$MAX_SOILT10CM <-as.numeric(dt6$MAX_SOILT10CM)
  if (class(dt6$N_SOILT10CM)=="factor") dt6$N_SOILT10CM <-as.numeric(levels(dt6$N_SOILT10CM))[as.integer(dt6$N_SOILT10CM) ]               
  if (class(dt6$N_SOILT10CM)=="character") dt6$N_SOILT10CM <-as.numeric(dt6$N_SOILT10CM)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt6$AVG_SOILT0CM <- ifelse((trimws(as.character(dt6$AVG_SOILT0CM))==trimws("Null")),NA,dt6$AVG_SOILT0CM)               
  suppressWarnings(dt6$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT0CM))
  dt6$STD_SOILT0CM <- ifelse((trimws(as.character(dt6$STD_SOILT0CM))==trimws("Null")),NA,dt6$STD_SOILT0CM)               
  suppressWarnings(dt6$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT0CM))
  dt6$MIN_SOILT0CM <- ifelse((trimws(as.character(dt6$MIN_SOILT0CM))==trimws("Null")),NA,dt6$MIN_SOILT0CM)               
  suppressWarnings(dt6$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT0CM))
  dt6$MAX_SOILT0CM <- ifelse((trimws(as.character(dt6$MAX_SOILT0CM))==trimws("Null")),NA,dt6$MAX_SOILT0CM)               
  suppressWarnings(dt6$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT0CM))
  dt6$AVG_SOILT5CM <- ifelse((trimws(as.character(dt6$AVG_SOILT5CM))==trimws("Null")),NA,dt6$AVG_SOILT5CM)               
  suppressWarnings(dt6$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT5CM))
  dt6$STD_SOILT5CM <- ifelse((trimws(as.character(dt6$STD_SOILT5CM))==trimws("Null")),NA,dt6$STD_SOILT5CM)               
  suppressWarnings(dt6$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT5CM))
  dt6$MIN_SOILT5CM <- ifelse((trimws(as.character(dt6$MIN_SOILT5CM))==trimws("Null")),NA,dt6$MIN_SOILT5CM)               
  suppressWarnings(dt6$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT5CM))
  dt6$MAX_SOILT5CM <- ifelse((trimws(as.character(dt6$MAX_SOILT5CM))==trimws("Null")),NA,dt6$MAX_SOILT5CM)               
  suppressWarnings(dt6$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT5CM))
  dt6$AVG_SOILT10CM <- ifelse((trimws(as.character(dt6$AVG_SOILT10CM))==trimws("Null")),NA,dt6$AVG_SOILT10CM)               
  suppressWarnings(dt6$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT10CM))
  dt6$STD_SOILT10CM <- ifelse((trimws(as.character(dt6$STD_SOILT10CM))==trimws("Null")),NA,dt6$STD_SOILT10CM)               
  suppressWarnings(dt6$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT10CM))
  dt6$MIN_SOILT10CM <- ifelse((trimws(as.character(dt6$MIN_SOILT10CM))==trimws("Null")),NA,dt6$MIN_SOILT10CM)               
  suppressWarnings(dt6$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT10CM))
  dt6$MAX_SOILT10CM <- ifelse((trimws(as.character(dt6$MAX_SOILT10CM))==trimws("Null")),NA,dt6$MAX_SOILT10CM)               
  suppressWarnings(dt6$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/6216ccb198d41d388f4fc519cdc1ce2f" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)                                   
  if (class(dt7$AVG_WSPD)=="factor") dt7$AVG_WSPD <-as.numeric(levels(dt7$AVG_WSPD))[as.integer(dt7$AVG_WSPD) ]               
  if (class(dt7$AVG_WSPD)=="character") dt7$AVG_WSPD <-as.numeric(dt7$AVG_WSPD)
  if (class(dt7$STDDEV_WSPD)=="factor") dt7$STDDEV_WSPD <-as.numeric(levels(dt7$STDDEV_WSPD))[as.integer(dt7$STDDEV_WSPD) ]               
  if (class(dt7$STDDEV_WSPD)=="character") dt7$STDDEV_WSPD <-as.numeric(dt7$STDDEV_WSPD)
  if (class(dt7$MIN_WSPD)=="factor") dt7$MIN_WSPD <-as.numeric(levels(dt7$MIN_WSPD))[as.integer(dt7$MIN_WSPD) ]               
  if (class(dt7$MIN_WSPD)=="character") dt7$MIN_WSPD <-as.numeric(dt7$MIN_WSPD)
  if (class(dt7$MAX_WSPD)=="factor") dt7$MAX_WSPD <-as.numeric(levels(dt7$MAX_WSPD))[as.integer(dt7$MAX_WSPD) ]               
  if (class(dt7$MAX_WSPD)=="character") dt7$MAX_WSPD <-as.numeric(dt7$MAX_WSPD)
  if (class(dt7$N_WSPD)=="factor") dt7$N_WSPD <-as.numeric(levels(dt7$N_WSPD))[as.integer(dt7$N_WSPD) ]               
  if (class(dt7$N_WSPD)=="character") dt7$N_WSPD <-as.numeric(dt7$N_WSPD)
  if (class(dt7$N_COMMENTS)=="factor") dt7$N_COMMENTS <-as.numeric(levels(dt7$N_COMMENTS))[as.integer(dt7$N_COMMENTS) ]               
  if (class(dt7$N_COMMENTS)=="character") dt7$N_COMMENTS <-as.numeric(dt7$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID))
  detach(dt7)               

##Remane Data
airtemp <- dt1 
radiation <- dt3
humidity <- dt4
soiltemp <- dt6
windspeed <- dt7 

#loads in wind data
windall <- read.csv("https://mcm.lternet.edu/file/7171/download?token=5krmVHqvQyYuQ-okBgF5IM4BSWSlnmAAZyPWwSUHIZY")

#just date, direction, speed
wind <- windall[,c(3,4,6)]
}

if(location == "Explorers Cove"){
  
  pdf('ExplorersCovegraphs.pdf')
  
  # Package ID: knb-lter-mcm.7108.13 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Explorers Cove Meteorological Station (EXEM), McMurdo Dry Valleys, Antarctica (1995-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/bca079eb69ebbc4b4fc29628de172fd8" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "AVG_AIRTDEL3M1",     
                   "STD_AIRTDEL3M1",     
                   "MIN_AIRTDEL3M1",     
                   "MAX_AIRTDEL3M1",     
                   "N_AIRTDEL3M1",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$AVG_AIRTDEL3M1)=="factor") dt1$AVG_AIRTDEL3M1 <-as.numeric(levels(dt1$AVG_AIRTDEL3M1))[as.integer(dt1$AVG_AIRTDEL3M1) ]               
  if (class(dt1$AVG_AIRTDEL3M1)=="character") dt1$AVG_AIRTDEL3M1 <-as.numeric(dt1$AVG_AIRTDEL3M1)
  if (class(dt1$STD_AIRTDEL3M1)=="factor") dt1$STD_AIRTDEL3M1 <-as.numeric(levels(dt1$STD_AIRTDEL3M1))[as.integer(dt1$STD_AIRTDEL3M1) ]               
  if (class(dt1$STD_AIRTDEL3M1)=="character") dt1$STD_AIRTDEL3M1 <-as.numeric(dt1$STD_AIRTDEL3M1)
  if (class(dt1$MIN_AIRTDEL3M1)=="factor") dt1$MIN_AIRTDEL3M1 <-as.numeric(levels(dt1$MIN_AIRTDEL3M1))[as.integer(dt1$MIN_AIRTDEL3M1) ]               
  if (class(dt1$MIN_AIRTDEL3M1)=="character") dt1$MIN_AIRTDEL3M1 <-as.numeric(dt1$MIN_AIRTDEL3M1)
  if (class(dt1$MAX_AIRTDEL3M1)=="factor") dt1$MAX_AIRTDEL3M1 <-as.numeric(levels(dt1$MAX_AIRTDEL3M1))[as.integer(dt1$MAX_AIRTDEL3M1) ]               
  if (class(dt1$MAX_AIRTDEL3M1)=="character") dt1$MAX_AIRTDEL3M1 <-as.numeric(dt1$MAX_AIRTDEL3M1)
  if (class(dt1$N_AIRTDEL3M1)=="factor") dt1$N_AIRTDEL3M1 <-as.numeric(levels(dt1$N_AIRTDEL3M1))[as.integer(dt1$N_AIRTDEL3M1) ]               
  if (class(dt1$N_AIRTDEL3M1)=="character") dt1$N_AIRTDEL3M1 <-as.numeric(dt1$N_AIRTDEL3M1)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$AVG_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$AVG_AIRTDEL3M1))==trimws("Null")),NA,dt1$AVG_AIRTDEL3M1)               
  suppressWarnings(dt1$AVG_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRTDEL3M1))
  dt1$STD_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$STD_AIRTDEL3M1))==trimws("Null")),NA,dt1$STD_AIRTDEL3M1)               
  suppressWarnings(dt1$STD_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRTDEL3M1))
  dt1$MIN_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MIN_AIRTDEL3M1))==trimws("Null")),NA,dt1$MIN_AIRTDEL3M1)               
  suppressWarnings(dt1$MIN_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRTDEL3M1))
  dt1$MAX_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MAX_AIRTDEL3M1))==trimws("Null")),NA,dt1$MAX_AIRTDEL3M1)               
  suppressWarnings(dt1$MAX_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRTDEL3M1))
  dt1$N_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$N_AIRTDEL3M1))==trimws("Null")),NA,dt1$N_AIRTDEL3M1)               
  suppressWarnings(dt1$N_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$N_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$N_AIRTDEL3M1))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(AVG_AIRTDEL3M1)
  summary(STD_AIRTDEL3M1)
  summary(MIN_AIRTDEL3M1)
  summary(MAX_AIRTDEL3M1)
  summary(N_AIRTDEL3M1)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/7af2d6b7e1ac81a8fecacdaa2869b836" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PPT",     
                   "STD_PPT",     
                   "MIN_PPT",     
                   "MAX_PPT",     
                   "N_PPT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)                                   
  if (class(dt2$AVG_PPT)=="factor") dt2$AVG_PPT <-as.numeric(levels(dt2$AVG_PPT))[as.integer(dt2$AVG_PPT) ]               
  if (class(dt2$AVG_PPT)=="character") dt2$AVG_PPT <-as.numeric(dt2$AVG_PPT)
  if (class(dt2$STD_PPT)=="factor") dt2$STD_PPT <-as.numeric(levels(dt2$STD_PPT))[as.integer(dt2$STD_PPT) ]               
  if (class(dt2$STD_PPT)=="character") dt2$STD_PPT <-as.numeric(dt2$STD_PPT)
  if (class(dt2$MIN_PPT)=="factor") dt2$MIN_PPT <-as.numeric(levels(dt2$MIN_PPT))[as.integer(dt2$MIN_PPT) ]               
  if (class(dt2$MIN_PPT)=="character") dt2$MIN_PPT <-as.numeric(dt2$MIN_PPT)
  if (class(dt2$MAX_PPT)=="factor") dt2$MAX_PPT <-as.numeric(levels(dt2$MAX_PPT))[as.integer(dt2$MAX_PPT) ]               
  if (class(dt2$MAX_PPT)=="character") dt2$MAX_PPT <-as.numeric(dt2$MAX_PPT)
  if (class(dt2$N_PPT)=="factor") dt2$N_PPT <-as.numeric(levels(dt2$N_PPT))[as.integer(dt2$N_PPT) ]               
  if (class(dt2$N_PPT)=="character") dt2$N_PPT <-as.numeric(dt2$N_PPT)
  if (class(dt2$N_COMMENTS)!="factor") dt2$N_COMMENTS<- as.factor(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PPT <- ifelse((trimws(as.character(dt2$AVG_PPT))==trimws("Null")),NA,dt2$AVG_PPT)               
  suppressWarnings(dt2$AVG_PPT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PPT))==as.character(as.numeric("Null"))),NA,dt2$AVG_PPT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PPT)
  summary(STD_PPT)
  summary(MIN_PPT)
  summary(MAX_PPT)
  summary(N_PPT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID)) 
  summary(as.factor(dt2$N_COMMENTS))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/9e1c5370473db5bea0cf13eef6048663" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_PAR)=="factor") dt3$AVG_PAR <-as.numeric(levels(dt3$AVG_PAR))[as.integer(dt3$AVG_PAR) ]               
  if (class(dt3$AVG_PAR)=="character") dt3$AVG_PAR <-as.numeric(dt3$AVG_PAR)
  if (class(dt3$STD_PAR)=="factor") dt3$STD_PAR <-as.numeric(levels(dt3$STD_PAR))[as.integer(dt3$STD_PAR) ]               
  if (class(dt3$STD_PAR)=="character") dt3$STD_PAR <-as.numeric(dt3$STD_PAR)
  if (class(dt3$MIN_PAR)=="factor") dt3$MIN_PAR <-as.numeric(levels(dt3$MIN_PAR))[as.integer(dt3$MIN_PAR) ]               
  if (class(dt3$MIN_PAR)=="character") dt3$MIN_PAR <-as.numeric(dt3$MIN_PAR)
  if (class(dt3$MAX_PAR)=="factor") dt3$MAX_PAR <-as.numeric(levels(dt3$MAX_PAR))[as.integer(dt3$MAX_PAR) ]               
  if (class(dt3$MAX_PAR)=="character") dt3$MAX_PAR <-as.numeric(dt3$MAX_PAR)
  if (class(dt3$N_PAR)=="factor") dt3$N_PAR <-as.numeric(levels(dt3$N_PAR))[as.integer(dt3$N_PAR) ]               
  if (class(dt3$N_PAR)=="character") dt3$N_PAR <-as.numeric(dt3$N_PAR)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_PAR <- ifelse((trimws(as.character(dt3$AVG_PAR))==trimws("Null")),NA,dt3$AVG_PAR)               
  suppressWarnings(dt3$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt3$AVG_PAR))
  dt3$STD_PAR <- ifelse((trimws(as.character(dt3$STD_PAR))==trimws("Null")),NA,dt3$STD_PAR)               
  suppressWarnings(dt3$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_PAR))==as.character(as.numeric("Null"))),NA,dt3$STD_PAR))
  dt3$MIN_PAR <- ifelse((trimws(as.character(dt3$MIN_PAR))==trimws("Null")),NA,dt3$MIN_PAR)               
  suppressWarnings(dt3$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt3$MIN_PAR))
  dt3$MAX_PAR <- ifelse((trimws(as.character(dt3$MAX_PAR))==trimws("Null")),NA,dt3$MAX_PAR)               
  suppressWarnings(dt3$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt3$MAX_PAR))
  dt3$AVG_SWRADIN <- ifelse((trimws(as.character(dt3$AVG_SWRADIN))==trimws("Null")),NA,dt3$AVG_SWRADIN)               
  suppressWarnings(dt3$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADIN))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/aee2847961fb208635458e3719b36232" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/3657cede465ad5d1941b699165009f14" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILM",     
                   "STDDEV_SOILM",     
                   "MIN_SOILM",     
                   "MAX_SOILM",     
                   "N_SOILM",     
                   "N_SOILM_FLAG",     
                   "AVG_SOILT",     
                   "STDDEV_SOILT",     
                   "MIN_SOILT",     
                   "MAX_SOILT",     
                   "N_SOILT",     
                   "N_SOILT_FLAG"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SOILM)=="factor") dt5$AVG_SOILM <-as.numeric(levels(dt5$AVG_SOILM))[as.integer(dt5$AVG_SOILM) ]               
  if (class(dt5$AVG_SOILM)=="character") dt5$AVG_SOILM <-as.numeric(dt5$AVG_SOILM)
  if (class(dt5$STDDEV_SOILM)=="factor") dt5$STDDEV_SOILM <-as.numeric(levels(dt5$STDDEV_SOILM))[as.integer(dt5$STDDEV_SOILM) ]               
  if (class(dt5$STDDEV_SOILM)=="character") dt5$STDDEV_SOILM <-as.numeric(dt5$STDDEV_SOILM)
  if (class(dt5$MIN_SOILM)=="factor") dt5$MIN_SOILM <-as.numeric(levels(dt5$MIN_SOILM))[as.integer(dt5$MIN_SOILM) ]               
  if (class(dt5$MIN_SOILM)=="character") dt5$MIN_SOILM <-as.numeric(dt5$MIN_SOILM)
  if (class(dt5$MAX_SOILM)=="factor") dt5$MAX_SOILM <-as.numeric(levels(dt5$MAX_SOILM))[as.integer(dt5$MAX_SOILM) ]               
  if (class(dt5$MAX_SOILM)=="character") dt5$MAX_SOILM <-as.numeric(dt5$MAX_SOILM)
  if (class(dt5$N_SOILM)=="factor") dt5$N_SOILM <-as.numeric(levels(dt5$N_SOILM))[as.integer(dt5$N_SOILM) ]               
  if (class(dt5$N_SOILM)=="character") dt5$N_SOILM <-as.numeric(dt5$N_SOILM)
  if (class(dt5$N_SOILM_FLAG)=="factor") dt5$N_SOILM_FLAG <-as.numeric(levels(dt5$N_SOILM_FLAG))[as.integer(dt5$N_SOILM_FLAG) ]               
  if (class(dt5$N_SOILM_FLAG)=="character") dt5$N_SOILM_FLAG <-as.numeric(dt5$N_SOILM_FLAG)
  if (class(dt5$AVG_SOILT)=="factor") dt5$AVG_SOILT <-as.numeric(levels(dt5$AVG_SOILT))[as.integer(dt5$AVG_SOILT) ]               
  if (class(dt5$AVG_SOILT)=="character") dt5$AVG_SOILT <-as.numeric(dt5$AVG_SOILT)
  if (class(dt5$STDDEV_SOILT)=="factor") dt5$STDDEV_SOILT <-as.numeric(levels(dt5$STDDEV_SOILT))[as.integer(dt5$STDDEV_SOILT) ]               
  if (class(dt5$STDDEV_SOILT)=="character") dt5$STDDEV_SOILT <-as.numeric(dt5$STDDEV_SOILT)
  if (class(dt5$MIN_SOILT)=="factor") dt5$MIN_SOILT <-as.numeric(levels(dt5$MIN_SOILT))[as.integer(dt5$MIN_SOILT) ]               
  if (class(dt5$MIN_SOILT)=="character") dt5$MIN_SOILT <-as.numeric(dt5$MIN_SOILT)
  if (class(dt5$MAX_SOILT)=="factor") dt5$MAX_SOILT <-as.numeric(levels(dt5$MAX_SOILT))[as.integer(dt5$MAX_SOILT) ]               
  if (class(dt5$MAX_SOILT)=="character") dt5$MAX_SOILT <-as.numeric(dt5$MAX_SOILT)
  if (class(dt5$N_SOILT)=="factor") dt5$N_SOILT <-as.numeric(levels(dt5$N_SOILT))[as.integer(dt5$N_SOILT) ]               
  if (class(dt5$N_SOILT)=="character") dt5$N_SOILT <-as.numeric(dt5$N_SOILT)
  if (class(dt5$N_SOILT_FLAG)=="factor") dt5$N_SOILT_FLAG <-as.numeric(levels(dt5$N_SOILT_FLAG))[as.integer(dt5$N_SOILT_FLAG) ]               
  if (class(dt5$N_SOILT_FLAG)=="character") dt5$N_SOILT_FLAG <-as.numeric(dt5$N_SOILT_FLAG)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SOILM <- ifelse((trimws(as.character(dt5$AVG_SOILM))==trimws("Null")),NA,dt5$AVG_SOILM)               
  suppressWarnings(dt5$AVG_SOILM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SOILM))==as.character(as.numeric("Null"))),NA,dt5$AVG_SOILM))
  dt5$STDDEV_SOILM <- ifelse((trimws(as.character(dt5$STDDEV_SOILM))==trimws("Null")),NA,dt5$STDDEV_SOILM)               
  suppressWarnings(dt5$STDDEV_SOILM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STDDEV_SOILM))==as.character(as.numeric("Null"))),NA,dt5$STDDEV_SOILM))
  dt5$MIN_SOILM <- ifelse((trimws(as.character(dt5$MIN_SOILM))==trimws("Null")),NA,dt5$MIN_SOILM)               
  suppressWarnings(dt5$MIN_SOILM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SOILM))==as.character(as.numeric("Null"))),NA,dt5$MIN_SOILM))
  dt5$MAX_SOILM <- ifelse((trimws(as.character(dt5$MAX_SOILM))==trimws("Null")),NA,dt5$MAX_SOILM)               
  suppressWarnings(dt5$MAX_SOILM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SOILM))==as.character(as.numeric("Null"))),NA,dt5$MAX_SOILM))
  dt5$N_SOILM_FLAG <- ifelse((trimws(as.character(dt5$N_SOILM_FLAG))==trimws("Null")),NA,dt5$N_SOILM_FLAG)               
  suppressWarnings(dt5$N_SOILM_FLAG <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$N_SOILM_FLAG))==as.character(as.numeric("Null"))),NA,dt5$N_SOILM_FLAG))
  dt5$AVG_SOILT <- ifelse((trimws(as.character(dt5$AVG_SOILT))==trimws("Null")),NA,dt5$AVG_SOILT)               
  suppressWarnings(dt5$AVG_SOILT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SOILT))==as.character(as.numeric("Null"))),NA,dt5$AVG_SOILT))
  dt5$STDDEV_SOILT <- ifelse((trimws(as.character(dt5$STDDEV_SOILT))==trimws("Null")),NA,dt5$STDDEV_SOILT)               
  suppressWarnings(dt5$STDDEV_SOILT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STDDEV_SOILT))==as.character(as.numeric("Null"))),NA,dt5$STDDEV_SOILT))
  dt5$MIN_SOILT <- ifelse((trimws(as.character(dt5$MIN_SOILT))==trimws("Null")),NA,dt5$MIN_SOILT)               
  suppressWarnings(dt5$MIN_SOILT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SOILT))==as.character(as.numeric("Null"))),NA,dt5$MIN_SOILT))
  dt5$N_SOILT <- ifelse((trimws(as.character(dt5$N_SOILT))==trimws("Null")),NA,dt5$N_SOILT)               
  suppressWarnings(dt5$N_SOILT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$N_SOILT))==as.character(as.numeric("Null"))),NA,dt5$N_SOILT))
  dt5$N_SOILT_FLAG <- ifelse((trimws(as.character(dt5$N_SOILT_FLAG))==trimws("Null")),NA,dt5$N_SOILT_FLAG)               
  suppressWarnings(dt5$N_SOILT_FLAG <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$N_SOILT_FLAG))==as.character(as.numeric("Null"))),NA,dt5$N_SOILT_FLAG))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILM)
  summary(STDDEV_SOILM)
  summary(MIN_SOILM)
  summary(MAX_SOILM)
  summary(N_SOILM)
  summary(N_SOILM_FLAG)
  summary(AVG_SOILT)
  summary(STDDEV_SOILT)
  summary(MIN_SOILT)
  summary(MAX_SOILT)
  summary(N_SOILT)
  summary(N_SOILT_FLAG) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/9ee382520e2dc6e2c468e902f4cc809e" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)
  if (class(dt6$AVG_SOILT0CM)=="factor") dt6$AVG_SOILT0CM <-as.numeric(levels(dt6$AVG_SOILT0CM))[as.integer(dt6$AVG_SOILT0CM) ]               
  if (class(dt6$AVG_SOILT0CM)=="character") dt6$AVG_SOILT0CM <-as.numeric(dt6$AVG_SOILT0CM)
  if (class(dt6$STD_SOILT0CM)=="factor") dt6$STD_SOILT0CM <-as.numeric(levels(dt6$STD_SOILT0CM))[as.integer(dt6$STD_SOILT0CM) ]               
  if (class(dt6$STD_SOILT0CM)=="character") dt6$STD_SOILT0CM <-as.numeric(dt6$STD_SOILT0CM)
  if (class(dt6$MIN_SOILT0CM)=="factor") dt6$MIN_SOILT0CM <-as.numeric(levels(dt6$MIN_SOILT0CM))[as.integer(dt6$MIN_SOILT0CM) ]               
  if (class(dt6$MIN_SOILT0CM)=="character") dt6$MIN_SOILT0CM <-as.numeric(dt6$MIN_SOILT0CM)
  if (class(dt6$MAX_SOILT0CM)=="factor") dt6$MAX_SOILT0CM <-as.numeric(levels(dt6$MAX_SOILT0CM))[as.integer(dt6$MAX_SOILT0CM) ]               
  if (class(dt6$MAX_SOILT0CM)=="character") dt6$MAX_SOILT0CM <-as.numeric(dt6$MAX_SOILT0CM)
  if (class(dt6$N_SOILT0CM)=="factor") dt6$N_SOILT0CM <-as.numeric(levels(dt6$N_SOILT0CM))[as.integer(dt6$N_SOILT0CM) ]               
  if (class(dt6$N_SOILT0CM)=="character") dt6$N_SOILT0CM <-as.numeric(dt6$N_SOILT0CM)
  if (class(dt6$AVG_SOILT5CM)=="factor") dt6$AVG_SOILT5CM <-as.numeric(levels(dt6$AVG_SOILT5CM))[as.integer(dt6$AVG_SOILT5CM) ]               
  if (class(dt6$AVG_SOILT5CM)=="character") dt6$AVG_SOILT5CM <-as.numeric(dt6$AVG_SOILT5CM)
  if (class(dt6$STD_SOILT5CM)=="factor") dt6$STD_SOILT5CM <-as.numeric(levels(dt6$STD_SOILT5CM))[as.integer(dt6$STD_SOILT5CM) ]               
  if (class(dt6$STD_SOILT5CM)=="character") dt6$STD_SOILT5CM <-as.numeric(dt6$STD_SOILT5CM)
  if (class(dt6$MIN_SOILT5CM)=="factor") dt6$MIN_SOILT5CM <-as.numeric(levels(dt6$MIN_SOILT5CM))[as.integer(dt6$MIN_SOILT5CM) ]               
  if (class(dt6$MIN_SOILT5CM)=="character") dt6$MIN_SOILT5CM <-as.numeric(dt6$MIN_SOILT5CM)
  if (class(dt6$MAX_SOILT5CM)=="factor") dt6$MAX_SOILT5CM <-as.numeric(levels(dt6$MAX_SOILT5CM))[as.integer(dt6$MAX_SOILT5CM) ]               
  if (class(dt6$MAX_SOILT5CM)=="character") dt6$MAX_SOILT5CM <-as.numeric(dt6$MAX_SOILT5CM)
  if (class(dt6$N_SOILT5CM)=="factor") dt6$N_SOILT5CM <-as.numeric(levels(dt6$N_SOILT5CM))[as.integer(dt6$N_SOILT5CM) ]               
  if (class(dt6$N_SOILT5CM)=="character") dt6$N_SOILT5CM <-as.numeric(dt6$N_SOILT5CM)
  if (class(dt6$AVG_SOILT10CM)=="factor") dt6$AVG_SOILT10CM <-as.numeric(levels(dt6$AVG_SOILT10CM))[as.integer(dt6$AVG_SOILT10CM) ]               
  if (class(dt6$AVG_SOILT10CM)=="character") dt6$AVG_SOILT10CM <-as.numeric(dt6$AVG_SOILT10CM)
  if (class(dt6$STD_SOILT10CM)=="factor") dt6$STD_SOILT10CM <-as.numeric(levels(dt6$STD_SOILT10CM))[as.integer(dt6$STD_SOILT10CM) ]               
  if (class(dt6$STD_SOILT10CM)=="character") dt6$STD_SOILT10CM <-as.numeric(dt6$STD_SOILT10CM)
  if (class(dt6$MIN_SOILT10CM)=="factor") dt6$MIN_SOILT10CM <-as.numeric(levels(dt6$MIN_SOILT10CM))[as.integer(dt6$MIN_SOILT10CM) ]               
  if (class(dt6$MIN_SOILT10CM)=="character") dt6$MIN_SOILT10CM <-as.numeric(dt6$MIN_SOILT10CM)
  if (class(dt6$MAX_SOILT10CM)=="factor") dt6$MAX_SOILT10CM <-as.numeric(levels(dt6$MAX_SOILT10CM))[as.integer(dt6$MAX_SOILT10CM) ]               
  if (class(dt6$MAX_SOILT10CM)=="character") dt6$MAX_SOILT10CM <-as.numeric(dt6$MAX_SOILT10CM)
  if (class(dt6$N_SOILT10CM)=="factor") dt6$N_SOILT10CM <-as.numeric(levels(dt6$N_SOILT10CM))[as.integer(dt6$N_SOILT10CM) ]               
  if (class(dt6$N_SOILT10CM)=="character") dt6$N_SOILT10CM <-as.numeric(dt6$N_SOILT10CM)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt6$AVG_SOILT0CM <- ifelse((trimws(as.character(dt6$AVG_SOILT0CM))==trimws("Null")),NA,dt6$AVG_SOILT0CM)               
  suppressWarnings(dt6$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT0CM))
  dt6$STD_SOILT0CM <- ifelse((trimws(as.character(dt6$STD_SOILT0CM))==trimws("Null")),NA,dt6$STD_SOILT0CM)               
  suppressWarnings(dt6$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT0CM))
  dt6$MIN_SOILT0CM <- ifelse((trimws(as.character(dt6$MIN_SOILT0CM))==trimws("Null")),NA,dt6$MIN_SOILT0CM)               
  suppressWarnings(dt6$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT0CM))
  dt6$MAX_SOILT0CM <- ifelse((trimws(as.character(dt6$MAX_SOILT0CM))==trimws("Null")),NA,dt6$MAX_SOILT0CM)               
  suppressWarnings(dt6$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT0CM))
  dt6$AVG_SOILT5CM <- ifelse((trimws(as.character(dt6$AVG_SOILT5CM))==trimws("Null")),NA,dt6$AVG_SOILT5CM)               
  suppressWarnings(dt6$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT5CM))
  dt6$STD_SOILT5CM <- ifelse((trimws(as.character(dt6$STD_SOILT5CM))==trimws("Null")),NA,dt6$STD_SOILT5CM)               
  suppressWarnings(dt6$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT5CM))
  dt6$MIN_SOILT5CM <- ifelse((trimws(as.character(dt6$MIN_SOILT5CM))==trimws("Null")),NA,dt6$MIN_SOILT5CM)               
  suppressWarnings(dt6$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT5CM))
  dt6$MAX_SOILT5CM <- ifelse((trimws(as.character(dt6$MAX_SOILT5CM))==trimws("Null")),NA,dt6$MAX_SOILT5CM)               
  suppressWarnings(dt6$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT5CM))
  dt6$AVG_SOILT10CM <- ifelse((trimws(as.character(dt6$AVG_SOILT10CM))==trimws("Null")),NA,dt6$AVG_SOILT10CM)               
  suppressWarnings(dt6$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT10CM))
  dt6$STD_SOILT10CM <- ifelse((trimws(as.character(dt6$STD_SOILT10CM))==trimws("Null")),NA,dt6$STD_SOILT10CM)               
  suppressWarnings(dt6$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT10CM))
  dt6$MIN_SOILT10CM <- ifelse((trimws(as.character(dt6$MIN_SOILT10CM))==trimws("Null")),NA,dt6$MIN_SOILT10CM)               
  suppressWarnings(dt6$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT10CM))
  dt6$MAX_SOILT10CM <- ifelse((trimws(as.character(dt6$MAX_SOILT10CM))==trimws("Null")),NA,dt6$MAX_SOILT10CM)               
  suppressWarnings(dt6$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7108/13/5f2766dcdcfac1e005c0edf10dc47dea" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STD_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)                                   
  if (class(dt7$AVG_WSPD)=="factor") dt7$AVG_WSPD <-as.numeric(levels(dt7$AVG_WSPD))[as.integer(dt7$AVG_WSPD) ]               
  if (class(dt7$AVG_WSPD)=="character") dt7$AVG_WSPD <-as.numeric(dt7$AVG_WSPD)
  if (class(dt7$STD_WSPD)=="factor") dt7$STD_WSPD <-as.numeric(levels(dt7$STD_WSPD))[as.integer(dt7$STD_WSPD) ]               
  if (class(dt7$STD_WSPD)=="character") dt7$STD_WSPD <-as.numeric(dt7$STD_WSPD)
  if (class(dt7$MIN_WSPD)=="factor") dt7$MIN_WSPD <-as.numeric(levels(dt7$MIN_WSPD))[as.integer(dt7$MIN_WSPD) ]               
  if (class(dt7$MIN_WSPD)=="character") dt7$MIN_WSPD <-as.numeric(dt7$MIN_WSPD)
  if (class(dt7$MAX_WSPD)=="factor") dt7$MAX_WSPD <-as.numeric(levels(dt7$MAX_WSPD))[as.integer(dt7$MAX_WSPD) ]               
  if (class(dt7$MAX_WSPD)=="character") dt7$MAX_WSPD <-as.numeric(dt7$MAX_WSPD)
  if (class(dt7$N_WSPD)=="factor") dt7$N_WSPD <-as.numeric(levels(dt7$N_WSPD))[as.integer(dt7$N_WSPD) ]               
  if (class(dt7$N_WSPD)=="character") dt7$N_WSPD <-as.numeric(dt7$N_WSPD)
  if (class(dt7$N_COMMENTS)!="factor") dt7$N_COMMENTS<- as.factor(dt7$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STD_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID)) 
  summary(as.factor(dt7$N_COMMENTS))
  detach(dt7)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  soiltemp <- dt6
  windspeed <- dt7
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7335/download?token=5SLdub0y1nVZKfnIjYcnOvWMzmTURmMTH6Rf1V4-MiM")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

if(location == "Lake Brownworth"){
  
  pdf('LakeBrownworthgraphs.pdf')
  
  # Package ID: knb-lter-mcm.7105.8 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Brownworth Meteorological Station (BRHM), McMurdo Dry Valleys, Antarctica (1995-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/a811fad00af8a9aa23667ecc0c484fdd" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/dbabe686795bc4d492a48c0a40c39f43" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "AVG_NETRAD",     
                   "STD_NETRAD",     
                   "MIN_NETRAD",     
                   "MAX_NETRAD",     
                   "N_NETRAD",     
                   "AVG_UVA",     
                   "STD_UVA",     
                   "MIN_UVA",     
                   "MAX_UVA",     
                   "N_UVA",     
                   "AVG_UVB",     
                   "STD_UVB",     
                   "MIN_UVB",     
                   "MAX_UVB",     
                   "N_UVB",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PAR)=="factor") dt2$AVG_PAR <-as.numeric(levels(dt2$AVG_PAR))[as.integer(dt2$AVG_PAR) ]               
  if (class(dt2$AVG_PAR)=="character") dt2$AVG_PAR <-as.numeric(dt2$AVG_PAR)
  if (class(dt2$STD_PAR)=="factor") dt2$STD_PAR <-as.numeric(levels(dt2$STD_PAR))[as.integer(dt2$STD_PAR) ]               
  if (class(dt2$STD_PAR)=="character") dt2$STD_PAR <-as.numeric(dt2$STD_PAR)
  if (class(dt2$MIN_PAR)=="factor") dt2$MIN_PAR <-as.numeric(levels(dt2$MIN_PAR))[as.integer(dt2$MIN_PAR) ]               
  if (class(dt2$MIN_PAR)=="character") dt2$MIN_PAR <-as.numeric(dt2$MIN_PAR)
  if (class(dt2$MAX_PAR)=="factor") dt2$MAX_PAR <-as.numeric(levels(dt2$MAX_PAR))[as.integer(dt2$MAX_PAR) ]               
  if (class(dt2$MAX_PAR)=="character") dt2$MAX_PAR <-as.numeric(dt2$MAX_PAR)
  if (class(dt2$N_PAR)=="factor") dt2$N_PAR <-as.numeric(levels(dt2$N_PAR))[as.integer(dt2$N_PAR) ]               
  if (class(dt2$N_PAR)=="character") dt2$N_PAR <-as.numeric(dt2$N_PAR)
  if (class(dt2$AVG_SWRADIN)=="factor") dt2$AVG_SWRADIN <-as.numeric(levels(dt2$AVG_SWRADIN))[as.integer(dt2$AVG_SWRADIN) ]               
  if (class(dt2$AVG_SWRADIN)=="character") dt2$AVG_SWRADIN <-as.numeric(dt2$AVG_SWRADIN)
  if (class(dt2$STD_SWRADIN)=="factor") dt2$STD_SWRADIN <-as.numeric(levels(dt2$STD_SWRADIN))[as.integer(dt2$STD_SWRADIN) ]               
  if (class(dt2$STD_SWRADIN)=="character") dt2$STD_SWRADIN <-as.numeric(dt2$STD_SWRADIN)
  if (class(dt2$MIN_SWRADIN)=="factor") dt2$MIN_SWRADIN <-as.numeric(levels(dt2$MIN_SWRADIN))[as.integer(dt2$MIN_SWRADIN) ]               
  if (class(dt2$MIN_SWRADIN)=="character") dt2$MIN_SWRADIN <-as.numeric(dt2$MIN_SWRADIN)
  if (class(dt2$MAX_SWRADIN)=="factor") dt2$MAX_SWRADIN <-as.numeric(levels(dt2$MAX_SWRADIN))[as.integer(dt2$MAX_SWRADIN) ]               
  if (class(dt2$MAX_SWRADIN)=="character") dt2$MAX_SWRADIN <-as.numeric(dt2$MAX_SWRADIN)
  if (class(dt2$N_SWRADIN)=="factor") dt2$N_SWRADIN <-as.numeric(levels(dt2$N_SWRADIN))[as.integer(dt2$N_SWRADIN) ]               
  if (class(dt2$N_SWRADIN)=="character") dt2$N_SWRADIN <-as.numeric(dt2$N_SWRADIN)
  if (class(dt2$AVG_SWRADOUT)=="factor") dt2$AVG_SWRADOUT <-as.numeric(levels(dt2$AVG_SWRADOUT))[as.integer(dt2$AVG_SWRADOUT) ]               
  if (class(dt2$AVG_SWRADOUT)=="character") dt2$AVG_SWRADOUT <-as.numeric(dt2$AVG_SWRADOUT)
  if (class(dt2$STD_SWRADOUT)=="factor") dt2$STD_SWRADOUT <-as.numeric(levels(dt2$STD_SWRADOUT))[as.integer(dt2$STD_SWRADOUT) ]               
  if (class(dt2$STD_SWRADOUT)=="character") dt2$STD_SWRADOUT <-as.numeric(dt2$STD_SWRADOUT)
  if (class(dt2$MIN_SWRADOUT)=="factor") dt2$MIN_SWRADOUT <-as.numeric(levels(dt2$MIN_SWRADOUT))[as.integer(dt2$MIN_SWRADOUT) ]               
  if (class(dt2$MIN_SWRADOUT)=="character") dt2$MIN_SWRADOUT <-as.numeric(dt2$MIN_SWRADOUT)
  if (class(dt2$MAX_SWRADOUT)=="factor") dt2$MAX_SWRADOUT <-as.numeric(levels(dt2$MAX_SWRADOUT))[as.integer(dt2$MAX_SWRADOUT) ]               
  if (class(dt2$MAX_SWRADOUT)=="character") dt2$MAX_SWRADOUT <-as.numeric(dt2$MAX_SWRADOUT)
  if (class(dt2$N_SWRADOUT)=="factor") dt2$N_SWRADOUT <-as.numeric(levels(dt2$N_SWRADOUT))[as.integer(dt2$N_SWRADOUT) ]               
  if (class(dt2$N_SWRADOUT)=="character") dt2$N_SWRADOUT <-as.numeric(dt2$N_SWRADOUT)
  if (class(dt2$AVG_NETRAD)=="factor") dt2$AVG_NETRAD <-as.numeric(levels(dt2$AVG_NETRAD))[as.integer(dt2$AVG_NETRAD) ]               
  if (class(dt2$AVG_NETRAD)=="character") dt2$AVG_NETRAD <-as.numeric(dt2$AVG_NETRAD)
  if (class(dt2$STD_NETRAD)=="factor") dt2$STD_NETRAD <-as.numeric(levels(dt2$STD_NETRAD))[as.integer(dt2$STD_NETRAD) ]               
  if (class(dt2$STD_NETRAD)=="character") dt2$STD_NETRAD <-as.numeric(dt2$STD_NETRAD)
  if (class(dt2$MIN_NETRAD)=="factor") dt2$MIN_NETRAD <-as.numeric(levels(dt2$MIN_NETRAD))[as.integer(dt2$MIN_NETRAD) ]               
  if (class(dt2$MIN_NETRAD)=="character") dt2$MIN_NETRAD <-as.numeric(dt2$MIN_NETRAD)
  if (class(dt2$MAX_NETRAD)=="factor") dt2$MAX_NETRAD <-as.numeric(levels(dt2$MAX_NETRAD))[as.integer(dt2$MAX_NETRAD) ]               
  if (class(dt2$MAX_NETRAD)=="character") dt2$MAX_NETRAD <-as.numeric(dt2$MAX_NETRAD)
  if (class(dt2$N_NETRAD)=="factor") dt2$N_NETRAD <-as.numeric(levels(dt2$N_NETRAD))[as.integer(dt2$N_NETRAD) ]               
  if (class(dt2$N_NETRAD)=="character") dt2$N_NETRAD <-as.numeric(dt2$N_NETRAD)
  if (class(dt2$AVG_UVA)=="factor") dt2$AVG_UVA <-as.numeric(levels(dt2$AVG_UVA))[as.integer(dt2$AVG_UVA) ]               
  if (class(dt2$AVG_UVA)=="character") dt2$AVG_UVA <-as.numeric(dt2$AVG_UVA)
  if (class(dt2$STD_UVA)=="factor") dt2$STD_UVA <-as.numeric(levels(dt2$STD_UVA))[as.integer(dt2$STD_UVA) ]               
  if (class(dt2$STD_UVA)=="character") dt2$STD_UVA <-as.numeric(dt2$STD_UVA)
  if (class(dt2$MIN_UVA)=="factor") dt2$MIN_UVA <-as.numeric(levels(dt2$MIN_UVA))[as.integer(dt2$MIN_UVA) ]               
  if (class(dt2$MIN_UVA)=="character") dt2$MIN_UVA <-as.numeric(dt2$MIN_UVA)
  if (class(dt2$MAX_UVA)=="factor") dt2$MAX_UVA <-as.numeric(levels(dt2$MAX_UVA))[as.integer(dt2$MAX_UVA) ]               
  if (class(dt2$MAX_UVA)=="character") dt2$MAX_UVA <-as.numeric(dt2$MAX_UVA)
  if (class(dt2$N_UVA)=="factor") dt2$N_UVA <-as.numeric(levels(dt2$N_UVA))[as.integer(dt2$N_UVA) ]               
  if (class(dt2$N_UVA)=="character") dt2$N_UVA <-as.numeric(dt2$N_UVA)
  if (class(dt2$AVG_UVB)=="factor") dt2$AVG_UVB <-as.numeric(levels(dt2$AVG_UVB))[as.integer(dt2$AVG_UVB) ]               
  if (class(dt2$AVG_UVB)=="character") dt2$AVG_UVB <-as.numeric(dt2$AVG_UVB)
  if (class(dt2$STD_UVB)=="factor") dt2$STD_UVB <-as.numeric(levels(dt2$STD_UVB))[as.integer(dt2$STD_UVB) ]               
  if (class(dt2$STD_UVB)=="character") dt2$STD_UVB <-as.numeric(dt2$STD_UVB)
  if (class(dt2$MIN_UVB)=="factor") dt2$MIN_UVB <-as.numeric(levels(dt2$MIN_UVB))[as.integer(dt2$MIN_UVB) ]               
  if (class(dt2$MIN_UVB)=="character") dt2$MIN_UVB <-as.numeric(dt2$MIN_UVB)
  if (class(dt2$MAX_UVB)=="factor") dt2$MAX_UVB <-as.numeric(levels(dt2$MAX_UVB))[as.integer(dt2$MAX_UVB) ]               
  if (class(dt2$MAX_UVB)=="character") dt2$MAX_UVB <-as.numeric(dt2$MAX_UVB)
  if (class(dt2$N_UVB)=="factor") dt2$N_UVB <-as.numeric(levels(dt2$N_UVB))[as.integer(dt2$N_UVB) ]               
  if (class(dt2$N_UVB)=="character") dt2$N_UVB <-as.numeric(dt2$N_UVB)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$STD_PAR <- ifelse((trimws(as.character(dt2$STD_PAR))==trimws("Null")),NA,dt2$STD_PAR)               
  suppressWarnings(dt2$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_PAR))==as.character(as.numeric("Null"))),NA,dt2$STD_PAR))
  dt2$MIN_PAR <- ifelse((trimws(as.character(dt2$MIN_PAR))==trimws("Null")),NA,dt2$MIN_PAR)               
  suppressWarnings(dt2$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt2$MIN_PAR))
  dt2$MAX_PAR <- ifelse((trimws(as.character(dt2$MAX_PAR))==trimws("Null")),NA,dt2$MAX_PAR)               
  suppressWarnings(dt2$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt2$MAX_PAR))
  dt2$STD_SWRADIN <- ifelse((trimws(as.character(dt2$STD_SWRADIN))==trimws("Null")),NA,dt2$STD_SWRADIN)               
  suppressWarnings(dt2$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADIN))
  dt2$MIN_SWRADIN <- ifelse((trimws(as.character(dt2$MIN_SWRADIN))==trimws("Null")),NA,dt2$MIN_SWRADIN)               
  suppressWarnings(dt2$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADIN))
  dt2$MAX_SWRADIN <- ifelse((trimws(as.character(dt2$MAX_SWRADIN))==trimws("Null")),NA,dt2$MAX_SWRADIN)               
  suppressWarnings(dt2$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADIN))
  dt2$STD_SWRADOUT <- ifelse((trimws(as.character(dt2$STD_SWRADOUT))==trimws("Null")),NA,dt2$STD_SWRADOUT)               
  suppressWarnings(dt2$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADOUT))
  dt2$MIN_SWRADOUT <- ifelse((trimws(as.character(dt2$MIN_SWRADOUT))==trimws("Null")),NA,dt2$MIN_SWRADOUT)               
  suppressWarnings(dt2$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADOUT))
  dt2$MAX_SWRADOUT <- ifelse((trimws(as.character(dt2$MAX_SWRADOUT))==trimws("Null")),NA,dt2$MAX_SWRADOUT)               
  suppressWarnings(dt2$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADOUT))
  dt2$STD_NETRAD <- ifelse((trimws(as.character(dt2$STD_NETRAD))==trimws("Null")),NA,dt2$STD_NETRAD)               
  suppressWarnings(dt2$STD_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_NETRAD))==as.character(as.numeric("Null"))),NA,dt2$STD_NETRAD))
  dt2$MAX_NETRAD <- ifelse((trimws(as.character(dt2$MAX_NETRAD))==trimws("Null")),NA,dt2$MAX_NETRAD)               
  suppressWarnings(dt2$MAX_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_NETRAD))==as.character(as.numeric("Null"))),NA,dt2$MAX_NETRAD))
  dt2$AVG_UVA <- ifelse((trimws(as.character(dt2$AVG_UVA))==trimws("Null")),NA,dt2$AVG_UVA)               
  suppressWarnings(dt2$AVG_UVA <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_UVA))==as.character(as.numeric("Null"))),NA,dt2$AVG_UVA))
  dt2$STD_UVA <- ifelse((trimws(as.character(dt2$STD_UVA))==trimws("Null")),NA,dt2$STD_UVA)               
  suppressWarnings(dt2$STD_UVA <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_UVA))==as.character(as.numeric("Null"))),NA,dt2$STD_UVA))
  dt2$MIN_UVA <- ifelse((trimws(as.character(dt2$MIN_UVA))==trimws("Null")),NA,dt2$MIN_UVA)               
  suppressWarnings(dt2$MIN_UVA <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_UVA))==as.character(as.numeric("Null"))),NA,dt2$MIN_UVA))
  dt2$MAX_UVA <- ifelse((trimws(as.character(dt2$MAX_UVA))==trimws("Null")),NA,dt2$MAX_UVA)               
  suppressWarnings(dt2$MAX_UVA <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_UVA))==as.character(as.numeric("Null"))),NA,dt2$MAX_UVA))
  dt2$AVG_UVB <- ifelse((trimws(as.character(dt2$AVG_UVB))==trimws("Null")),NA,dt2$AVG_UVB)               
  suppressWarnings(dt2$AVG_UVB <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_UVB))==as.character(as.numeric("Null"))),NA,dt2$AVG_UVB))
  dt2$STD_UVB <- ifelse((trimws(as.character(dt2$STD_UVB))==trimws("Null")),NA,dt2$STD_UVB)               
  suppressWarnings(dt2$STD_UVB <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_UVB))==as.character(as.numeric("Null"))),NA,dt2$STD_UVB))
  dt2$MIN_UVB <- ifelse((trimws(as.character(dt2$MIN_UVB))==trimws("Null")),NA,dt2$MIN_UVB)               
  suppressWarnings(dt2$MIN_UVB <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_UVB))==as.character(as.numeric("Null"))),NA,dt2$MIN_UVB))
  dt2$MAX_UVB <- ifelse((trimws(as.character(dt2$MAX_UVB))==trimws("Null")),NA,dt2$MAX_UVB)               
  suppressWarnings(dt2$MAX_UVB <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_UVB))==as.character(as.numeric("Null"))),NA,dt2$MAX_UVB))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(AVG_NETRAD)
  summary(STD_NETRAD)
  summary(MIN_NETRAD)
  summary(MAX_NETRAD)
  summary(N_NETRAD)
  summary(AVG_UVA)
  summary(STD_UVA)
  summary(MIN_UVA)
  summary(MAX_UVA)
  summary(N_UVA)
  summary(AVG_UVB)
  summary(STD_UVB)
  summary(MIN_UVB)
  summary(MAX_UVB)
  summary(N_UVB)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/153e3057897a08af9c0ec6b6d828fa05" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_RH)=="factor") dt3$AVG_RH <-as.numeric(levels(dt3$AVG_RH))[as.integer(dt3$AVG_RH) ]               
  if (class(dt3$AVG_RH)=="character") dt3$AVG_RH <-as.numeric(dt3$AVG_RH)
  if (class(dt3$STD_RH)=="factor") dt3$STD_RH <-as.numeric(levels(dt3$STD_RH))[as.integer(dt3$STD_RH) ]               
  if (class(dt3$STD_RH)=="character") dt3$STD_RH <-as.numeric(dt3$STD_RH)
  if (class(dt3$MIN_RH)=="factor") dt3$MIN_RH <-as.numeric(levels(dt3$MIN_RH))[as.integer(dt3$MIN_RH) ]               
  if (class(dt3$MIN_RH)=="character") dt3$MIN_RH <-as.numeric(dt3$MIN_RH)
  if (class(dt3$MAX_RH)=="factor") dt3$MAX_RH <-as.numeric(levels(dt3$MAX_RH))[as.integer(dt3$MAX_RH) ]               
  if (class(dt3$MAX_RH)=="character") dt3$MAX_RH <-as.numeric(dt3$MAX_RH)
  if (class(dt3$N_RH)=="factor") dt3$N_RH <-as.numeric(levels(dt3$N_RH))[as.integer(dt3$N_RH) ]               
  if (class(dt3$N_RH)=="character") dt3$N_RH <-as.numeric(dt3$N_RH)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/d6dd6ac8f8c20aeea878ccb0736fe573" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_SOILT0CM)=="factor") dt4$AVG_SOILT0CM <-as.numeric(levels(dt4$AVG_SOILT0CM))[as.integer(dt4$AVG_SOILT0CM) ]               
  if (class(dt4$AVG_SOILT0CM)=="character") dt4$AVG_SOILT0CM <-as.numeric(dt4$AVG_SOILT0CM)
  if (class(dt4$STD_SOILT0CM)=="factor") dt4$STD_SOILT0CM <-as.numeric(levels(dt4$STD_SOILT0CM))[as.integer(dt4$STD_SOILT0CM) ]               
  if (class(dt4$STD_SOILT0CM)=="character") dt4$STD_SOILT0CM <-as.numeric(dt4$STD_SOILT0CM)
  if (class(dt4$MIN_SOILT0CM)=="factor") dt4$MIN_SOILT0CM <-as.numeric(levels(dt4$MIN_SOILT0CM))[as.integer(dt4$MIN_SOILT0CM) ]               
  if (class(dt4$MIN_SOILT0CM)=="character") dt4$MIN_SOILT0CM <-as.numeric(dt4$MIN_SOILT0CM)
  if (class(dt4$MAX_SOILT0CM)=="factor") dt4$MAX_SOILT0CM <-as.numeric(levels(dt4$MAX_SOILT0CM))[as.integer(dt4$MAX_SOILT0CM) ]               
  if (class(dt4$MAX_SOILT0CM)=="character") dt4$MAX_SOILT0CM <-as.numeric(dt4$MAX_SOILT0CM)
  if (class(dt4$N_SOILT0CM)=="factor") dt4$N_SOILT0CM <-as.numeric(levels(dt4$N_SOILT0CM))[as.integer(dt4$N_SOILT0CM) ]               
  if (class(dt4$N_SOILT0CM)=="character") dt4$N_SOILT0CM <-as.numeric(dt4$N_SOILT0CM)
  if (class(dt4$AVG_SOILT5CM)=="factor") dt4$AVG_SOILT5CM <-as.numeric(levels(dt4$AVG_SOILT5CM))[as.integer(dt4$AVG_SOILT5CM) ]               
  if (class(dt4$AVG_SOILT5CM)=="character") dt4$AVG_SOILT5CM <-as.numeric(dt4$AVG_SOILT5CM)
  if (class(dt4$STD_SOILT5CM)=="factor") dt4$STD_SOILT5CM <-as.numeric(levels(dt4$STD_SOILT5CM))[as.integer(dt4$STD_SOILT5CM) ]               
  if (class(dt4$STD_SOILT5CM)=="character") dt4$STD_SOILT5CM <-as.numeric(dt4$STD_SOILT5CM)
  if (class(dt4$MIN_SOILT5CM)=="factor") dt4$MIN_SOILT5CM <-as.numeric(levels(dt4$MIN_SOILT5CM))[as.integer(dt4$MIN_SOILT5CM) ]               
  if (class(dt4$MIN_SOILT5CM)=="character") dt4$MIN_SOILT5CM <-as.numeric(dt4$MIN_SOILT5CM)
  if (class(dt4$MAX_SOILT5CM)=="factor") dt4$MAX_SOILT5CM <-as.numeric(levels(dt4$MAX_SOILT5CM))[as.integer(dt4$MAX_SOILT5CM) ]               
  if (class(dt4$MAX_SOILT5CM)=="character") dt4$MAX_SOILT5CM <-as.numeric(dt4$MAX_SOILT5CM)
  if (class(dt4$N_SOILT5CM)=="factor") dt4$N_SOILT5CM <-as.numeric(levels(dt4$N_SOILT5CM))[as.integer(dt4$N_SOILT5CM) ]               
  if (class(dt4$N_SOILT5CM)=="character") dt4$N_SOILT5CM <-as.numeric(dt4$N_SOILT5CM)
  if (class(dt4$AVG_SOILT10CM)=="factor") dt4$AVG_SOILT10CM <-as.numeric(levels(dt4$AVG_SOILT10CM))[as.integer(dt4$AVG_SOILT10CM) ]               
  if (class(dt4$AVG_SOILT10CM)=="character") dt4$AVG_SOILT10CM <-as.numeric(dt4$AVG_SOILT10CM)
  if (class(dt4$STD_SOILT10CM)=="factor") dt4$STD_SOILT10CM <-as.numeric(levels(dt4$STD_SOILT10CM))[as.integer(dt4$STD_SOILT10CM) ]               
  if (class(dt4$STD_SOILT10CM)=="character") dt4$STD_SOILT10CM <-as.numeric(dt4$STD_SOILT10CM)
  if (class(dt4$MIN_SOILT10CM)=="factor") dt4$MIN_SOILT10CM <-as.numeric(levels(dt4$MIN_SOILT10CM))[as.integer(dt4$MIN_SOILT10CM) ]               
  if (class(dt4$MIN_SOILT10CM)=="character") dt4$MIN_SOILT10CM <-as.numeric(dt4$MIN_SOILT10CM)
  if (class(dt4$MAX_SOILT10CM)=="factor") dt4$MAX_SOILT10CM <-as.numeric(levels(dt4$MAX_SOILT10CM))[as.integer(dt4$MAX_SOILT10CM) ]               
  if (class(dt4$MAX_SOILT10CM)=="character") dt4$MAX_SOILT10CM <-as.numeric(dt4$MAX_SOILT10CM)
  if (class(dt4$N_SOILT10CM)=="factor") dt4$N_SOILT10CM <-as.numeric(levels(dt4$N_SOILT10CM))[as.integer(dt4$N_SOILT10CM) ]               
  if (class(dt4$N_SOILT10CM)=="character") dt4$N_SOILT10CM <-as.numeric(dt4$N_SOILT10CM)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_SOILT0CM <- ifelse((trimws(as.character(dt4$AVG_SOILT0CM))==trimws("Null")),NA,dt4$AVG_SOILT0CM)               
  suppressWarnings(dt4$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT0CM))
  dt4$STD_SOILT0CM <- ifelse((trimws(as.character(dt4$STD_SOILT0CM))==trimws("Null")),NA,dt4$STD_SOILT0CM)               
  suppressWarnings(dt4$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT0CM))
  dt4$MIN_SOILT0CM <- ifelse((trimws(as.character(dt4$MIN_SOILT0CM))==trimws("Null")),NA,dt4$MIN_SOILT0CM)               
  suppressWarnings(dt4$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT0CM))
  dt4$MAX_SOILT0CM <- ifelse((trimws(as.character(dt4$MAX_SOILT0CM))==trimws("Null")),NA,dt4$MAX_SOILT0CM)               
  suppressWarnings(dt4$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT0CM))
  dt4$AVG_SOILT5CM <- ifelse((trimws(as.character(dt4$AVG_SOILT5CM))==trimws("Null")),NA,dt4$AVG_SOILT5CM)               
  suppressWarnings(dt4$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT5CM))
  dt4$STD_SOILT5CM <- ifelse((trimws(as.character(dt4$STD_SOILT5CM))==trimws("Null")),NA,dt4$STD_SOILT5CM)               
  suppressWarnings(dt4$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT5CM))
  dt4$MIN_SOILT5CM <- ifelse((trimws(as.character(dt4$MIN_SOILT5CM))==trimws("Null")),NA,dt4$MIN_SOILT5CM)               
  suppressWarnings(dt4$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT5CM))
  dt4$MAX_SOILT5CM <- ifelse((trimws(as.character(dt4$MAX_SOILT5CM))==trimws("Null")),NA,dt4$MAX_SOILT5CM)               
  suppressWarnings(dt4$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT5CM))
  dt4$AVG_SOILT10CM <- ifelse((trimws(as.character(dt4$AVG_SOILT10CM))==trimws("Null")),NA,dt4$AVG_SOILT10CM)               
  suppressWarnings(dt4$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT10CM))
  dt4$STD_SOILT10CM <- ifelse((trimws(as.character(dt4$STD_SOILT10CM))==trimws("Null")),NA,dt4$STD_SOILT10CM)               
  suppressWarnings(dt4$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT10CM))
  dt4$MIN_SOILT10CM <- ifelse((trimws(as.character(dt4$MIN_SOILT10CM))==trimws("Null")),NA,dt4$MIN_SOILT10CM)               
  suppressWarnings(dt4$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT10CM))
  dt4$MAX_SOILT10CM <- ifelse((trimws(as.character(dt4$MAX_SOILT10CM))==trimws("Null")),NA,dt4$MAX_SOILT10CM)               
  suppressWarnings(dt4$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/306b5484f910ef9727ffd831b2f65ed1" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURFCHANGE_CM",     
                   "STD_SURFCHANGE_CM",     
                   "MIN_SURFCHANGE_CM",     
                   "MAX_SURFCHANGE_CM",     
                   "N_SURFCHANGE_CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURFCHANGE_CM)=="factor") dt5$AVG_SURFCHANGE_CM <-as.numeric(levels(dt5$AVG_SURFCHANGE_CM))[as.integer(dt5$AVG_SURFCHANGE_CM) ]               
  if (class(dt5$AVG_SURFCHANGE_CM)=="character") dt5$AVG_SURFCHANGE_CM <-as.numeric(dt5$AVG_SURFCHANGE_CM)
  if (class(dt5$STD_SURFCHANGE_CM)=="factor") dt5$STD_SURFCHANGE_CM <-as.numeric(levels(dt5$STD_SURFCHANGE_CM))[as.integer(dt5$STD_SURFCHANGE_CM) ]               
  if (class(dt5$STD_SURFCHANGE_CM)=="character") dt5$STD_SURFCHANGE_CM <-as.numeric(dt5$STD_SURFCHANGE_CM)
  if (class(dt5$MIN_SURFCHANGE_CM)=="factor") dt5$MIN_SURFCHANGE_CM <-as.numeric(levels(dt5$MIN_SURFCHANGE_CM))[as.integer(dt5$MIN_SURFCHANGE_CM) ]               
  if (class(dt5$MIN_SURFCHANGE_CM)=="character") dt5$MIN_SURFCHANGE_CM <-as.numeric(dt5$MIN_SURFCHANGE_CM)
  if (class(dt5$MAX_SURFCHANGE_CM)=="factor") dt5$MAX_SURFCHANGE_CM <-as.numeric(levels(dt5$MAX_SURFCHANGE_CM))[as.integer(dt5$MAX_SURFCHANGE_CM) ]               
  if (class(dt5$MAX_SURFCHANGE_CM)=="character") dt5$MAX_SURFCHANGE_CM <-as.numeric(dt5$MAX_SURFCHANGE_CM)
  if (class(dt5$N_SURFCHANGE_CM)=="factor") dt5$N_SURFCHANGE_CM <-as.numeric(levels(dt5$N_SURFCHANGE_CM))[as.integer(dt5$N_SURFCHANGE_CM) ]               
  if (class(dt5$N_SURFCHANGE_CM)=="character") dt5$N_SURFCHANGE_CM <-as.numeric(dt5$N_SURFCHANGE_CM)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURFCHANGE_CM <- ifelse((trimws(as.character(dt5$AVG_SURFCHANGE_CM))==trimws("Null")),NA,dt5$AVG_SURFCHANGE_CM)               
  suppressWarnings(dt5$AVG_SURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURFCHANGE_CM))
  dt5$STD_SURFCHANGE_CM <- ifelse((trimws(as.character(dt5$STD_SURFCHANGE_CM))==trimws("Null")),NA,dt5$STD_SURFCHANGE_CM)               
  suppressWarnings(dt5$STD_SURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt5$STD_SURFCHANGE_CM))
  dt5$MIN_SURFCHANGE_CM <- ifelse((trimws(as.character(dt5$MIN_SURFCHANGE_CM))==trimws("Null")),NA,dt5$MIN_SURFCHANGE_CM)               
  suppressWarnings(dt5$MIN_SURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURFCHANGE_CM))
  dt5$MAX_SURFCHANGE_CM <- ifelse((trimws(as.character(dt5$MAX_SURFCHANGE_CM))==trimws("Null")),NA,dt5$MAX_SURFCHANGE_CM)               
  suppressWarnings(dt5$MAX_SURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURFCHANGE_CM))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURFCHANGE_CM)
  summary(STD_SURFCHANGE_CM)
  summary(MIN_SURFCHANGE_CM)
  summary(MAX_SURFCHANGE_CM)
  summary(N_SURFCHANGE_CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7105/8/3cc748b83e906fb5f85c43acdc0f1c33" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt2
  humidity <- dt3
  soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7273/download?token=vmd6meyGBjgJMQrSq1-vi_5vnhRDW9detLB6mQ-IuUo")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
  
}

if(location == "Lake Fryxell"){
  
  pdf('LakeFryxellgraphs.pdf')
  
  # Package ID: knb-lter-mcm.7110.8 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Fryxell Meteorological Station (FRLM), McMurdo Dry Valleys, Antarctica (1993-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/7161f25181d56e9ef690cc7662640c1f" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "AVG_AIRTDEL3M1",     
                   "STD_AIRTDEL3M1",     
                   "MIN_AIRTDEL3M1",     
                   "MAX_AIRTDEL3M1",     
                   "N_AIRTDEL3M1",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$AVG_AIRTDEL3M1)=="factor") dt1$AVG_AIRTDEL3M1 <-as.numeric(levels(dt1$AVG_AIRTDEL3M1))[as.integer(dt1$AVG_AIRTDEL3M1) ]               
  if (class(dt1$AVG_AIRTDEL3M1)=="character") dt1$AVG_AIRTDEL3M1 <-as.numeric(dt1$AVG_AIRTDEL3M1)
  if (class(dt1$STD_AIRTDEL3M1)=="factor") dt1$STD_AIRTDEL3M1 <-as.numeric(levels(dt1$STD_AIRTDEL3M1))[as.integer(dt1$STD_AIRTDEL3M1) ]               
  if (class(dt1$STD_AIRTDEL3M1)=="character") dt1$STD_AIRTDEL3M1 <-as.numeric(dt1$STD_AIRTDEL3M1)
  if (class(dt1$MIN_AIRTDEL3M1)=="factor") dt1$MIN_AIRTDEL3M1 <-as.numeric(levels(dt1$MIN_AIRTDEL3M1))[as.integer(dt1$MIN_AIRTDEL3M1) ]               
  if (class(dt1$MIN_AIRTDEL3M1)=="character") dt1$MIN_AIRTDEL3M1 <-as.numeric(dt1$MIN_AIRTDEL3M1)
  if (class(dt1$MAX_AIRTDEL3M1)=="factor") dt1$MAX_AIRTDEL3M1 <-as.numeric(levels(dt1$MAX_AIRTDEL3M1))[as.integer(dt1$MAX_AIRTDEL3M1) ]               
  if (class(dt1$MAX_AIRTDEL3M1)=="character") dt1$MAX_AIRTDEL3M1 <-as.numeric(dt1$MAX_AIRTDEL3M1)
  if (class(dt1$N_AIRTDEL3M1)=="factor") dt1$N_AIRTDEL3M1 <-as.numeric(levels(dt1$N_AIRTDEL3M1))[as.integer(dt1$N_AIRTDEL3M1) ]               
  if (class(dt1$N_AIRTDEL3M1)=="character") dt1$N_AIRTDEL3M1 <-as.numeric(dt1$N_AIRTDEL3M1)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$AVG_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$AVG_AIRTDEL3M1))==trimws("Null")),NA,dt1$AVG_AIRTDEL3M1)               
  suppressWarnings(dt1$AVG_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRTDEL3M1))
  dt1$STD_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$STD_AIRTDEL3M1))==trimws("Null")),NA,dt1$STD_AIRTDEL3M1)               
  suppressWarnings(dt1$STD_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRTDEL3M1))
  dt1$MIN_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MIN_AIRTDEL3M1))==trimws("Null")),NA,dt1$MIN_AIRTDEL3M1)               
  suppressWarnings(dt1$MIN_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRTDEL3M1))
  dt1$MAX_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MAX_AIRTDEL3M1))==trimws("Null")),NA,dt1$MAX_AIRTDEL3M1)               
  suppressWarnings(dt1$MAX_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRTDEL3M1))
  dt1$N_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$N_AIRTDEL3M1))==trimws("Null")),NA,dt1$N_AIRTDEL3M1)               
  suppressWarnings(dt1$N_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$N_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$N_AIRTDEL3M1))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(AVG_AIRTDEL3M1)
  summary(STD_AIRTDEL3M1)
  summary(MIN_AIRTDEL3M1)
  summary(MAX_AIRTDEL3M1)
  summary(N_AIRTDEL3M1)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/ad2f5e85f4f8062e1c8234ebdce5f2dc" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PAR)=="factor") dt2$AVG_PAR <-as.numeric(levels(dt2$AVG_PAR))[as.integer(dt2$AVG_PAR) ]               
  if (class(dt2$AVG_PAR)=="character") dt2$AVG_PAR <-as.numeric(dt2$AVG_PAR)
  if (class(dt2$STD_PAR)=="factor") dt2$STD_PAR <-as.numeric(levels(dt2$STD_PAR))[as.integer(dt2$STD_PAR) ]               
  if (class(dt2$STD_PAR)=="character") dt2$STD_PAR <-as.numeric(dt2$STD_PAR)
  if (class(dt2$MIN_PAR)=="factor") dt2$MIN_PAR <-as.numeric(levels(dt2$MIN_PAR))[as.integer(dt2$MIN_PAR) ]               
  if (class(dt2$MIN_PAR)=="character") dt2$MIN_PAR <-as.numeric(dt2$MIN_PAR)
  if (class(dt2$MAX_PAR)=="factor") dt2$MAX_PAR <-as.numeric(levels(dt2$MAX_PAR))[as.integer(dt2$MAX_PAR) ]               
  if (class(dt2$MAX_PAR)=="character") dt2$MAX_PAR <-as.numeric(dt2$MAX_PAR)
  if (class(dt2$N_PAR)=="factor") dt2$N_PAR <-as.numeric(levels(dt2$N_PAR))[as.integer(dt2$N_PAR) ]               
  if (class(dt2$N_PAR)=="character") dt2$N_PAR <-as.numeric(dt2$N_PAR)
  if (class(dt2$AVG_SWRADIN)=="factor") dt2$AVG_SWRADIN <-as.numeric(levels(dt2$AVG_SWRADIN))[as.integer(dt2$AVG_SWRADIN) ]               
  if (class(dt2$AVG_SWRADIN)=="character") dt2$AVG_SWRADIN <-as.numeric(dt2$AVG_SWRADIN)
  if (class(dt2$STD_SWRADIN)=="factor") dt2$STD_SWRADIN <-as.numeric(levels(dt2$STD_SWRADIN))[as.integer(dt2$STD_SWRADIN) ]               
  if (class(dt2$STD_SWRADIN)=="character") dt2$STD_SWRADIN <-as.numeric(dt2$STD_SWRADIN)
  if (class(dt2$MIN_SWRADIN)=="factor") dt2$MIN_SWRADIN <-as.numeric(levels(dt2$MIN_SWRADIN))[as.integer(dt2$MIN_SWRADIN) ]               
  if (class(dt2$MIN_SWRADIN)=="character") dt2$MIN_SWRADIN <-as.numeric(dt2$MIN_SWRADIN)
  if (class(dt2$MAX_SWRADIN)=="factor") dt2$MAX_SWRADIN <-as.numeric(levels(dt2$MAX_SWRADIN))[as.integer(dt2$MAX_SWRADIN) ]               
  if (class(dt2$MAX_SWRADIN)=="character") dt2$MAX_SWRADIN <-as.numeric(dt2$MAX_SWRADIN)
  if (class(dt2$N_SWRADIN)=="factor") dt2$N_SWRADIN <-as.numeric(levels(dt2$N_SWRADIN))[as.integer(dt2$N_SWRADIN) ]               
  if (class(dt2$N_SWRADIN)=="character") dt2$N_SWRADIN <-as.numeric(dt2$N_SWRADIN)
  if (class(dt2$AVG_SWRADOUT)=="factor") dt2$AVG_SWRADOUT <-as.numeric(levels(dt2$AVG_SWRADOUT))[as.integer(dt2$AVG_SWRADOUT) ]               
  if (class(dt2$AVG_SWRADOUT)=="character") dt2$AVG_SWRADOUT <-as.numeric(dt2$AVG_SWRADOUT)
  if (class(dt2$STD_SWRADOUT)=="factor") dt2$STD_SWRADOUT <-as.numeric(levels(dt2$STD_SWRADOUT))[as.integer(dt2$STD_SWRADOUT) ]               
  if (class(dt2$STD_SWRADOUT)=="character") dt2$STD_SWRADOUT <-as.numeric(dt2$STD_SWRADOUT)
  if (class(dt2$MIN_SWRADOUT)=="factor") dt2$MIN_SWRADOUT <-as.numeric(levels(dt2$MIN_SWRADOUT))[as.integer(dt2$MIN_SWRADOUT) ]               
  if (class(dt2$MIN_SWRADOUT)=="character") dt2$MIN_SWRADOUT <-as.numeric(dt2$MIN_SWRADOUT)
  if (class(dt2$MAX_SWRADOUT)=="factor") dt2$MAX_SWRADOUT <-as.numeric(levels(dt2$MAX_SWRADOUT))[as.integer(dt2$MAX_SWRADOUT) ]               
  if (class(dt2$MAX_SWRADOUT)=="character") dt2$MAX_SWRADOUT <-as.numeric(dt2$MAX_SWRADOUT)
  if (class(dt2$N_SWRADOUT)=="factor") dt2$N_SWRADOUT <-as.numeric(levels(dt2$N_SWRADOUT))[as.integer(dt2$N_SWRADOUT) ]               
  if (class(dt2$N_SWRADOUT)=="character") dt2$N_SWRADOUT <-as.numeric(dt2$N_SWRADOUT)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PAR <- ifelse((trimws(as.character(dt2$AVG_PAR))==trimws("Null")),NA,dt2$AVG_PAR)               
  suppressWarnings(dt2$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt2$AVG_PAR))
  dt2$STD_PAR <- ifelse((trimws(as.character(dt2$STD_PAR))==trimws("Null")),NA,dt2$STD_PAR)               
  suppressWarnings(dt2$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_PAR))==as.character(as.numeric("Null"))),NA,dt2$STD_PAR))
  dt2$MIN_PAR <- ifelse((trimws(as.character(dt2$MIN_PAR))==trimws("Null")),NA,dt2$MIN_PAR)               
  suppressWarnings(dt2$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt2$MIN_PAR))
  dt2$MAX_PAR <- ifelse((trimws(as.character(dt2$MAX_PAR))==trimws("Null")),NA,dt2$MAX_PAR)               
  suppressWarnings(dt2$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt2$MAX_PAR))
  dt2$AVG_SWRADIN <- ifelse((trimws(as.character(dt2$AVG_SWRADIN))==trimws("Null")),NA,dt2$AVG_SWRADIN)               
  suppressWarnings(dt2$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADIN))
  dt2$STD_SWRADIN <- ifelse((trimws(as.character(dt2$STD_SWRADIN))==trimws("Null")),NA,dt2$STD_SWRADIN)               
  suppressWarnings(dt2$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADIN))
  dt2$MIN_SWRADIN <- ifelse((trimws(as.character(dt2$MIN_SWRADIN))==trimws("Null")),NA,dt2$MIN_SWRADIN)               
  suppressWarnings(dt2$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADIN))
  dt2$MAX_SWRADIN <- ifelse((trimws(as.character(dt2$MAX_SWRADIN))==trimws("Null")),NA,dt2$MAX_SWRADIN)               
  suppressWarnings(dt2$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADIN))
  dt2$AVG_SWRADOUT <- ifelse((trimws(as.character(dt2$AVG_SWRADOUT))==trimws("Null")),NA,dt2$AVG_SWRADOUT)               
  suppressWarnings(dt2$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADOUT))
  dt2$STD_SWRADOUT <- ifelse((trimws(as.character(dt2$STD_SWRADOUT))==trimws("Null")),NA,dt2$STD_SWRADOUT)               
  suppressWarnings(dt2$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADOUT))
  dt2$MIN_SWRADOUT <- ifelse((trimws(as.character(dt2$MIN_SWRADOUT))==trimws("Null")),NA,dt2$MIN_SWRADOUT)               
  suppressWarnings(dt2$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADOUT))
  dt2$MAX_SWRADOUT <- ifelse((trimws(as.character(dt2$MAX_SWRADOUT))==trimws("Null")),NA,dt2$MAX_SWRADOUT)               
  suppressWarnings(dt2$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/99f0fb5807ba945aaebda0a8b979ac4d" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_RH)=="factor") dt3$AVG_RH <-as.numeric(levels(dt3$AVG_RH))[as.integer(dt3$AVG_RH) ]               
  if (class(dt3$AVG_RH)=="character") dt3$AVG_RH <-as.numeric(dt3$AVG_RH)
  if (class(dt3$STD_RH)=="factor") dt3$STD_RH <-as.numeric(levels(dt3$STD_RH))[as.integer(dt3$STD_RH) ]               
  if (class(dt3$STD_RH)=="character") dt3$STD_RH <-as.numeric(dt3$STD_RH)
  if (class(dt3$MIN_RH)=="factor") dt3$MIN_RH <-as.numeric(levels(dt3$MIN_RH))[as.integer(dt3$MIN_RH) ]               
  if (class(dt3$MIN_RH)=="character") dt3$MIN_RH <-as.numeric(dt3$MIN_RH)
  if (class(dt3$MAX_RH)=="factor") dt3$MAX_RH <-as.numeric(levels(dt3$MAX_RH))[as.integer(dt3$MAX_RH) ]               
  if (class(dt3$MAX_RH)=="character") dt3$MAX_RH <-as.numeric(dt3$MAX_RH)
  if (class(dt3$N_RH)=="factor") dt3$N_RH <-as.numeric(levels(dt3$N_RH))[as.integer(dt3$N_RH) ]               
  if (class(dt3$N_RH)=="character") dt3$N_RH <-as.numeric(dt3$N_RH)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/1f1461556feaebe00409cdd7c6b9c443" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_SOILT0CM)=="factor") dt4$AVG_SOILT0CM <-as.numeric(levels(dt4$AVG_SOILT0CM))[as.integer(dt4$AVG_SOILT0CM) ]               
  if (class(dt4$AVG_SOILT0CM)=="character") dt4$AVG_SOILT0CM <-as.numeric(dt4$AVG_SOILT0CM)
  if (class(dt4$STD_SOILT0CM)=="factor") dt4$STD_SOILT0CM <-as.numeric(levels(dt4$STD_SOILT0CM))[as.integer(dt4$STD_SOILT0CM) ]               
  if (class(dt4$STD_SOILT0CM)=="character") dt4$STD_SOILT0CM <-as.numeric(dt4$STD_SOILT0CM)
  if (class(dt4$MIN_SOILT0CM)=="factor") dt4$MIN_SOILT0CM <-as.numeric(levels(dt4$MIN_SOILT0CM))[as.integer(dt4$MIN_SOILT0CM) ]               
  if (class(dt4$MIN_SOILT0CM)=="character") dt4$MIN_SOILT0CM <-as.numeric(dt4$MIN_SOILT0CM)
  if (class(dt4$MAX_SOILT0CM)=="factor") dt4$MAX_SOILT0CM <-as.numeric(levels(dt4$MAX_SOILT0CM))[as.integer(dt4$MAX_SOILT0CM) ]               
  if (class(dt4$MAX_SOILT0CM)=="character") dt4$MAX_SOILT0CM <-as.numeric(dt4$MAX_SOILT0CM)
  if (class(dt4$N_SOILT0CM)=="factor") dt4$N_SOILT0CM <-as.numeric(levels(dt4$N_SOILT0CM))[as.integer(dt4$N_SOILT0CM) ]               
  if (class(dt4$N_SOILT0CM)=="character") dt4$N_SOILT0CM <-as.numeric(dt4$N_SOILT0CM)
  if (class(dt4$AVG_SOILT5CM)=="factor") dt4$AVG_SOILT5CM <-as.numeric(levels(dt4$AVG_SOILT5CM))[as.integer(dt4$AVG_SOILT5CM) ]               
  if (class(dt4$AVG_SOILT5CM)=="character") dt4$AVG_SOILT5CM <-as.numeric(dt4$AVG_SOILT5CM)
  if (class(dt4$STD_SOILT5CM)=="factor") dt4$STD_SOILT5CM <-as.numeric(levels(dt4$STD_SOILT5CM))[as.integer(dt4$STD_SOILT5CM) ]               
  if (class(dt4$STD_SOILT5CM)=="character") dt4$STD_SOILT5CM <-as.numeric(dt4$STD_SOILT5CM)
  if (class(dt4$MIN_SOILT5CM)=="factor") dt4$MIN_SOILT5CM <-as.numeric(levels(dt4$MIN_SOILT5CM))[as.integer(dt4$MIN_SOILT5CM) ]               
  if (class(dt4$MIN_SOILT5CM)=="character") dt4$MIN_SOILT5CM <-as.numeric(dt4$MIN_SOILT5CM)
  if (class(dt4$MAX_SOILT5CM)=="factor") dt4$MAX_SOILT5CM <-as.numeric(levels(dt4$MAX_SOILT5CM))[as.integer(dt4$MAX_SOILT5CM) ]               
  if (class(dt4$MAX_SOILT5CM)=="character") dt4$MAX_SOILT5CM <-as.numeric(dt4$MAX_SOILT5CM)
  if (class(dt4$N_SOILT5CM)=="factor") dt4$N_SOILT5CM <-as.numeric(levels(dt4$N_SOILT5CM))[as.integer(dt4$N_SOILT5CM) ]               
  if (class(dt4$N_SOILT5CM)=="character") dt4$N_SOILT5CM <-as.numeric(dt4$N_SOILT5CM)
  if (class(dt4$AVG_SOILT10CM)=="factor") dt4$AVG_SOILT10CM <-as.numeric(levels(dt4$AVG_SOILT10CM))[as.integer(dt4$AVG_SOILT10CM) ]               
  if (class(dt4$AVG_SOILT10CM)=="character") dt4$AVG_SOILT10CM <-as.numeric(dt4$AVG_SOILT10CM)
  if (class(dt4$STD_SOILT10CM)=="factor") dt4$STD_SOILT10CM <-as.numeric(levels(dt4$STD_SOILT10CM))[as.integer(dt4$STD_SOILT10CM) ]               
  if (class(dt4$STD_SOILT10CM)=="character") dt4$STD_SOILT10CM <-as.numeric(dt4$STD_SOILT10CM)
  if (class(dt4$MIN_SOILT10CM)=="factor") dt4$MIN_SOILT10CM <-as.numeric(levels(dt4$MIN_SOILT10CM))[as.integer(dt4$MIN_SOILT10CM) ]               
  if (class(dt4$MIN_SOILT10CM)=="character") dt4$MIN_SOILT10CM <-as.numeric(dt4$MIN_SOILT10CM)
  if (class(dt4$MAX_SOILT10CM)=="factor") dt4$MAX_SOILT10CM <-as.numeric(levels(dt4$MAX_SOILT10CM))[as.integer(dt4$MAX_SOILT10CM) ]               
  if (class(dt4$MAX_SOILT10CM)=="character") dt4$MAX_SOILT10CM <-as.numeric(dt4$MAX_SOILT10CM)
  if (class(dt4$N_SOILT10CM)=="factor") dt4$N_SOILT10CM <-as.numeric(levels(dt4$N_SOILT10CM))[as.integer(dt4$N_SOILT10CM) ]               
  if (class(dt4$N_SOILT10CM)=="character") dt4$N_SOILT10CM <-as.numeric(dt4$N_SOILT10CM)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_SOILT0CM <- ifelse((trimws(as.character(dt4$AVG_SOILT0CM))==trimws("Null")),NA,dt4$AVG_SOILT0CM)               
  suppressWarnings(dt4$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT0CM))
  dt4$STD_SOILT0CM <- ifelse((trimws(as.character(dt4$STD_SOILT0CM))==trimws("Null")),NA,dt4$STD_SOILT0CM)               
  suppressWarnings(dt4$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT0CM))
  dt4$MIN_SOILT0CM <- ifelse((trimws(as.character(dt4$MIN_SOILT0CM))==trimws("Null")),NA,dt4$MIN_SOILT0CM)               
  suppressWarnings(dt4$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT0CM))
  dt4$MAX_SOILT0CM <- ifelse((trimws(as.character(dt4$MAX_SOILT0CM))==trimws("Null")),NA,dt4$MAX_SOILT0CM)               
  suppressWarnings(dt4$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT0CM))
  dt4$AVG_SOILT5CM <- ifelse((trimws(as.character(dt4$AVG_SOILT5CM))==trimws("Null")),NA,dt4$AVG_SOILT5CM)               
  suppressWarnings(dt4$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT5CM))
  dt4$STD_SOILT5CM <- ifelse((trimws(as.character(dt4$STD_SOILT5CM))==trimws("Null")),NA,dt4$STD_SOILT5CM)               
  suppressWarnings(dt4$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT5CM))
  dt4$MIN_SOILT5CM <- ifelse((trimws(as.character(dt4$MIN_SOILT5CM))==trimws("Null")),NA,dt4$MIN_SOILT5CM)               
  suppressWarnings(dt4$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT5CM))
  dt4$MAX_SOILT5CM <- ifelse((trimws(as.character(dt4$MAX_SOILT5CM))==trimws("Null")),NA,dt4$MAX_SOILT5CM)               
  suppressWarnings(dt4$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT5CM))
  dt4$AVG_SOILT10CM <- ifelse((trimws(as.character(dt4$AVG_SOILT10CM))==trimws("Null")),NA,dt4$AVG_SOILT10CM)               
  suppressWarnings(dt4$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT10CM))
  dt4$STD_SOILT10CM <- ifelse((trimws(as.character(dt4$STD_SOILT10CM))==trimws("Null")),NA,dt4$STD_SOILT10CM)               
  suppressWarnings(dt4$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT10CM))
  dt4$MIN_SOILT10CM <- ifelse((trimws(as.character(dt4$MIN_SOILT10CM))==trimws("Null")),NA,dt4$MIN_SOILT10CM)               
  suppressWarnings(dt4$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT10CM))
  dt4$MAX_SOILT10CM <- ifelse((trimws(as.character(dt4$MAX_SOILT10CM))==trimws("Null")),NA,dt4$MAX_SOILT10CM)               
  suppressWarnings(dt4$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/b8210e432b6504d52a3ef62aaa038097" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURFELEVCHANGE",     
                   "STD_SURFELEVCHANGE",     
                   "MIN_SURFELEVCHANGE",     
                   "MAX_SURFELEVCHANGE",     
                   "N_SURFELEVCHANGE",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURFELEVCHANGE)=="factor") dt5$AVG_SURFELEVCHANGE <-as.numeric(levels(dt5$AVG_SURFELEVCHANGE))[as.integer(dt5$AVG_SURFELEVCHANGE) ]               
  if (class(dt5$AVG_SURFELEVCHANGE)=="character") dt5$AVG_SURFELEVCHANGE <-as.numeric(dt5$AVG_SURFELEVCHANGE)
  if (class(dt5$STD_SURFELEVCHANGE)=="factor") dt5$STD_SURFELEVCHANGE <-as.numeric(levels(dt5$STD_SURFELEVCHANGE))[as.integer(dt5$STD_SURFELEVCHANGE) ]               
  if (class(dt5$STD_SURFELEVCHANGE)=="character") dt5$STD_SURFELEVCHANGE <-as.numeric(dt5$STD_SURFELEVCHANGE)
  if (class(dt5$MIN_SURFELEVCHANGE)=="factor") dt5$MIN_SURFELEVCHANGE <-as.numeric(levels(dt5$MIN_SURFELEVCHANGE))[as.integer(dt5$MIN_SURFELEVCHANGE) ]               
  if (class(dt5$MIN_SURFELEVCHANGE)=="character") dt5$MIN_SURFELEVCHANGE <-as.numeric(dt5$MIN_SURFELEVCHANGE)
  if (class(dt5$MAX_SURFELEVCHANGE)=="factor") dt5$MAX_SURFELEVCHANGE <-as.numeric(levels(dt5$MAX_SURFELEVCHANGE))[as.integer(dt5$MAX_SURFELEVCHANGE) ]               
  if (class(dt5$MAX_SURFELEVCHANGE)=="character") dt5$MAX_SURFELEVCHANGE <-as.numeric(dt5$MAX_SURFELEVCHANGE)
  if (class(dt5$N_SURFELEVCHANGE)=="factor") dt5$N_SURFELEVCHANGE <-as.numeric(levels(dt5$N_SURFELEVCHANGE))[as.integer(dt5$N_SURFELEVCHANGE) ]               
  if (class(dt5$N_SURFELEVCHANGE)=="character") dt5$N_SURFELEVCHANGE <-as.numeric(dt5$N_SURFELEVCHANGE)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURFELEVCHANGE <- ifelse((trimws(as.character(dt5$AVG_SURFELEVCHANGE))==trimws("Null")),NA,dt5$AVG_SURFELEVCHANGE)               
  suppressWarnings(dt5$AVG_SURFELEVCHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURFELEVCHANGE))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURFELEVCHANGE))
  dt5$STD_SURFELEVCHANGE <- ifelse((trimws(as.character(dt5$STD_SURFELEVCHANGE))==trimws("Null")),NA,dt5$STD_SURFELEVCHANGE)               
  suppressWarnings(dt5$STD_SURFELEVCHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURFELEVCHANGE))==as.character(as.numeric("Null"))),NA,dt5$STD_SURFELEVCHANGE))
  dt5$MIN_SURFELEVCHANGE <- ifelse((trimws(as.character(dt5$MIN_SURFELEVCHANGE))==trimws("Null")),NA,dt5$MIN_SURFELEVCHANGE)               
  suppressWarnings(dt5$MIN_SURFELEVCHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURFELEVCHANGE))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURFELEVCHANGE))
  dt5$MAX_SURFELEVCHANGE <- ifelse((trimws(as.character(dt5$MAX_SURFELEVCHANGE))==trimws("Null")),NA,dt5$MAX_SURFELEVCHANGE)               
  suppressWarnings(dt5$MAX_SURFELEVCHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURFELEVCHANGE))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURFELEVCHANGE))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURFELEVCHANGE)
  summary(STD_SURFELEVCHANGE)
  summary(MIN_SURFELEVCHANGE)
  summary(MAX_SURFELEVCHANGE)
  summary(N_SURFELEVCHANGE)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7110/8/fb39985d9e6e72e5d0410dfb23cd74a1" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)!="factor") dt6$N_COMMENTS<- as.factor(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID)) 
  summary(as.factor(dt6$N_COMMENTS))
  detach(dt6)
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt2
  humidity <- dt3
  soiltemp <- dt4
  windspeed <- dt6 
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7191/download?token=sGM9Zn7pp33Zg1DBa6uMPe5GOUCxQgVwDJaYHsTf_mI")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

if(location == "Lake Hoare"){
  
  pdf('LakeHoaregraphs.pdf')
  
  # Package ID: knb-lter-mcm.7111.7 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Hoare Meteorological Station (HOEM), McMurdo Dry Valleys, Antarctica (1987-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/bc9a2c9e926ceff4ff642622525db453" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "AVG_AIRTDEL3M1",     
                   "STD_AIRTDEL3M1",     
                   "MIN_AIRTDEL3M1",     
                   "MAX_AIRTDEL3M1",     
                   "N_AIRTDEL3M1",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$AVG_AIRTDEL3M1)=="factor") dt1$AVG_AIRTDEL3M1 <-as.numeric(levels(dt1$AVG_AIRTDEL3M1))[as.integer(dt1$AVG_AIRTDEL3M1) ]               
  if (class(dt1$AVG_AIRTDEL3M1)=="character") dt1$AVG_AIRTDEL3M1 <-as.numeric(dt1$AVG_AIRTDEL3M1)
  if (class(dt1$STD_AIRTDEL3M1)=="factor") dt1$STD_AIRTDEL3M1 <-as.numeric(levels(dt1$STD_AIRTDEL3M1))[as.integer(dt1$STD_AIRTDEL3M1) ]               
  if (class(dt1$STD_AIRTDEL3M1)=="character") dt1$STD_AIRTDEL3M1 <-as.numeric(dt1$STD_AIRTDEL3M1)
  if (class(dt1$MIN_AIRTDEL3M1)=="factor") dt1$MIN_AIRTDEL3M1 <-as.numeric(levels(dt1$MIN_AIRTDEL3M1))[as.integer(dt1$MIN_AIRTDEL3M1) ]               
  if (class(dt1$MIN_AIRTDEL3M1)=="character") dt1$MIN_AIRTDEL3M1 <-as.numeric(dt1$MIN_AIRTDEL3M1)
  if (class(dt1$MAX_AIRTDEL3M1)=="factor") dt1$MAX_AIRTDEL3M1 <-as.numeric(levels(dt1$MAX_AIRTDEL3M1))[as.integer(dt1$MAX_AIRTDEL3M1) ]               
  if (class(dt1$MAX_AIRTDEL3M1)=="character") dt1$MAX_AIRTDEL3M1 <-as.numeric(dt1$MAX_AIRTDEL3M1)
  if (class(dt1$N_AIRTDEL3M1)=="factor") dt1$N_AIRTDEL3M1 <-as.numeric(levels(dt1$N_AIRTDEL3M1))[as.integer(dt1$N_AIRTDEL3M1) ]               
  if (class(dt1$N_AIRTDEL3M1)=="character") dt1$N_AIRTDEL3M1 <-as.numeric(dt1$N_AIRTDEL3M1)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$AVG_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$AVG_AIRTDEL3M1))==trimws("Null")),NA,dt1$AVG_AIRTDEL3M1)               
  suppressWarnings(dt1$AVG_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRTDEL3M1))
  dt1$STD_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$STD_AIRTDEL3M1))==trimws("Null")),NA,dt1$STD_AIRTDEL3M1)               
  suppressWarnings(dt1$STD_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRTDEL3M1))
  dt1$MIN_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MIN_AIRTDEL3M1))==trimws("Null")),NA,dt1$MIN_AIRTDEL3M1)               
  suppressWarnings(dt1$MIN_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRTDEL3M1))
  dt1$MAX_AIRTDEL3M1 <- ifelse((trimws(as.character(dt1$MAX_AIRTDEL3M1))==trimws("Null")),NA,dt1$MAX_AIRTDEL3M1)               
  suppressWarnings(dt1$MAX_AIRTDEL3M1 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRTDEL3M1))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRTDEL3M1))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(AVG_AIRTDEL3M1)
  summary(STD_AIRTDEL3M1)
  summary(MIN_AIRTDEL3M1)
  summary(MAX_AIRTDEL3M1)
  summary(N_AIRTDEL3M1)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/c27deb7bb4fbd08a1f0206028715cfe9" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PPT",     
                   "STD_PPT",     
                   "MIN_PPT",     
                   "MAX_PPT",     
                   "N_PPT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)                                   
  if (class(dt2$AVG_PPT)=="factor") dt2$AVG_PPT <-as.numeric(levels(dt2$AVG_PPT))[as.integer(dt2$AVG_PPT) ]               
  if (class(dt2$AVG_PPT)=="character") dt2$AVG_PPT <-as.numeric(dt2$AVG_PPT)
  if (class(dt2$STD_PPT)=="factor") dt2$STD_PPT <-as.numeric(levels(dt2$STD_PPT))[as.integer(dt2$STD_PPT) ]               
  if (class(dt2$STD_PPT)=="character") dt2$STD_PPT <-as.numeric(dt2$STD_PPT)
  if (class(dt2$MIN_PPT)=="factor") dt2$MIN_PPT <-as.numeric(levels(dt2$MIN_PPT))[as.integer(dt2$MIN_PPT) ]               
  if (class(dt2$MIN_PPT)=="character") dt2$MIN_PPT <-as.numeric(dt2$MIN_PPT)
  if (class(dt2$MAX_PPT)=="factor") dt2$MAX_PPT <-as.numeric(levels(dt2$MAX_PPT))[as.integer(dt2$MAX_PPT) ]               
  if (class(dt2$MAX_PPT)=="character") dt2$MAX_PPT <-as.numeric(dt2$MAX_PPT)
  if (class(dt2$N_PPT)=="factor") dt2$N_PPT <-as.numeric(levels(dt2$N_PPT))[as.integer(dt2$N_PPT) ]               
  if (class(dt2$N_PPT)=="character") dt2$N_PPT <-as.numeric(dt2$N_PPT)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PPT <- ifelse((trimws(as.character(dt2$AVG_PPT))==trimws("Null")),NA,dt2$AVG_PPT)               
  suppressWarnings(dt2$AVG_PPT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PPT))==as.character(as.numeric("Null"))),NA,dt2$AVG_PPT))
  dt2$STD_PPT <- ifelse((trimws(as.character(dt2$STD_PPT))==trimws("NULL")),NA,dt2$STD_PPT)               
  suppressWarnings(dt2$STD_PPT <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt2$STD_PPT))==as.character(as.numeric("NULL"))),NA,dt2$STD_PPT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PPT)
  summary(STD_PPT)
  summary(MIN_PPT)
  summary(MAX_PPT)
  summary(N_PPT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/05c068ed75b0f854045c91dd9b0189a6" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PRESSTA",     
                   "STD_PRESSTA",     
                   "MIN_PRESSTA",     
                   "MAX_PRESSTA",     
                   "N_PRESSTA",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_PRESSTA)=="factor") dt3$AVG_PRESSTA <-as.numeric(levels(dt3$AVG_PRESSTA))[as.integer(dt3$AVG_PRESSTA) ]               
  if (class(dt3$AVG_PRESSTA)=="character") dt3$AVG_PRESSTA <-as.numeric(dt3$AVG_PRESSTA)
  if (class(dt3$STD_PRESSTA)=="factor") dt3$STD_PRESSTA <-as.numeric(levels(dt3$STD_PRESSTA))[as.integer(dt3$STD_PRESSTA) ]               
  if (class(dt3$STD_PRESSTA)=="character") dt3$STD_PRESSTA <-as.numeric(dt3$STD_PRESSTA)
  if (class(dt3$MIN_PRESSTA)=="factor") dt3$MIN_PRESSTA <-as.numeric(levels(dt3$MIN_PRESSTA))[as.integer(dt3$MIN_PRESSTA) ]               
  if (class(dt3$MIN_PRESSTA)=="character") dt3$MIN_PRESSTA <-as.numeric(dt3$MIN_PRESSTA)
  if (class(dt3$MAX_PRESSTA)=="factor") dt3$MAX_PRESSTA <-as.numeric(levels(dt3$MAX_PRESSTA))[as.integer(dt3$MAX_PRESSTA) ]               
  if (class(dt3$MAX_PRESSTA)=="character") dt3$MAX_PRESSTA <-as.numeric(dt3$MAX_PRESSTA)
  if (class(dt3$N_PRESSTA)=="factor") dt3$N_PRESSTA <-as.numeric(levels(dt3$N_PRESSTA))[as.integer(dt3$N_PRESSTA) ]               
  if (class(dt3$N_PRESSTA)=="character") dt3$N_PRESSTA <-as.numeric(dt3$N_PRESSTA)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_PRESSTA <- ifelse((trimws(as.character(dt3$AVG_PRESSTA))==trimws("NULL")),NA,dt3$AVG_PRESSTA)               
  suppressWarnings(dt3$AVG_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt3$AVG_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt3$AVG_PRESSTA))
  dt3$STD_PRESSTA <- ifelse((trimws(as.character(dt3$STD_PRESSTA))==trimws("NULL")),NA,dt3$STD_PRESSTA)               
  suppressWarnings(dt3$STD_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt3$STD_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt3$STD_PRESSTA))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PRESSTA)
  summary(STD_PRESSTA)
  summary(MIN_PRESSTA)
  summary(MAX_PRESSTA)
  summary(N_PRESSTA)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/e7a1ebe6f4479d13962088977254d272" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_PAR)=="factor") dt4$AVG_PAR <-as.numeric(levels(dt4$AVG_PAR))[as.integer(dt4$AVG_PAR) ]               
  if (class(dt4$AVG_PAR)=="character") dt4$AVG_PAR <-as.numeric(dt4$AVG_PAR)
  if (class(dt4$STD_PAR)=="factor") dt4$STD_PAR <-as.numeric(levels(dt4$STD_PAR))[as.integer(dt4$STD_PAR) ]               
  if (class(dt4$STD_PAR)=="character") dt4$STD_PAR <-as.numeric(dt4$STD_PAR)
  if (class(dt4$MIN_PAR)=="factor") dt4$MIN_PAR <-as.numeric(levels(dt4$MIN_PAR))[as.integer(dt4$MIN_PAR) ]               
  if (class(dt4$MIN_PAR)=="character") dt4$MIN_PAR <-as.numeric(dt4$MIN_PAR)
  if (class(dt4$MAX_PAR)=="factor") dt4$MAX_PAR <-as.numeric(levels(dt4$MAX_PAR))[as.integer(dt4$MAX_PAR) ]               
  if (class(dt4$MAX_PAR)=="character") dt4$MAX_PAR <-as.numeric(dt4$MAX_PAR)
  if (class(dt4$N_PAR)=="factor") dt4$N_PAR <-as.numeric(levels(dt4$N_PAR))[as.integer(dt4$N_PAR) ]               
  if (class(dt4$N_PAR)=="character") dt4$N_PAR <-as.numeric(dt4$N_PAR)
  if (class(dt4$AVG_SWRADIN)=="factor") dt4$AVG_SWRADIN <-as.numeric(levels(dt4$AVG_SWRADIN))[as.integer(dt4$AVG_SWRADIN) ]               
  if (class(dt4$AVG_SWRADIN)=="character") dt4$AVG_SWRADIN <-as.numeric(dt4$AVG_SWRADIN)
  if (class(dt4$STD_SWRADIN)=="factor") dt4$STD_SWRADIN <-as.numeric(levels(dt4$STD_SWRADIN))[as.integer(dt4$STD_SWRADIN) ]               
  if (class(dt4$STD_SWRADIN)=="character") dt4$STD_SWRADIN <-as.numeric(dt4$STD_SWRADIN)
  if (class(dt4$MIN_SWRADIN)=="factor") dt4$MIN_SWRADIN <-as.numeric(levels(dt4$MIN_SWRADIN))[as.integer(dt4$MIN_SWRADIN) ]               
  if (class(dt4$MIN_SWRADIN)=="character") dt4$MIN_SWRADIN <-as.numeric(dt4$MIN_SWRADIN)
  if (class(dt4$MAX_SWRADIN)=="factor") dt4$MAX_SWRADIN <-as.numeric(levels(dt4$MAX_SWRADIN))[as.integer(dt4$MAX_SWRADIN) ]               
  if (class(dt4$MAX_SWRADIN)=="character") dt4$MAX_SWRADIN <-as.numeric(dt4$MAX_SWRADIN)
  if (class(dt4$N_SWRADIN)=="factor") dt4$N_SWRADIN <-as.numeric(levels(dt4$N_SWRADIN))[as.integer(dt4$N_SWRADIN) ]               
  if (class(dt4$N_SWRADIN)=="character") dt4$N_SWRADIN <-as.numeric(dt4$N_SWRADIN)
  if (class(dt4$AVG_SWRADOUT)=="factor") dt4$AVG_SWRADOUT <-as.numeric(levels(dt4$AVG_SWRADOUT))[as.integer(dt4$AVG_SWRADOUT) ]               
  if (class(dt4$AVG_SWRADOUT)=="character") dt4$AVG_SWRADOUT <-as.numeric(dt4$AVG_SWRADOUT)
  if (class(dt4$STD_SWRADOUT)=="factor") dt4$STD_SWRADOUT <-as.numeric(levels(dt4$STD_SWRADOUT))[as.integer(dt4$STD_SWRADOUT) ]               
  if (class(dt4$STD_SWRADOUT)=="character") dt4$STD_SWRADOUT <-as.numeric(dt4$STD_SWRADOUT)
  if (class(dt4$MIN_SWRADOUT)=="factor") dt4$MIN_SWRADOUT <-as.numeric(levels(dt4$MIN_SWRADOUT))[as.integer(dt4$MIN_SWRADOUT) ]               
  if (class(dt4$MIN_SWRADOUT)=="character") dt4$MIN_SWRADOUT <-as.numeric(dt4$MIN_SWRADOUT)
  if (class(dt4$MAX_SWRADOUT)=="factor") dt4$MAX_SWRADOUT <-as.numeric(levels(dt4$MAX_SWRADOUT))[as.integer(dt4$MAX_SWRADOUT) ]               
  if (class(dt4$MAX_SWRADOUT)=="character") dt4$MAX_SWRADOUT <-as.numeric(dt4$MAX_SWRADOUT)
  if (class(dt4$N_SWRADOUT)=="factor") dt4$N_SWRADOUT <-as.numeric(levels(dt4$N_SWRADOUT))[as.integer(dt4$N_SWRADOUT) ]               
  if (class(dt4$N_SWRADOUT)=="character") dt4$N_SWRADOUT <-as.numeric(dt4$N_SWRADOUT)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_PAR <- ifelse((trimws(as.character(dt4$AVG_PAR))==trimws("Null")),NA,dt4$AVG_PAR)               
  suppressWarnings(dt4$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt4$AVG_PAR))
  dt4$STD_PAR <- ifelse((trimws(as.character(dt4$STD_PAR))==trimws("Null")),NA,dt4$STD_PAR)               
  suppressWarnings(dt4$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_PAR))==as.character(as.numeric("Null"))),NA,dt4$STD_PAR))
  dt4$MIN_PAR <- ifelse((trimws(as.character(dt4$MIN_PAR))==trimws("Null")),NA,dt4$MIN_PAR)               
  suppressWarnings(dt4$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt4$MIN_PAR))
  dt4$MAX_PAR <- ifelse((trimws(as.character(dt4$MAX_PAR))==trimws("Null")),NA,dt4$MAX_PAR)               
  suppressWarnings(dt4$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt4$MAX_PAR))
  dt4$AVG_SWRADIN <- ifelse((trimws(as.character(dt4$AVG_SWRADIN))==trimws("Null")),NA,dt4$AVG_SWRADIN)               
  suppressWarnings(dt4$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$AVG_SWRADIN))
  dt4$STD_SWRADIN <- ifelse((trimws(as.character(dt4$STD_SWRADIN))==trimws("Null")),NA,dt4$STD_SWRADIN)               
  suppressWarnings(dt4$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$STD_SWRADIN))
  dt4$MIN_SWRADIN <- ifelse((trimws(as.character(dt4$MIN_SWRADIN))==trimws("Null")),NA,dt4$MIN_SWRADIN)               
  suppressWarnings(dt4$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MIN_SWRADIN))
  dt4$MAX_SWRADIN <- ifelse((trimws(as.character(dt4$MAX_SWRADIN))==trimws("Null")),NA,dt4$MAX_SWRADIN)               
  suppressWarnings(dt4$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MAX_SWRADIN))
  dt4$AVG_SWRADOUT <- ifelse((trimws(as.character(dt4$AVG_SWRADOUT))==trimws("Null")),NA,dt4$AVG_SWRADOUT)               
  suppressWarnings(dt4$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$AVG_SWRADOUT))
  dt4$STD_SWRADOUT <- ifelse((trimws(as.character(dt4$STD_SWRADOUT))==trimws("Null")),NA,dt4$STD_SWRADOUT)               
  suppressWarnings(dt4$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$STD_SWRADOUT))
  dt4$MIN_SWRADOUT <- ifelse((trimws(as.character(dt4$MIN_SWRADOUT))==trimws("Null")),NA,dt4$MIN_SWRADOUT)               
  suppressWarnings(dt4$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$MIN_SWRADOUT))
  dt4$MAX_SWRADOUT <- ifelse((trimws(as.character(dt4$MAX_SWRADOUT))==trimws("Null")),NA,dt4$MAX_SWRADOUT)               
  suppressWarnings(dt4$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/01064d613e6d736c210b1c0926de8112" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_RH)=="factor") dt5$AVG_RH <-as.numeric(levels(dt5$AVG_RH))[as.integer(dt5$AVG_RH) ]               
  if (class(dt5$AVG_RH)=="character") dt5$AVG_RH <-as.numeric(dt5$AVG_RH)
  if (class(dt5$STD_RH)=="factor") dt5$STD_RH <-as.numeric(levels(dt5$STD_RH))[as.integer(dt5$STD_RH) ]               
  if (class(dt5$STD_RH)=="character") dt5$STD_RH <-as.numeric(dt5$STD_RH)
  if (class(dt5$MIN_RH)=="factor") dt5$MIN_RH <-as.numeric(levels(dt5$MIN_RH))[as.integer(dt5$MIN_RH) ]               
  if (class(dt5$MIN_RH)=="character") dt5$MIN_RH <-as.numeric(dt5$MIN_RH)
  if (class(dt5$MAX_RH)=="factor") dt5$MAX_RH <-as.numeric(levels(dt5$MAX_RH))[as.integer(dt5$MAX_RH) ]               
  if (class(dt5$MAX_RH)=="character") dt5$MAX_RH <-as.numeric(dt5$MAX_RH)
  if (class(dt5$N_RH)=="factor") dt5$N_RH <-as.numeric(levels(dt5$N_RH))[as.integer(dt5$N_RH) ]               
  if (class(dt5$N_RH)=="character") dt5$N_RH <-as.numeric(dt5$N_RH)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/1854a19fcf7b09eb2188b7973a734b2f" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)
  if (class(dt6$AVG_SOILT0CM)=="factor") dt6$AVG_SOILT0CM <-as.numeric(levels(dt6$AVG_SOILT0CM))[as.integer(dt6$AVG_SOILT0CM) ]               
  if (class(dt6$AVG_SOILT0CM)=="character") dt6$AVG_SOILT0CM <-as.numeric(dt6$AVG_SOILT0CM)
  if (class(dt6$STD_SOILT0CM)=="factor") dt6$STD_SOILT0CM <-as.numeric(levels(dt6$STD_SOILT0CM))[as.integer(dt6$STD_SOILT0CM) ]               
  if (class(dt6$STD_SOILT0CM)=="character") dt6$STD_SOILT0CM <-as.numeric(dt6$STD_SOILT0CM)
  if (class(dt6$MIN_SOILT0CM)=="factor") dt6$MIN_SOILT0CM <-as.numeric(levels(dt6$MIN_SOILT0CM))[as.integer(dt6$MIN_SOILT0CM) ]               
  if (class(dt6$MIN_SOILT0CM)=="character") dt6$MIN_SOILT0CM <-as.numeric(dt6$MIN_SOILT0CM)
  if (class(dt6$MAX_SOILT0CM)=="factor") dt6$MAX_SOILT0CM <-as.numeric(levels(dt6$MAX_SOILT0CM))[as.integer(dt6$MAX_SOILT0CM) ]               
  if (class(dt6$MAX_SOILT0CM)=="character") dt6$MAX_SOILT0CM <-as.numeric(dt6$MAX_SOILT0CM)
  if (class(dt6$N_SOILT0CM)=="factor") dt6$N_SOILT0CM <-as.numeric(levels(dt6$N_SOILT0CM))[as.integer(dt6$N_SOILT0CM) ]               
  if (class(dt6$N_SOILT0CM)=="character") dt6$N_SOILT0CM <-as.numeric(dt6$N_SOILT0CM)
  if (class(dt6$AVG_SOILT5CM)=="factor") dt6$AVG_SOILT5CM <-as.numeric(levels(dt6$AVG_SOILT5CM))[as.integer(dt6$AVG_SOILT5CM) ]               
  if (class(dt6$AVG_SOILT5CM)=="character") dt6$AVG_SOILT5CM <-as.numeric(dt6$AVG_SOILT5CM)
  if (class(dt6$STD_SOILT5CM)=="factor") dt6$STD_SOILT5CM <-as.numeric(levels(dt6$STD_SOILT5CM))[as.integer(dt6$STD_SOILT5CM) ]               
  if (class(dt6$STD_SOILT5CM)=="character") dt6$STD_SOILT5CM <-as.numeric(dt6$STD_SOILT5CM)
  if (class(dt6$MIN_SOILT5CM)=="factor") dt6$MIN_SOILT5CM <-as.numeric(levels(dt6$MIN_SOILT5CM))[as.integer(dt6$MIN_SOILT5CM) ]               
  if (class(dt6$MIN_SOILT5CM)=="character") dt6$MIN_SOILT5CM <-as.numeric(dt6$MIN_SOILT5CM)
  if (class(dt6$MAX_SOILT5CM)=="factor") dt6$MAX_SOILT5CM <-as.numeric(levels(dt6$MAX_SOILT5CM))[as.integer(dt6$MAX_SOILT5CM) ]               
  if (class(dt6$MAX_SOILT5CM)=="character") dt6$MAX_SOILT5CM <-as.numeric(dt6$MAX_SOILT5CM)
  if (class(dt6$N_SOILT5CM)=="factor") dt6$N_SOILT5CM <-as.numeric(levels(dt6$N_SOILT5CM))[as.integer(dt6$N_SOILT5CM) ]               
  if (class(dt6$N_SOILT5CM)=="character") dt6$N_SOILT5CM <-as.numeric(dt6$N_SOILT5CM)
  if (class(dt6$AVG_SOILT10CM)=="factor") dt6$AVG_SOILT10CM <-as.numeric(levels(dt6$AVG_SOILT10CM))[as.integer(dt6$AVG_SOILT10CM) ]               
  if (class(dt6$AVG_SOILT10CM)=="character") dt6$AVG_SOILT10CM <-as.numeric(dt6$AVG_SOILT10CM)
  if (class(dt6$STD_SOILT10CM)=="factor") dt6$STD_SOILT10CM <-as.numeric(levels(dt6$STD_SOILT10CM))[as.integer(dt6$STD_SOILT10CM) ]               
  if (class(dt6$STD_SOILT10CM)=="character") dt6$STD_SOILT10CM <-as.numeric(dt6$STD_SOILT10CM)
  if (class(dt6$MIN_SOILT10CM)=="factor") dt6$MIN_SOILT10CM <-as.numeric(levels(dt6$MIN_SOILT10CM))[as.integer(dt6$MIN_SOILT10CM) ]               
  if (class(dt6$MIN_SOILT10CM)=="character") dt6$MIN_SOILT10CM <-as.numeric(dt6$MIN_SOILT10CM)
  if (class(dt6$MAX_SOILT10CM)=="factor") dt6$MAX_SOILT10CM <-as.numeric(levels(dt6$MAX_SOILT10CM))[as.integer(dt6$MAX_SOILT10CM) ]               
  if (class(dt6$MAX_SOILT10CM)=="character") dt6$MAX_SOILT10CM <-as.numeric(dt6$MAX_SOILT10CM)
  if (class(dt6$N_SOILT10CM)=="factor") dt6$N_SOILT10CM <-as.numeric(levels(dt6$N_SOILT10CM))[as.integer(dt6$N_SOILT10CM) ]               
  if (class(dt6$N_SOILT10CM)=="character") dt6$N_SOILT10CM <-as.numeric(dt6$N_SOILT10CM)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt6$AVG_SOILT0CM <- ifelse((trimws(as.character(dt6$AVG_SOILT0CM))==trimws("Null")),NA,dt6$AVG_SOILT0CM)               
  suppressWarnings(dt6$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT0CM))
  dt6$STD_SOILT0CM <- ifelse((trimws(as.character(dt6$STD_SOILT0CM))==trimws("Null")),NA,dt6$STD_SOILT0CM)               
  suppressWarnings(dt6$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT0CM))
  dt6$MIN_SOILT0CM <- ifelse((trimws(as.character(dt6$MIN_SOILT0CM))==trimws("Null")),NA,dt6$MIN_SOILT0CM)               
  suppressWarnings(dt6$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT0CM))
  dt6$MAX_SOILT0CM <- ifelse((trimws(as.character(dt6$MAX_SOILT0CM))==trimws("Null")),NA,dt6$MAX_SOILT0CM)               
  suppressWarnings(dt6$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT0CM))
  dt6$AVG_SOILT5CM <- ifelse((trimws(as.character(dt6$AVG_SOILT5CM))==trimws("Null")),NA,dt6$AVG_SOILT5CM)               
  suppressWarnings(dt6$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT5CM))
  dt6$STD_SOILT5CM <- ifelse((trimws(as.character(dt6$STD_SOILT5CM))==trimws("Null")),NA,dt6$STD_SOILT5CM)               
  suppressWarnings(dt6$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT5CM))
  dt6$MIN_SOILT5CM <- ifelse((trimws(as.character(dt6$MIN_SOILT5CM))==trimws("Null")),NA,dt6$MIN_SOILT5CM)               
  suppressWarnings(dt6$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT5CM))
  dt6$MAX_SOILT5CM <- ifelse((trimws(as.character(dt6$MAX_SOILT5CM))==trimws("Null")),NA,dt6$MAX_SOILT5CM)               
  suppressWarnings(dt6$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT5CM))
  dt6$AVG_SOILT10CM <- ifelse((trimws(as.character(dt6$AVG_SOILT10CM))==trimws("Null")),NA,dt6$AVG_SOILT10CM)               
  suppressWarnings(dt6$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT10CM))
  dt6$STD_SOILT10CM <- ifelse((trimws(as.character(dt6$STD_SOILT10CM))==trimws("Null")),NA,dt6$STD_SOILT10CM)               
  suppressWarnings(dt6$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT10CM))
  dt6$MIN_SOILT10CM <- ifelse((trimws(as.character(dt6$MIN_SOILT10CM))==trimws("Null")),NA,dt6$MIN_SOILT10CM)               
  suppressWarnings(dt6$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT10CM))
  dt6$MAX_SOILT10CM <- ifelse((trimws(as.character(dt6$MAX_SOILT10CM))==trimws("Null")),NA,dt6$MAX_SOILT10CM)               
  suppressWarnings(dt6$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/96f2e3ecd9e20f13f6318454e857b110" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_UV",     
                   "STDDEV_UV",     
                   "MIN_UV",     
                   "MAX_UV",     
                   "N_UV",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)
  if (class(dt7$AVG_UV)=="factor") dt7$AVG_UV <-as.numeric(levels(dt7$AVG_UV))[as.integer(dt7$AVG_UV) ]               
  if (class(dt7$AVG_UV)=="character") dt7$AVG_UV <-as.numeric(dt7$AVG_UV)
  if (class(dt7$STDDEV_UV)=="factor") dt7$STDDEV_UV <-as.numeric(levels(dt7$STDDEV_UV))[as.integer(dt7$STDDEV_UV) ]               
  if (class(dt7$STDDEV_UV)=="character") dt7$STDDEV_UV <-as.numeric(dt7$STDDEV_UV)
  if (class(dt7$MIN_UV)=="factor") dt7$MIN_UV <-as.numeric(levels(dt7$MIN_UV))[as.integer(dt7$MIN_UV) ]               
  if (class(dt7$MIN_UV)=="character") dt7$MIN_UV <-as.numeric(dt7$MIN_UV)
  if (class(dt7$MAX_UV)=="factor") dt7$MAX_UV <-as.numeric(levels(dt7$MAX_UV))[as.integer(dt7$MAX_UV) ]               
  if (class(dt7$MAX_UV)=="character") dt7$MAX_UV <-as.numeric(dt7$MAX_UV)
  if (class(dt7$N_UV)=="factor") dt7$N_UV <-as.numeric(levels(dt7$N_UV))[as.integer(dt7$N_UV) ]               
  if (class(dt7$N_UV)=="character") dt7$N_UV <-as.numeric(dt7$N_UV)
  if (class(dt7$N_COMMENTS)=="factor") dt7$N_COMMENTS <-as.numeric(levels(dt7$N_COMMENTS))[as.integer(dt7$N_COMMENTS) ]               
  if (class(dt7$N_COMMENTS)=="character") dt7$N_COMMENTS <-as.numeric(dt7$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_UV)
  summary(STDDEV_UV)
  summary(MIN_UV)
  summary(MAX_UV)
  summary(N_UV)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID))
  detach(dt7)               
  
  
  inUrl8  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7111/7/6db60c6b7666496fd20a633ee4cfbdde" 
  infile8 <- tempfile()
  try(download.file(inUrl8,infile8,method="curl"))
  if (is.na(file.size(infile8))) download.file(inUrl8,infile8,method="auto")
  
  
  dt8 <-read.csv(infile8,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile8)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt8$METLOCID)!="factor") dt8$METLOCID<- as.factor(dt8$METLOCID)                                   
  if (class(dt8$AVG_WSPD)=="factor") dt8$AVG_WSPD <-as.numeric(levels(dt8$AVG_WSPD))[as.integer(dt8$AVG_WSPD) ]               
  if (class(dt8$AVG_WSPD)=="character") dt8$AVG_WSPD <-as.numeric(dt8$AVG_WSPD)
  if (class(dt8$STDDEV_WSPD)=="factor") dt8$STDDEV_WSPD <-as.numeric(levels(dt8$STDDEV_WSPD))[as.integer(dt8$STDDEV_WSPD) ]               
  if (class(dt8$STDDEV_WSPD)=="character") dt8$STDDEV_WSPD <-as.numeric(dt8$STDDEV_WSPD)
  if (class(dt8$MIN_WSPD)=="factor") dt8$MIN_WSPD <-as.numeric(levels(dt8$MIN_WSPD))[as.integer(dt8$MIN_WSPD) ]               
  if (class(dt8$MIN_WSPD)=="character") dt8$MIN_WSPD <-as.numeric(dt8$MIN_WSPD)
  if (class(dt8$MAX_WSPD)=="factor") dt8$MAX_WSPD <-as.numeric(levels(dt8$MAX_WSPD))[as.integer(dt8$MAX_WSPD) ]               
  if (class(dt8$MAX_WSPD)=="character") dt8$MAX_WSPD <-as.numeric(dt8$MAX_WSPD)
  if (class(dt8$N_WSPD)=="factor") dt8$N_WSPD <-as.numeric(levels(dt8$N_WSPD))[as.integer(dt8$N_WSPD) ]               
  if (class(dt8$N_WSPD)=="character") dt8$N_WSPD <-as.numeric(dt8$N_WSPD)
  if (class(dt8$N_COMMENTS)=="factor") dt8$N_COMMENTS <-as.numeric(levels(dt8$N_COMMENTS))[as.integer(dt8$N_COMMENTS) ]               
  if (class(dt8$N_COMMENTS)=="character") dt8$N_COMMENTS <-as.numeric(dt8$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt8)                            
  attach(dt8)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt8$METLOCID))
  detach(dt8)               

  ##Remane Data
  airtemp <- dt1 
  radiation <- dt4
  humidity <- dt5
  soiltemp <- dt6
  windspeed <- dt8  
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7228/download?token=6C_8IY_WIrmHEYdY2XP7VzIV8WaZM8Y2-tNRGUhPX3o")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

if(location == "Lake Vanda"){
  
  pdf('LakeVandagraphs.pdf')
  
  # Package ID: knb-lter-mcm.7115.8 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Vanda Meteorological Station (VAAM), McMurdo Dry Valleys, Antarctica (1994-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/e2c23a9f2cb863f8d32b3e1a95e879ea" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/2b7f2cf38284176acc2c8a223d29bac0" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PAR)=="factor") dt2$AVG_PAR <-as.numeric(levels(dt2$AVG_PAR))[as.integer(dt2$AVG_PAR) ]               
  if (class(dt2$AVG_PAR)=="character") dt2$AVG_PAR <-as.numeric(dt2$AVG_PAR)
  if (class(dt2$STD_PAR)=="factor") dt2$STD_PAR <-as.numeric(levels(dt2$STD_PAR))[as.integer(dt2$STD_PAR) ]               
  if (class(dt2$STD_PAR)=="character") dt2$STD_PAR <-as.numeric(dt2$STD_PAR)
  if (class(dt2$MIN_PAR)=="factor") dt2$MIN_PAR <-as.numeric(levels(dt2$MIN_PAR))[as.integer(dt2$MIN_PAR) ]               
  if (class(dt2$MIN_PAR)=="character") dt2$MIN_PAR <-as.numeric(dt2$MIN_PAR)
  if (class(dt2$MAX_PAR)=="factor") dt2$MAX_PAR <-as.numeric(levels(dt2$MAX_PAR))[as.integer(dt2$MAX_PAR) ]               
  if (class(dt2$MAX_PAR)=="character") dt2$MAX_PAR <-as.numeric(dt2$MAX_PAR)
  if (class(dt2$N_PAR)=="factor") dt2$N_PAR <-as.numeric(levels(dt2$N_PAR))[as.integer(dt2$N_PAR) ]               
  if (class(dt2$N_PAR)=="character") dt2$N_PAR <-as.numeric(dt2$N_PAR)
  if (class(dt2$AVG_SWRADIN)=="factor") dt2$AVG_SWRADIN <-as.numeric(levels(dt2$AVG_SWRADIN))[as.integer(dt2$AVG_SWRADIN) ]               
  if (class(dt2$AVG_SWRADIN)=="character") dt2$AVG_SWRADIN <-as.numeric(dt2$AVG_SWRADIN)
  if (class(dt2$STD_SWRADIN)=="factor") dt2$STD_SWRADIN <-as.numeric(levels(dt2$STD_SWRADIN))[as.integer(dt2$STD_SWRADIN) ]               
  if (class(dt2$STD_SWRADIN)=="character") dt2$STD_SWRADIN <-as.numeric(dt2$STD_SWRADIN)
  if (class(dt2$MIN_SWRADIN)=="factor") dt2$MIN_SWRADIN <-as.numeric(levels(dt2$MIN_SWRADIN))[as.integer(dt2$MIN_SWRADIN) ]               
  if (class(dt2$MIN_SWRADIN)=="character") dt2$MIN_SWRADIN <-as.numeric(dt2$MIN_SWRADIN)
  if (class(dt2$MAX_SWRADIN)=="factor") dt2$MAX_SWRADIN <-as.numeric(levels(dt2$MAX_SWRADIN))[as.integer(dt2$MAX_SWRADIN) ]               
  if (class(dt2$MAX_SWRADIN)=="character") dt2$MAX_SWRADIN <-as.numeric(dt2$MAX_SWRADIN)
  if (class(dt2$N_SWRADIN)=="factor") dt2$N_SWRADIN <-as.numeric(levels(dt2$N_SWRADIN))[as.integer(dt2$N_SWRADIN) ]               
  if (class(dt2$N_SWRADIN)=="character") dt2$N_SWRADIN <-as.numeric(dt2$N_SWRADIN)
  if (class(dt2$AVG_SWRADOUT)=="factor") dt2$AVG_SWRADOUT <-as.numeric(levels(dt2$AVG_SWRADOUT))[as.integer(dt2$AVG_SWRADOUT) ]               
  if (class(dt2$AVG_SWRADOUT)=="character") dt2$AVG_SWRADOUT <-as.numeric(dt2$AVG_SWRADOUT)
  if (class(dt2$STD_SWRADOUT)=="factor") dt2$STD_SWRADOUT <-as.numeric(levels(dt2$STD_SWRADOUT))[as.integer(dt2$STD_SWRADOUT) ]               
  if (class(dt2$STD_SWRADOUT)=="character") dt2$STD_SWRADOUT <-as.numeric(dt2$STD_SWRADOUT)
  if (class(dt2$MIN_SWRADOUT)=="factor") dt2$MIN_SWRADOUT <-as.numeric(levels(dt2$MIN_SWRADOUT))[as.integer(dt2$MIN_SWRADOUT) ]               
  if (class(dt2$MIN_SWRADOUT)=="character") dt2$MIN_SWRADOUT <-as.numeric(dt2$MIN_SWRADOUT)
  if (class(dt2$MAX_SWRADOUT)=="factor") dt2$MAX_SWRADOUT <-as.numeric(levels(dt2$MAX_SWRADOUT))[as.integer(dt2$MAX_SWRADOUT) ]               
  if (class(dt2$MAX_SWRADOUT)=="character") dt2$MAX_SWRADOUT <-as.numeric(dt2$MAX_SWRADOUT)
  if (class(dt2$N_SWRADOUT)=="factor") dt2$N_SWRADOUT <-as.numeric(levels(dt2$N_SWRADOUT))[as.integer(dt2$N_SWRADOUT) ]               
  if (class(dt2$N_SWRADOUT)=="character") dt2$N_SWRADOUT <-as.numeric(dt2$N_SWRADOUT)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PAR <- ifelse((trimws(as.character(dt2$AVG_PAR))==trimws("Null")),NA,dt2$AVG_PAR)               
  suppressWarnings(dt2$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt2$AVG_PAR))
  dt2$STD_PAR <- ifelse((trimws(as.character(dt2$STD_PAR))==trimws("Null")),NA,dt2$STD_PAR)               
  suppressWarnings(dt2$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_PAR))==as.character(as.numeric("Null"))),NA,dt2$STD_PAR))
  dt2$MIN_PAR <- ifelse((trimws(as.character(dt2$MIN_PAR))==trimws("Null")),NA,dt2$MIN_PAR)               
  suppressWarnings(dt2$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt2$MIN_PAR))
  dt2$MAX_PAR <- ifelse((trimws(as.character(dt2$MAX_PAR))==trimws("Null")),NA,dt2$MAX_PAR)               
  suppressWarnings(dt2$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt2$MAX_PAR))
  dt2$AVG_SWRADIN <- ifelse((trimws(as.character(dt2$AVG_SWRADIN))==trimws("Null")),NA,dt2$AVG_SWRADIN)               
  suppressWarnings(dt2$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADIN))
  dt2$STD_SWRADIN <- ifelse((trimws(as.character(dt2$STD_SWRADIN))==trimws("Null")),NA,dt2$STD_SWRADIN)               
  suppressWarnings(dt2$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADIN))
  dt2$MIN_SWRADIN <- ifelse((trimws(as.character(dt2$MIN_SWRADIN))==trimws("Null")),NA,dt2$MIN_SWRADIN)               
  suppressWarnings(dt2$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADIN))
  dt2$MAX_SWRADIN <- ifelse((trimws(as.character(dt2$MAX_SWRADIN))==trimws("Null")),NA,dt2$MAX_SWRADIN)               
  suppressWarnings(dt2$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADIN))
  dt2$AVG_SWRADOUT <- ifelse((trimws(as.character(dt2$AVG_SWRADOUT))==trimws("Null")),NA,dt2$AVG_SWRADOUT)               
  suppressWarnings(dt2$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADOUT))
  dt2$STD_SWRADOUT <- ifelse((trimws(as.character(dt2$STD_SWRADOUT))==trimws("Null")),NA,dt2$STD_SWRADOUT)               
  suppressWarnings(dt2$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADOUT))
  dt2$MIN_SWRADOUT <- ifelse((trimws(as.character(dt2$MIN_SWRADOUT))==trimws("Null")),NA,dt2$MIN_SWRADOUT)               
  suppressWarnings(dt2$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADOUT))
  dt2$MAX_SWRADOUT <- ifelse((trimws(as.character(dt2$MAX_SWRADOUT))==trimws("Null")),NA,dt2$MAX_SWRADOUT)               
  suppressWarnings(dt2$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/48e1a77d907c78efb2cb7a38ec38765c" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_RH)=="factor") dt3$AVG_RH <-as.numeric(levels(dt3$AVG_RH))[as.integer(dt3$AVG_RH) ]               
  if (class(dt3$AVG_RH)=="character") dt3$AVG_RH <-as.numeric(dt3$AVG_RH)
  if (class(dt3$STD_RH)=="factor") dt3$STD_RH <-as.numeric(levels(dt3$STD_RH))[as.integer(dt3$STD_RH) ]               
  if (class(dt3$STD_RH)=="character") dt3$STD_RH <-as.numeric(dt3$STD_RH)
  if (class(dt3$MIN_RH)=="factor") dt3$MIN_RH <-as.numeric(levels(dt3$MIN_RH))[as.integer(dt3$MIN_RH) ]               
  if (class(dt3$MIN_RH)=="character") dt3$MIN_RH <-as.numeric(dt3$MIN_RH)
  if (class(dt3$MAX_RH)=="factor") dt3$MAX_RH <-as.numeric(levels(dt3$MAX_RH))[as.integer(dt3$MAX_RH) ]               
  if (class(dt3$MAX_RH)=="character") dt3$MAX_RH <-as.numeric(dt3$MAX_RH)
  if (class(dt3$N_RH)=="factor") dt3$N_RH <-as.numeric(levels(dt3$N_RH))[as.integer(dt3$N_RH) ]               
  if (class(dt3$N_RH)=="character") dt3$N_RH <-as.numeric(dt3$N_RH)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/e4a4b935bbfdef2ad01a3ba41a22419f" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_SOILT0CM)=="factor") dt4$AVG_SOILT0CM <-as.numeric(levels(dt4$AVG_SOILT0CM))[as.integer(dt4$AVG_SOILT0CM) ]               
  if (class(dt4$AVG_SOILT0CM)=="character") dt4$AVG_SOILT0CM <-as.numeric(dt4$AVG_SOILT0CM)
  if (class(dt4$STD_SOILT0CM)=="factor") dt4$STD_SOILT0CM <-as.numeric(levels(dt4$STD_SOILT0CM))[as.integer(dt4$STD_SOILT0CM) ]               
  if (class(dt4$STD_SOILT0CM)=="character") dt4$STD_SOILT0CM <-as.numeric(dt4$STD_SOILT0CM)
  if (class(dt4$MIN_SOILT0CM)=="factor") dt4$MIN_SOILT0CM <-as.numeric(levels(dt4$MIN_SOILT0CM))[as.integer(dt4$MIN_SOILT0CM) ]               
  if (class(dt4$MIN_SOILT0CM)=="character") dt4$MIN_SOILT0CM <-as.numeric(dt4$MIN_SOILT0CM)
  if (class(dt4$MAX_SOILT0CM)=="factor") dt4$MAX_SOILT0CM <-as.numeric(levels(dt4$MAX_SOILT0CM))[as.integer(dt4$MAX_SOILT0CM) ]               
  if (class(dt4$MAX_SOILT0CM)=="character") dt4$MAX_SOILT0CM <-as.numeric(dt4$MAX_SOILT0CM)
  if (class(dt4$N_SOILT0CM)=="factor") dt4$N_SOILT0CM <-as.numeric(levels(dt4$N_SOILT0CM))[as.integer(dt4$N_SOILT0CM) ]               
  if (class(dt4$N_SOILT0CM)=="character") dt4$N_SOILT0CM <-as.numeric(dt4$N_SOILT0CM)
  if (class(dt4$AVG_SOILT5CM)=="factor") dt4$AVG_SOILT5CM <-as.numeric(levels(dt4$AVG_SOILT5CM))[as.integer(dt4$AVG_SOILT5CM) ]               
  if (class(dt4$AVG_SOILT5CM)=="character") dt4$AVG_SOILT5CM <-as.numeric(dt4$AVG_SOILT5CM)
  if (class(dt4$STD_SOILT5CM)=="factor") dt4$STD_SOILT5CM <-as.numeric(levels(dt4$STD_SOILT5CM))[as.integer(dt4$STD_SOILT5CM) ]               
  if (class(dt4$STD_SOILT5CM)=="character") dt4$STD_SOILT5CM <-as.numeric(dt4$STD_SOILT5CM)
  if (class(dt4$MIN_SOILT5CM)=="factor") dt4$MIN_SOILT5CM <-as.numeric(levels(dt4$MIN_SOILT5CM))[as.integer(dt4$MIN_SOILT5CM) ]               
  if (class(dt4$MIN_SOILT5CM)=="character") dt4$MIN_SOILT5CM <-as.numeric(dt4$MIN_SOILT5CM)
  if (class(dt4$MAX_SOILT5CM)=="factor") dt4$MAX_SOILT5CM <-as.numeric(levels(dt4$MAX_SOILT5CM))[as.integer(dt4$MAX_SOILT5CM) ]               
  if (class(dt4$MAX_SOILT5CM)=="character") dt4$MAX_SOILT5CM <-as.numeric(dt4$MAX_SOILT5CM)
  if (class(dt4$N_SOILT5CM)=="factor") dt4$N_SOILT5CM <-as.numeric(levels(dt4$N_SOILT5CM))[as.integer(dt4$N_SOILT5CM) ]               
  if (class(dt4$N_SOILT5CM)=="character") dt4$N_SOILT5CM <-as.numeric(dt4$N_SOILT5CM)
  if (class(dt4$AVG_SOILT10CM)=="factor") dt4$AVG_SOILT10CM <-as.numeric(levels(dt4$AVG_SOILT10CM))[as.integer(dt4$AVG_SOILT10CM) ]               
  if (class(dt4$AVG_SOILT10CM)=="character") dt4$AVG_SOILT10CM <-as.numeric(dt4$AVG_SOILT10CM)
  if (class(dt4$STD_SOILT10CM)=="factor") dt4$STD_SOILT10CM <-as.numeric(levels(dt4$STD_SOILT10CM))[as.integer(dt4$STD_SOILT10CM) ]               
  if (class(dt4$STD_SOILT10CM)=="character") dt4$STD_SOILT10CM <-as.numeric(dt4$STD_SOILT10CM)
  if (class(dt4$MIN_SOILT10CM)=="factor") dt4$MIN_SOILT10CM <-as.numeric(levels(dt4$MIN_SOILT10CM))[as.integer(dt4$MIN_SOILT10CM) ]               
  if (class(dt4$MIN_SOILT10CM)=="character") dt4$MIN_SOILT10CM <-as.numeric(dt4$MIN_SOILT10CM)
  if (class(dt4$MAX_SOILT10CM)=="factor") dt4$MAX_SOILT10CM <-as.numeric(levels(dt4$MAX_SOILT10CM))[as.integer(dt4$MAX_SOILT10CM) ]               
  if (class(dt4$MAX_SOILT10CM)=="character") dt4$MAX_SOILT10CM <-as.numeric(dt4$MAX_SOILT10CM)
  if (class(dt4$N_SOILT10CM)=="factor") dt4$N_SOILT10CM <-as.numeric(levels(dt4$N_SOILT10CM))[as.integer(dt4$N_SOILT10CM) ]               
  if (class(dt4$N_SOILT10CM)=="character") dt4$N_SOILT10CM <-as.numeric(dt4$N_SOILT10CM)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_SOILT0CM <- ifelse((trimws(as.character(dt4$AVG_SOILT0CM))==trimws("Null")),NA,dt4$AVG_SOILT0CM)               
  suppressWarnings(dt4$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT0CM))
  dt4$STD_SOILT0CM <- ifelse((trimws(as.character(dt4$STD_SOILT0CM))==trimws("Null")),NA,dt4$STD_SOILT0CM)               
  suppressWarnings(dt4$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT0CM))
  dt4$MIN_SOILT0CM <- ifelse((trimws(as.character(dt4$MIN_SOILT0CM))==trimws("Null")),NA,dt4$MIN_SOILT0CM)               
  suppressWarnings(dt4$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT0CM))
  dt4$MAX_SOILT0CM <- ifelse((trimws(as.character(dt4$MAX_SOILT0CM))==trimws("Null")),NA,dt4$MAX_SOILT0CM)               
  suppressWarnings(dt4$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT0CM))
  dt4$AVG_SOILT5CM <- ifelse((trimws(as.character(dt4$AVG_SOILT5CM))==trimws("Null")),NA,dt4$AVG_SOILT5CM)               
  suppressWarnings(dt4$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT5CM))
  dt4$STD_SOILT5CM <- ifelse((trimws(as.character(dt4$STD_SOILT5CM))==trimws("Null")),NA,dt4$STD_SOILT5CM)               
  suppressWarnings(dt4$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT5CM))
  dt4$MIN_SOILT5CM <- ifelse((trimws(as.character(dt4$MIN_SOILT5CM))==trimws("Null")),NA,dt4$MIN_SOILT5CM)               
  suppressWarnings(dt4$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT5CM))
  dt4$MAX_SOILT5CM <- ifelse((trimws(as.character(dt4$MAX_SOILT5CM))==trimws("Null")),NA,dt4$MAX_SOILT5CM)               
  suppressWarnings(dt4$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT5CM))
  dt4$AVG_SOILT10CM <- ifelse((trimws(as.character(dt4$AVG_SOILT10CM))==trimws("Null")),NA,dt4$AVG_SOILT10CM)               
  suppressWarnings(dt4$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT10CM))
  dt4$STD_SOILT10CM <- ifelse((trimws(as.character(dt4$STD_SOILT10CM))==trimws("Null")),NA,dt4$STD_SOILT10CM)               
  suppressWarnings(dt4$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT10CM))
  dt4$MIN_SOILT10CM <- ifelse((trimws(as.character(dt4$MIN_SOILT10CM))==trimws("Null")),NA,dt4$MIN_SOILT10CM)               
  suppressWarnings(dt4$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT10CM))
  dt4$MAX_SOILT10CM <- ifelse((trimws(as.character(dt4$MAX_SOILT10CM))==trimws("Null")),NA,dt4$MAX_SOILT10CM)               
  suppressWarnings(dt4$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/79175abac0acecb5e7cdbee4518a6887" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURF_CHANGE",     
                   "STD_SURF_CHANGE",     
                   "MIN_SURF_CHANGE",     
                   "MAX_SURF_CHANGE",     
                   "N_SURF_CHANGE",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURF_CHANGE)=="factor") dt5$AVG_SURF_CHANGE <-as.numeric(levels(dt5$AVG_SURF_CHANGE))[as.integer(dt5$AVG_SURF_CHANGE) ]               
  if (class(dt5$AVG_SURF_CHANGE)=="character") dt5$AVG_SURF_CHANGE <-as.numeric(dt5$AVG_SURF_CHANGE)
  if (class(dt5$STD_SURF_CHANGE)=="factor") dt5$STD_SURF_CHANGE <-as.numeric(levels(dt5$STD_SURF_CHANGE))[as.integer(dt5$STD_SURF_CHANGE) ]               
  if (class(dt5$STD_SURF_CHANGE)=="character") dt5$STD_SURF_CHANGE <-as.numeric(dt5$STD_SURF_CHANGE)
  if (class(dt5$MIN_SURF_CHANGE)=="factor") dt5$MIN_SURF_CHANGE <-as.numeric(levels(dt5$MIN_SURF_CHANGE))[as.integer(dt5$MIN_SURF_CHANGE) ]               
  if (class(dt5$MIN_SURF_CHANGE)=="character") dt5$MIN_SURF_CHANGE <-as.numeric(dt5$MIN_SURF_CHANGE)
  if (class(dt5$MAX_SURF_CHANGE)=="factor") dt5$MAX_SURF_CHANGE <-as.numeric(levels(dt5$MAX_SURF_CHANGE))[as.integer(dt5$MAX_SURF_CHANGE) ]               
  if (class(dt5$MAX_SURF_CHANGE)=="character") dt5$MAX_SURF_CHANGE <-as.numeric(dt5$MAX_SURF_CHANGE)
  if (class(dt5$N_SURF_CHANGE)=="factor") dt5$N_SURF_CHANGE <-as.numeric(levels(dt5$N_SURF_CHANGE))[as.integer(dt5$N_SURF_CHANGE) ]               
  if (class(dt5$N_SURF_CHANGE)=="character") dt5$N_SURF_CHANGE <-as.numeric(dt5$N_SURF_CHANGE)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURF_CHANGE <- ifelse((trimws(as.character(dt5$AVG_SURF_CHANGE))==trimws("Null")),NA,dt5$AVG_SURF_CHANGE)               
  suppressWarnings(dt5$AVG_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURF_CHANGE))
  dt5$STD_SURF_CHANGE <- ifelse((trimws(as.character(dt5$STD_SURF_CHANGE))==trimws("Null")),NA,dt5$STD_SURF_CHANGE)               
  suppressWarnings(dt5$STD_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$STD_SURF_CHANGE))
  dt5$MIN_SURF_CHANGE <- ifelse((trimws(as.character(dt5$MIN_SURF_CHANGE))==trimws("Null")),NA,dt5$MIN_SURF_CHANGE)               
  suppressWarnings(dt5$MIN_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURF_CHANGE))
  dt5$MAX_SURF_CHANGE <- ifelse((trimws(as.character(dt5$MAX_SURF_CHANGE))==trimws("Null")),NA,dt5$MAX_SURF_CHANGE)               
  suppressWarnings(dt5$MAX_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURF_CHANGE))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURF_CHANGE)
  summary(STD_SURF_CHANGE)
  summary(MIN_SURF_CHANGE)
  summary(MAX_SURF_CHANGE)
  summary(N_SURF_CHANGE)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/ded49936449cf48d8db1e89e2519c413" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7115/8/8ff01c0ef793249ff2aa1239485608e3" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ONYXT",     
                   "STD_ONYXT",     
                   "MIN_ONYXT",     
                   "MAX_ONYXT",     
                   "N_ONYXT"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)
  if (class(dt7$AVG_ONYXT)=="factor") dt7$AVG_ONYXT <-as.numeric(levels(dt7$AVG_ONYXT))[as.integer(dt7$AVG_ONYXT) ]               
  if (class(dt7$AVG_ONYXT)=="character") dt7$AVG_ONYXT <-as.numeric(dt7$AVG_ONYXT)
  if (class(dt7$STD_ONYXT)=="factor") dt7$STD_ONYXT <-as.numeric(levels(dt7$STD_ONYXT))[as.integer(dt7$STD_ONYXT) ]               
  if (class(dt7$STD_ONYXT)=="character") dt7$STD_ONYXT <-as.numeric(dt7$STD_ONYXT)
  if (class(dt7$MIN_ONYXT)=="factor") dt7$MIN_ONYXT <-as.numeric(levels(dt7$MIN_ONYXT))[as.integer(dt7$MIN_ONYXT) ]               
  if (class(dt7$MIN_ONYXT)=="character") dt7$MIN_ONYXT <-as.numeric(dt7$MIN_ONYXT)
  if (class(dt7$MAX_ONYXT)=="factor") dt7$MAX_ONYXT <-as.numeric(levels(dt7$MAX_ONYXT))[as.integer(dt7$MAX_ONYXT) ]               
  if (class(dt7$MAX_ONYXT)=="character") dt7$MAX_ONYXT <-as.numeric(dt7$MAX_ONYXT)
  if (class(dt7$N_ONYXT)=="factor") dt7$N_ONYXT <-as.numeric(levels(dt7$N_ONYXT))[as.integer(dt7$N_ONYXT) ]               
  if (class(dt7$N_ONYXT)=="character") dt7$N_ONYXT <-as.numeric(dt7$N_ONYXT)
  
  # Convert Missing Values to NA for non-dates
  
  dt7$AVG_ONYXT <- ifelse((trimws(as.character(dt7$AVG_ONYXT))==trimws("Null")),NA,dt7$AVG_ONYXT)               
  suppressWarnings(dt7$AVG_ONYXT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ONYXT))==as.character(as.numeric("Null"))),NA,dt7$AVG_ONYXT))
  dt7$STD_ONYXT <- ifelse((trimws(as.character(dt7$STD_ONYXT))==trimws("Null")),NA,dt7$STD_ONYXT)               
  suppressWarnings(dt7$STD_ONYXT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STD_ONYXT))==as.character(as.numeric("Null"))),NA,dt7$STD_ONYXT))
  dt7$MIN_ONYXT <- ifelse((trimws(as.character(dt7$MIN_ONYXT))==trimws("Null")),NA,dt7$MIN_ONYXT)               
  suppressWarnings(dt7$MIN_ONYXT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ONYXT))==as.character(as.numeric("Null"))),NA,dt7$MIN_ONYXT))
  dt7$MAX_ONYXT <- ifelse((trimws(as.character(dt7$MAX_ONYXT))==trimws("Null")),NA,dt7$MAX_ONYXT)               
  suppressWarnings(dt7$MAX_ONYXT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ONYXT))==as.character(as.numeric("Null"))),NA,dt7$MAX_ONYXT))
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ONYXT)
  summary(STD_ONYXT)
  summary(MIN_ONYXT)
  summary(MAX_ONYXT)
  summary(N_ONYXT) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID))
  detach(dt7) 
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt2
  humidity <- dt3
  soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7251/download?token=A4oyp99PY5_JW-xK3ZE1evrkWF7eiN4petBAzYQ14kg")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

if(location == "Lake Vida"){
  
  pdf('LakeVidagraphs.pdf')
  
  # Package ID: knb-lter-mcm.7116.8 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Lake Vida Meteorological Station (VIAM), McMurdo Dry Valleys, Antarctica (1995-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/a108d0899163a0e058299ee614bf1525" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/67351817d4488731c3ff9553347bd472" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PAR)=="factor") dt2$AVG_PAR <-as.numeric(levels(dt2$AVG_PAR))[as.integer(dt2$AVG_PAR) ]               
  if (class(dt2$AVG_PAR)=="character") dt2$AVG_PAR <-as.numeric(dt2$AVG_PAR)
  if (class(dt2$STD_PAR)=="factor") dt2$STD_PAR <-as.numeric(levels(dt2$STD_PAR))[as.integer(dt2$STD_PAR) ]               
  if (class(dt2$STD_PAR)=="character") dt2$STD_PAR <-as.numeric(dt2$STD_PAR)
  if (class(dt2$MIN_PAR)=="factor") dt2$MIN_PAR <-as.numeric(levels(dt2$MIN_PAR))[as.integer(dt2$MIN_PAR) ]               
  if (class(dt2$MIN_PAR)=="character") dt2$MIN_PAR <-as.numeric(dt2$MIN_PAR)
  if (class(dt2$MAX_PAR)=="factor") dt2$MAX_PAR <-as.numeric(levels(dt2$MAX_PAR))[as.integer(dt2$MAX_PAR) ]               
  if (class(dt2$MAX_PAR)=="character") dt2$MAX_PAR <-as.numeric(dt2$MAX_PAR)
  if (class(dt2$N_PAR)=="factor") dt2$N_PAR <-as.numeric(levels(dt2$N_PAR))[as.integer(dt2$N_PAR) ]               
  if (class(dt2$N_PAR)=="character") dt2$N_PAR <-as.numeric(dt2$N_PAR)
  if (class(dt2$AVG_SWRADIN)=="factor") dt2$AVG_SWRADIN <-as.numeric(levels(dt2$AVG_SWRADIN))[as.integer(dt2$AVG_SWRADIN) ]               
  if (class(dt2$AVG_SWRADIN)=="character") dt2$AVG_SWRADIN <-as.numeric(dt2$AVG_SWRADIN)
  if (class(dt2$STD_SWRADIN)=="factor") dt2$STD_SWRADIN <-as.numeric(levels(dt2$STD_SWRADIN))[as.integer(dt2$STD_SWRADIN) ]               
  if (class(dt2$STD_SWRADIN)=="character") dt2$STD_SWRADIN <-as.numeric(dt2$STD_SWRADIN)
  if (class(dt2$MIN_SWRADIN)=="factor") dt2$MIN_SWRADIN <-as.numeric(levels(dt2$MIN_SWRADIN))[as.integer(dt2$MIN_SWRADIN) ]               
  if (class(dt2$MIN_SWRADIN)=="character") dt2$MIN_SWRADIN <-as.numeric(dt2$MIN_SWRADIN)
  if (class(dt2$MAX_SWRADIN)=="factor") dt2$MAX_SWRADIN <-as.numeric(levels(dt2$MAX_SWRADIN))[as.integer(dt2$MAX_SWRADIN) ]               
  if (class(dt2$MAX_SWRADIN)=="character") dt2$MAX_SWRADIN <-as.numeric(dt2$MAX_SWRADIN)
  if (class(dt2$N_SWRADIN)=="factor") dt2$N_SWRADIN <-as.numeric(levels(dt2$N_SWRADIN))[as.integer(dt2$N_SWRADIN) ]               
  if (class(dt2$N_SWRADIN)=="character") dt2$N_SWRADIN <-as.numeric(dt2$N_SWRADIN)
  if (class(dt2$AVG_SWRADOUT)=="factor") dt2$AVG_SWRADOUT <-as.numeric(levels(dt2$AVG_SWRADOUT))[as.integer(dt2$AVG_SWRADOUT) ]               
  if (class(dt2$AVG_SWRADOUT)=="character") dt2$AVG_SWRADOUT <-as.numeric(dt2$AVG_SWRADOUT)
  if (class(dt2$STD_SWRADOUT)=="factor") dt2$STD_SWRADOUT <-as.numeric(levels(dt2$STD_SWRADOUT))[as.integer(dt2$STD_SWRADOUT) ]               
  if (class(dt2$STD_SWRADOUT)=="character") dt2$STD_SWRADOUT <-as.numeric(dt2$STD_SWRADOUT)
  if (class(dt2$MIN_SWRADOUT)=="factor") dt2$MIN_SWRADOUT <-as.numeric(levels(dt2$MIN_SWRADOUT))[as.integer(dt2$MIN_SWRADOUT) ]               
  if (class(dt2$MIN_SWRADOUT)=="character") dt2$MIN_SWRADOUT <-as.numeric(dt2$MIN_SWRADOUT)
  if (class(dt2$MAX_SWRADOUT)=="factor") dt2$MAX_SWRADOUT <-as.numeric(levels(dt2$MAX_SWRADOUT))[as.integer(dt2$MAX_SWRADOUT) ]               
  if (class(dt2$MAX_SWRADOUT)=="character") dt2$MAX_SWRADOUT <-as.numeric(dt2$MAX_SWRADOUT)
  if (class(dt2$N_SWRADOUT)=="factor") dt2$N_SWRADOUT <-as.numeric(levels(dt2$N_SWRADOUT))[as.integer(dt2$N_SWRADOUT) ]               
  if (class(dt2$N_SWRADOUT)=="character") dt2$N_SWRADOUT <-as.numeric(dt2$N_SWRADOUT)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PAR <- ifelse((trimws(as.character(dt2$AVG_PAR))==trimws("Null")),NA,dt2$AVG_PAR)               
  suppressWarnings(dt2$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt2$AVG_PAR))
  dt2$STD_PAR <- ifelse((trimws(as.character(dt2$STD_PAR))==trimws("Null")),NA,dt2$STD_PAR)               
  suppressWarnings(dt2$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_PAR))==as.character(as.numeric("Null"))),NA,dt2$STD_PAR))
  dt2$MIN_PAR <- ifelse((trimws(as.character(dt2$MIN_PAR))==trimws("Null")),NA,dt2$MIN_PAR)               
  suppressWarnings(dt2$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt2$MIN_PAR))
  dt2$MAX_PAR <- ifelse((trimws(as.character(dt2$MAX_PAR))==trimws("Null")),NA,dt2$MAX_PAR)               
  suppressWarnings(dt2$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt2$MAX_PAR))
  dt2$AVG_SWRADIN <- ifelse((trimws(as.character(dt2$AVG_SWRADIN))==trimws("Null")),NA,dt2$AVG_SWRADIN)               
  suppressWarnings(dt2$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADIN))
  dt2$STD_SWRADIN <- ifelse((trimws(as.character(dt2$STD_SWRADIN))==trimws("Null")),NA,dt2$STD_SWRADIN)               
  suppressWarnings(dt2$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADIN))
  dt2$MIN_SWRADIN <- ifelse((trimws(as.character(dt2$MIN_SWRADIN))==trimws("Null")),NA,dt2$MIN_SWRADIN)               
  suppressWarnings(dt2$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADIN))
  dt2$MAX_SWRADIN <- ifelse((trimws(as.character(dt2$MAX_SWRADIN))==trimws("Null")),NA,dt2$MAX_SWRADIN)               
  suppressWarnings(dt2$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADIN))
  dt2$AVG_SWRADOUT <- ifelse((trimws(as.character(dt2$AVG_SWRADOUT))==trimws("Null")),NA,dt2$AVG_SWRADOUT)               
  suppressWarnings(dt2$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$AVG_SWRADOUT))
  dt2$STD_SWRADOUT <- ifelse((trimws(as.character(dt2$STD_SWRADOUT))==trimws("Null")),NA,dt2$STD_SWRADOUT)               
  suppressWarnings(dt2$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$STD_SWRADOUT))
  dt2$MIN_SWRADOUT <- ifelse((trimws(as.character(dt2$MIN_SWRADOUT))==trimws("Null")),NA,dt2$MIN_SWRADOUT)               
  suppressWarnings(dt2$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MIN_SWRADOUT))
  dt2$MAX_SWRADOUT <- ifelse((trimws(as.character(dt2$MAX_SWRADOUT))==trimws("Null")),NA,dt2$MAX_SWRADOUT)               
  suppressWarnings(dt2$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt2$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/ec91d69bf7530176e754e87a0cec102f" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_RH)=="factor") dt3$AVG_RH <-as.numeric(levels(dt3$AVG_RH))[as.integer(dt3$AVG_RH) ]               
  if (class(dt3$AVG_RH)=="character") dt3$AVG_RH <-as.numeric(dt3$AVG_RH)
  if (class(dt3$STD_RH)=="factor") dt3$STD_RH <-as.numeric(levels(dt3$STD_RH))[as.integer(dt3$STD_RH) ]               
  if (class(dt3$STD_RH)=="character") dt3$STD_RH <-as.numeric(dt3$STD_RH)
  if (class(dt3$MIN_RH)=="factor") dt3$MIN_RH <-as.numeric(levels(dt3$MIN_RH))[as.integer(dt3$MIN_RH) ]               
  if (class(dt3$MIN_RH)=="character") dt3$MIN_RH <-as.numeric(dt3$MIN_RH)
  if (class(dt3$MAX_RH)=="factor") dt3$MAX_RH <-as.numeric(levels(dt3$MAX_RH))[as.integer(dt3$MAX_RH) ]               
  if (class(dt3$MAX_RH)=="character") dt3$MAX_RH <-as.numeric(dt3$MAX_RH)
  if (class(dt3$N_RH)=="factor") dt3$N_RH <-as.numeric(levels(dt3$N_RH))[as.integer(dt3$N_RH) ]               
  if (class(dt3$N_RH)=="character") dt3$N_RH <-as.numeric(dt3$N_RH)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/38995cce1a127618810adee4f5561469" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_SOILT0CM)=="factor") dt4$AVG_SOILT0CM <-as.numeric(levels(dt4$AVG_SOILT0CM))[as.integer(dt4$AVG_SOILT0CM) ]               
  if (class(dt4$AVG_SOILT0CM)=="character") dt4$AVG_SOILT0CM <-as.numeric(dt4$AVG_SOILT0CM)
  if (class(dt4$STD_SOILT0CM)=="factor") dt4$STD_SOILT0CM <-as.numeric(levels(dt4$STD_SOILT0CM))[as.integer(dt4$STD_SOILT0CM) ]               
  if (class(dt4$STD_SOILT0CM)=="character") dt4$STD_SOILT0CM <-as.numeric(dt4$STD_SOILT0CM)
  if (class(dt4$MIN_SOILT0CM)=="factor") dt4$MIN_SOILT0CM <-as.numeric(levels(dt4$MIN_SOILT0CM))[as.integer(dt4$MIN_SOILT0CM) ]               
  if (class(dt4$MIN_SOILT0CM)=="character") dt4$MIN_SOILT0CM <-as.numeric(dt4$MIN_SOILT0CM)
  if (class(dt4$MAX_SOILT0CM)=="factor") dt4$MAX_SOILT0CM <-as.numeric(levels(dt4$MAX_SOILT0CM))[as.integer(dt4$MAX_SOILT0CM) ]               
  if (class(dt4$MAX_SOILT0CM)=="character") dt4$MAX_SOILT0CM <-as.numeric(dt4$MAX_SOILT0CM)
  if (class(dt4$N_SOILT0CM)=="factor") dt4$N_SOILT0CM <-as.numeric(levels(dt4$N_SOILT0CM))[as.integer(dt4$N_SOILT0CM) ]               
  if (class(dt4$N_SOILT0CM)=="character") dt4$N_SOILT0CM <-as.numeric(dt4$N_SOILT0CM)
  if (class(dt4$AVG_SOILT5CM)=="factor") dt4$AVG_SOILT5CM <-as.numeric(levels(dt4$AVG_SOILT5CM))[as.integer(dt4$AVG_SOILT5CM) ]               
  if (class(dt4$AVG_SOILT5CM)=="character") dt4$AVG_SOILT5CM <-as.numeric(dt4$AVG_SOILT5CM)
  if (class(dt4$STD_SOILT5CM)=="factor") dt4$STD_SOILT5CM <-as.numeric(levels(dt4$STD_SOILT5CM))[as.integer(dt4$STD_SOILT5CM) ]               
  if (class(dt4$STD_SOILT5CM)=="character") dt4$STD_SOILT5CM <-as.numeric(dt4$STD_SOILT5CM)
  if (class(dt4$MIN_SOILT5CM)=="factor") dt4$MIN_SOILT5CM <-as.numeric(levels(dt4$MIN_SOILT5CM))[as.integer(dt4$MIN_SOILT5CM) ]               
  if (class(dt4$MIN_SOILT5CM)=="character") dt4$MIN_SOILT5CM <-as.numeric(dt4$MIN_SOILT5CM)
  if (class(dt4$MAX_SOILT5CM)=="factor") dt4$MAX_SOILT5CM <-as.numeric(levels(dt4$MAX_SOILT5CM))[as.integer(dt4$MAX_SOILT5CM) ]               
  if (class(dt4$MAX_SOILT5CM)=="character") dt4$MAX_SOILT5CM <-as.numeric(dt4$MAX_SOILT5CM)
  if (class(dt4$N_SOILT5CM)=="factor") dt4$N_SOILT5CM <-as.numeric(levels(dt4$N_SOILT5CM))[as.integer(dt4$N_SOILT5CM) ]               
  if (class(dt4$N_SOILT5CM)=="character") dt4$N_SOILT5CM <-as.numeric(dt4$N_SOILT5CM)
  if (class(dt4$AVG_SOILT10CM)=="factor") dt4$AVG_SOILT10CM <-as.numeric(levels(dt4$AVG_SOILT10CM))[as.integer(dt4$AVG_SOILT10CM) ]               
  if (class(dt4$AVG_SOILT10CM)=="character") dt4$AVG_SOILT10CM <-as.numeric(dt4$AVG_SOILT10CM)
  if (class(dt4$STD_SOILT10CM)=="factor") dt4$STD_SOILT10CM <-as.numeric(levels(dt4$STD_SOILT10CM))[as.integer(dt4$STD_SOILT10CM) ]               
  if (class(dt4$STD_SOILT10CM)=="character") dt4$STD_SOILT10CM <-as.numeric(dt4$STD_SOILT10CM)
  if (class(dt4$MIN_SOILT10CM)=="factor") dt4$MIN_SOILT10CM <-as.numeric(levels(dt4$MIN_SOILT10CM))[as.integer(dt4$MIN_SOILT10CM) ]               
  if (class(dt4$MIN_SOILT10CM)=="character") dt4$MIN_SOILT10CM <-as.numeric(dt4$MIN_SOILT10CM)
  if (class(dt4$MAX_SOILT10CM)=="factor") dt4$MAX_SOILT10CM <-as.numeric(levels(dt4$MAX_SOILT10CM))[as.integer(dt4$MAX_SOILT10CM) ]               
  if (class(dt4$MAX_SOILT10CM)=="character") dt4$MAX_SOILT10CM <-as.numeric(dt4$MAX_SOILT10CM)
  if (class(dt4$N_SOILT10CM)=="factor") dt4$N_SOILT10CM <-as.numeric(levels(dt4$N_SOILT10CM))[as.integer(dt4$N_SOILT10CM) ]               
  if (class(dt4$N_SOILT10CM)=="character") dt4$N_SOILT10CM <-as.numeric(dt4$N_SOILT10CM)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_SOILT0CM <- ifelse((trimws(as.character(dt4$AVG_SOILT0CM))==trimws("Null")),NA,dt4$AVG_SOILT0CM)               
  suppressWarnings(dt4$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT0CM))
  dt4$STD_SOILT0CM <- ifelse((trimws(as.character(dt4$STD_SOILT0CM))==trimws("Null")),NA,dt4$STD_SOILT0CM)               
  suppressWarnings(dt4$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT0CM))
  dt4$MIN_SOILT0CM <- ifelse((trimws(as.character(dt4$MIN_SOILT0CM))==trimws("Null")),NA,dt4$MIN_SOILT0CM)               
  suppressWarnings(dt4$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT0CM))
  dt4$MAX_SOILT0CM <- ifelse((trimws(as.character(dt4$MAX_SOILT0CM))==trimws("Null")),NA,dt4$MAX_SOILT0CM)               
  suppressWarnings(dt4$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT0CM))
  dt4$AVG_SOILT5CM <- ifelse((trimws(as.character(dt4$AVG_SOILT5CM))==trimws("Null")),NA,dt4$AVG_SOILT5CM)               
  suppressWarnings(dt4$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT5CM))
  dt4$STD_SOILT5CM <- ifelse((trimws(as.character(dt4$STD_SOILT5CM))==trimws("Null")),NA,dt4$STD_SOILT5CM)               
  suppressWarnings(dt4$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT5CM))
  dt4$MIN_SOILT5CM <- ifelse((trimws(as.character(dt4$MIN_SOILT5CM))==trimws("Null")),NA,dt4$MIN_SOILT5CM)               
  suppressWarnings(dt4$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT5CM))
  dt4$MAX_SOILT5CM <- ifelse((trimws(as.character(dt4$MAX_SOILT5CM))==trimws("Null")),NA,dt4$MAX_SOILT5CM)               
  suppressWarnings(dt4$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT5CM))
  dt4$AVG_SOILT10CM <- ifelse((trimws(as.character(dt4$AVG_SOILT10CM))==trimws("Null")),NA,dt4$AVG_SOILT10CM)               
  suppressWarnings(dt4$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$AVG_SOILT10CM))
  dt4$STD_SOILT10CM <- ifelse((trimws(as.character(dt4$STD_SOILT10CM))==trimws("Null")),NA,dt4$STD_SOILT10CM)               
  suppressWarnings(dt4$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$STD_SOILT10CM))
  dt4$MIN_SOILT10CM <- ifelse((trimws(as.character(dt4$MIN_SOILT10CM))==trimws("Null")),NA,dt4$MIN_SOILT10CM)               
  suppressWarnings(dt4$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MIN_SOILT10CM))
  dt4$MAX_SOILT10CM <- ifelse((trimws(as.character(dt4$MAX_SOILT10CM))==trimws("Null")),NA,dt4$MAX_SOILT10CM)               
  suppressWarnings(dt4$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt4$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/11d491d61ae55aa8f4b502ad77e71bda" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURF_CHANGE",     
                   "STD_SURF_CHANGE",     
                   "MIN_SURF_CHANGE",     
                   "MAX_SURF_CHANGE",     
                   "N_SURF_CHANGE",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURF_CHANGE)=="factor") dt5$AVG_SURF_CHANGE <-as.numeric(levels(dt5$AVG_SURF_CHANGE))[as.integer(dt5$AVG_SURF_CHANGE) ]               
  if (class(dt5$AVG_SURF_CHANGE)=="character") dt5$AVG_SURF_CHANGE <-as.numeric(dt5$AVG_SURF_CHANGE)
  if (class(dt5$STD_SURF_CHANGE)=="factor") dt5$STD_SURF_CHANGE <-as.numeric(levels(dt5$STD_SURF_CHANGE))[as.integer(dt5$STD_SURF_CHANGE) ]               
  if (class(dt5$STD_SURF_CHANGE)=="character") dt5$STD_SURF_CHANGE <-as.numeric(dt5$STD_SURF_CHANGE)
  if (class(dt5$MIN_SURF_CHANGE)=="factor") dt5$MIN_SURF_CHANGE <-as.numeric(levels(dt5$MIN_SURF_CHANGE))[as.integer(dt5$MIN_SURF_CHANGE) ]               
  if (class(dt5$MIN_SURF_CHANGE)=="character") dt5$MIN_SURF_CHANGE <-as.numeric(dt5$MIN_SURF_CHANGE)
  if (class(dt5$MAX_SURF_CHANGE)=="factor") dt5$MAX_SURF_CHANGE <-as.numeric(levels(dt5$MAX_SURF_CHANGE))[as.integer(dt5$MAX_SURF_CHANGE) ]               
  if (class(dt5$MAX_SURF_CHANGE)=="character") dt5$MAX_SURF_CHANGE <-as.numeric(dt5$MAX_SURF_CHANGE)
  if (class(dt5$N_SURF_CHANGE)=="factor") dt5$N_SURF_CHANGE <-as.numeric(levels(dt5$N_SURF_CHANGE))[as.integer(dt5$N_SURF_CHANGE) ]               
  if (class(dt5$N_SURF_CHANGE)=="character") dt5$N_SURF_CHANGE <-as.numeric(dt5$N_SURF_CHANGE)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURF_CHANGE <- ifelse((trimws(as.character(dt5$AVG_SURF_CHANGE))==trimws("Null")),NA,dt5$AVG_SURF_CHANGE)               
  suppressWarnings(dt5$AVG_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURF_CHANGE))
  dt5$STD_SURF_CHANGE <- ifelse((trimws(as.character(dt5$STD_SURF_CHANGE))==trimws("Null")),NA,dt5$STD_SURF_CHANGE)               
  suppressWarnings(dt5$STD_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$STD_SURF_CHANGE))
  dt5$MIN_SURF_CHANGE <- ifelse((trimws(as.character(dt5$MIN_SURF_CHANGE))==trimws("Null")),NA,dt5$MIN_SURF_CHANGE)               
  suppressWarnings(dt5$MIN_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURF_CHANGE))
  dt5$MAX_SURF_CHANGE <- ifelse((trimws(as.character(dt5$MAX_SURF_CHANGE))==trimws("Null")),NA,dt5$MAX_SURF_CHANGE)               
  suppressWarnings(dt5$MAX_SURF_CHANGE <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURF_CHANGE))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURF_CHANGE))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURF_CHANGE)
  summary(STD_SURF_CHANGE)
  summary(MIN_SURF_CHANGE)
  summary(MAX_SURF_CHANGE)
  summary(N_SURF_CHANGE)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7116/8/8bd8cad9978bfcde5f668b56d05ef607" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt2
  humidity <- dt3
  soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7416/download?token=sl9yYDAK-HsboHJ2rBGgrJlJxqRc1RAMdxYfFDhH66g")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No 5cm depth

if(location == "Miers Valley"){
  
  pdf('MiersValleygraphs.pdf')
  
  # Package ID: knb-lter-mcm.7120.6 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Miers Valley Meteorological Station (MISM), McMurdo Dry Valleys, Antarctica (2012-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/ab5bf244cbf7fae859d5f0791a895ddb" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/3512220983ecfdecc25058e35a58e7ba" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PRESSTA",     
                   "STD_PRESSTA",     
                   "MIN_PRESSTA",     
                   "MAX_PRESSTA",     
                   "N_PRESSTA",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PRESSTA)=="factor") dt2$AVG_PRESSTA <-as.numeric(levels(dt2$AVG_PRESSTA))[as.integer(dt2$AVG_PRESSTA) ]               
  if (class(dt2$AVG_PRESSTA)=="character") dt2$AVG_PRESSTA <-as.numeric(dt2$AVG_PRESSTA)
  if (class(dt2$STD_PRESSTA)=="factor") dt2$STD_PRESSTA <-as.numeric(levels(dt2$STD_PRESSTA))[as.integer(dt2$STD_PRESSTA) ]               
  if (class(dt2$STD_PRESSTA)=="character") dt2$STD_PRESSTA <-as.numeric(dt2$STD_PRESSTA)
  if (class(dt2$MIN_PRESSTA)=="factor") dt2$MIN_PRESSTA <-as.numeric(levels(dt2$MIN_PRESSTA))[as.integer(dt2$MIN_PRESSTA) ]               
  if (class(dt2$MIN_PRESSTA)=="character") dt2$MIN_PRESSTA <-as.numeric(dt2$MIN_PRESSTA)
  if (class(dt2$MAX_PRESSTA)=="factor") dt2$MAX_PRESSTA <-as.numeric(levels(dt2$MAX_PRESSTA))[as.integer(dt2$MAX_PRESSTA) ]               
  if (class(dt2$MAX_PRESSTA)=="character") dt2$MAX_PRESSTA <-as.numeric(dt2$MAX_PRESSTA)
  if (class(dt2$N_PRESSTA)=="factor") dt2$N_PRESSTA <-as.numeric(levels(dt2$N_PRESSTA))[as.integer(dt2$N_PRESSTA) ]               
  if (class(dt2$N_PRESSTA)=="character") dt2$N_PRESSTA <-as.numeric(dt2$N_PRESSTA)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PRESSTA)
  summary(STD_PRESSTA)
  summary(MIN_PRESSTA)
  summary(MAX_PRESSTA)
  summary(N_PRESSTA)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/6322570177ab42133a9153b971433892" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_PAR)=="factor") dt3$AVG_PAR <-as.numeric(levels(dt3$AVG_PAR))[as.integer(dt3$AVG_PAR) ]               
  if (class(dt3$AVG_PAR)=="character") dt3$AVG_PAR <-as.numeric(dt3$AVG_PAR)
  if (class(dt3$STD_PAR)=="factor") dt3$STD_PAR <-as.numeric(levels(dt3$STD_PAR))[as.integer(dt3$STD_PAR) ]               
  if (class(dt3$STD_PAR)=="character") dt3$STD_PAR <-as.numeric(dt3$STD_PAR)
  if (class(dt3$MIN_PAR)=="factor") dt3$MIN_PAR <-as.numeric(levels(dt3$MIN_PAR))[as.integer(dt3$MIN_PAR) ]               
  if (class(dt3$MIN_PAR)=="character") dt3$MIN_PAR <-as.numeric(dt3$MIN_PAR)
  if (class(dt3$MAX_PAR)=="factor") dt3$MAX_PAR <-as.numeric(levels(dt3$MAX_PAR))[as.integer(dt3$MAX_PAR) ]               
  if (class(dt3$MAX_PAR)=="character") dt3$MAX_PAR <-as.numeric(dt3$MAX_PAR)
  if (class(dt3$N_PAR)=="factor") dt3$N_PAR <-as.numeric(levels(dt3$N_PAR))[as.integer(dt3$N_PAR) ]               
  if (class(dt3$N_PAR)=="character") dt3$N_PAR <-as.numeric(dt3$N_PAR)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_PAR <- ifelse((trimws(as.character(dt3$AVG_PAR))==trimws("Null")),NA,dt3$AVG_PAR)               
  suppressWarnings(dt3$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt3$AVG_PAR))
  dt3$STD_PAR <- ifelse((trimws(as.character(dt3$STD_PAR))==trimws("Null")),NA,dt3$STD_PAR)               
  suppressWarnings(dt3$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_PAR))==as.character(as.numeric("Null"))),NA,dt3$STD_PAR))
  dt3$MIN_PAR <- ifelse((trimws(as.character(dt3$MIN_PAR))==trimws("Null")),NA,dt3$MIN_PAR)               
  suppressWarnings(dt3$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt3$MIN_PAR))
  dt3$MAX_PAR <- ifelse((trimws(as.character(dt3$MAX_PAR))==trimws("Null")),NA,dt3$MAX_PAR)               
  suppressWarnings(dt3$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt3$MAX_PAR))
  dt3$AVG_SWRADIN <- ifelse((trimws(as.character(dt3$AVG_SWRADIN))==trimws("Null")),NA,dt3$AVG_SWRADIN)               
  suppressWarnings(dt3$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADIN))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/111483c3d843bc777997dc1a3d6bc930" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/faaa412125712a7a04bddd3fa34e4d77" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "DATE_TIME",     
                   "METLOCID",     
                   "AVG_SOILT0CM",     
                   "STDDEV_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT10CM",     
                   "STDDEV_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SOILT0CM)=="factor") dt5$AVG_SOILT0CM <-as.numeric(levels(dt5$AVG_SOILT0CM))[as.integer(dt5$AVG_SOILT0CM) ]               
  if (class(dt5$AVG_SOILT0CM)=="character") dt5$AVG_SOILT0CM <-as.numeric(dt5$AVG_SOILT0CM)
  if (class(dt5$STDDEV_SOILT0CM)=="factor") dt5$STDDEV_SOILT0CM <-as.numeric(levels(dt5$STDDEV_SOILT0CM))[as.integer(dt5$STDDEV_SOILT0CM) ]               
  if (class(dt5$STDDEV_SOILT0CM)=="character") dt5$STDDEV_SOILT0CM <-as.numeric(dt5$STDDEV_SOILT0CM)
  if (class(dt5$MIN_SOILT0CM)=="factor") dt5$MIN_SOILT0CM <-as.numeric(levels(dt5$MIN_SOILT0CM))[as.integer(dt5$MIN_SOILT0CM) ]               
  if (class(dt5$MIN_SOILT0CM)=="character") dt5$MIN_SOILT0CM <-as.numeric(dt5$MIN_SOILT0CM)
  if (class(dt5$MAX_SOILT0CM)=="factor") dt5$MAX_SOILT0CM <-as.numeric(levels(dt5$MAX_SOILT0CM))[as.integer(dt5$MAX_SOILT0CM) ]               
  if (class(dt5$MAX_SOILT0CM)=="character") dt5$MAX_SOILT0CM <-as.numeric(dt5$MAX_SOILT0CM)
  if (class(dt5$N_SOILT0CM)=="factor") dt5$N_SOILT0CM <-as.numeric(levels(dt5$N_SOILT0CM))[as.integer(dt5$N_SOILT0CM) ]               
  if (class(dt5$N_SOILT0CM)=="character") dt5$N_SOILT0CM <-as.numeric(dt5$N_SOILT0CM)
  if (class(dt5$AVG_SOILT10CM)=="factor") dt5$AVG_SOILT10CM <-as.numeric(levels(dt5$AVG_SOILT10CM))[as.integer(dt5$AVG_SOILT10CM) ]               
  if (class(dt5$AVG_SOILT10CM)=="character") dt5$AVG_SOILT10CM <-as.numeric(dt5$AVG_SOILT10CM)
  if (class(dt5$STDDEV_SOILT10CM)=="factor") dt5$STDDEV_SOILT10CM <-as.numeric(levels(dt5$STDDEV_SOILT10CM))[as.integer(dt5$STDDEV_SOILT10CM) ]               
  if (class(dt5$STDDEV_SOILT10CM)=="character") dt5$STDDEV_SOILT10CM <-as.numeric(dt5$STDDEV_SOILT10CM)
  if (class(dt5$MIN_SOILT10CM)=="factor") dt5$MIN_SOILT10CM <-as.numeric(levels(dt5$MIN_SOILT10CM))[as.integer(dt5$MIN_SOILT10CM) ]               
  if (class(dt5$MIN_SOILT10CM)=="character") dt5$MIN_SOILT10CM <-as.numeric(dt5$MIN_SOILT10CM)
  if (class(dt5$MAX_SOILT10CM)=="factor") dt5$MAX_SOILT10CM <-as.numeric(levels(dt5$MAX_SOILT10CM))[as.integer(dt5$MAX_SOILT10CM) ]               
  if (class(dt5$MAX_SOILT10CM)=="character") dt5$MAX_SOILT10CM <-as.numeric(dt5$MAX_SOILT10CM)
  if (class(dt5$N_SOILT10CM)=="factor") dt5$N_SOILT10CM <-as.numeric(levels(dt5$N_SOILT10CM))[as.integer(dt5$N_SOILT10CM) ]               
  if (class(dt5$N_SOILT10CM)=="character") dt5$N_SOILT10CM <-as.numeric(dt5$N_SOILT10CM)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SOILT0CM <- ifelse((trimws(as.character(dt5$AVG_SOILT0CM))==trimws("Null")),NA,dt5$AVG_SOILT0CM)               
  suppressWarnings(dt5$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt5$AVG_SOILT0CM))
  dt5$STDDEV_SOILT0CM <- ifelse((trimws(as.character(dt5$STDDEV_SOILT0CM))==trimws("Null")),NA,dt5$STDDEV_SOILT0CM)               
  suppressWarnings(dt5$STDDEV_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STDDEV_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt5$STDDEV_SOILT0CM))
  dt5$MIN_SOILT0CM <- ifelse((trimws(as.character(dt5$MIN_SOILT0CM))==trimws("Null")),NA,dt5$MIN_SOILT0CM)               
  suppressWarnings(dt5$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt5$MIN_SOILT0CM))
  dt5$MAX_SOILT0CM <- ifelse((trimws(as.character(dt5$MAX_SOILT0CM))==trimws("Null")),NA,dt5$MAX_SOILT0CM)               
  suppressWarnings(dt5$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt5$MAX_SOILT0CM))
  dt5$AVG_SOILT10CM <- ifelse((trimws(as.character(dt5$AVG_SOILT10CM))==trimws("Null")),NA,dt5$AVG_SOILT10CM)               
  suppressWarnings(dt5$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt5$AVG_SOILT10CM))
  dt5$STDDEV_SOILT10CM <- ifelse((trimws(as.character(dt5$STDDEV_SOILT10CM))==trimws("Null")),NA,dt5$STDDEV_SOILT10CM)               
  suppressWarnings(dt5$STDDEV_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STDDEV_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt5$STDDEV_SOILT10CM))
  dt5$MIN_SOILT10CM <- ifelse((trimws(as.character(dt5$MIN_SOILT10CM))==trimws("Null")),NA,dt5$MIN_SOILT10CM)               
  suppressWarnings(dt5$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt5$MIN_SOILT10CM))
  dt5$MAX_SOILT10CM <- ifelse((trimws(as.character(dt5$MAX_SOILT10CM))==trimws("Null")),NA,dt5$MAX_SOILT10CM)               
  suppressWarnings(dt5$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt5$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(DATE_TIME)
  summary(METLOCID)
  summary(AVG_SOILT0CM)
  summary(STDDEV_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT10CM)
  summary(STDDEV_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7120/6/5d5d7fbed4dd052e747039974e5bbc1f" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)!="factor") dt6$N_COMMENTS<- as.factor(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID)) 
  summary(as.factor(dt6$N_COMMENTS))
  detach(dt6)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  soiltemp <- dt5
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7381/download?token=oxVTSvNaGD8ruSomIXWPShUzWsn02qLO_7cVKi59YdY")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil

if(location == "Mount Fleming"){
  
  pdf('MountFleminggraphs.pdf')
  
  # Package ID: knb-lter-mcm.7118.7 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Mount Fleming Meteorological Station (FLMM), McMurdo Dry Valleys, Antarctica (2011-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7118/7/d4ac80d73f5d0d15e9173b2e150d2deb" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT2M",     
                   "STDDEV_AIRT2M",     
                   "MIN_AIRT2M",     
                   "MAX_AIRT2M",     
                   "N_AIRT2M",     
                   "AVG_AIRT3M",     
                   "STDDEV_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT2M)=="factor") dt1$AVG_AIRT2M <-as.numeric(levels(dt1$AVG_AIRT2M))[as.integer(dt1$AVG_AIRT2M) ]               
  if (class(dt1$AVG_AIRT2M)=="character") dt1$AVG_AIRT2M <-as.numeric(dt1$AVG_AIRT2M)
  if (class(dt1$STDDEV_AIRT2M)=="factor") dt1$STDDEV_AIRT2M <-as.numeric(levels(dt1$STDDEV_AIRT2M))[as.integer(dt1$STDDEV_AIRT2M) ]               
  if (class(dt1$STDDEV_AIRT2M)=="character") dt1$STDDEV_AIRT2M <-as.numeric(dt1$STDDEV_AIRT2M)
  if (class(dt1$MIN_AIRT2M)=="factor") dt1$MIN_AIRT2M <-as.numeric(levels(dt1$MIN_AIRT2M))[as.integer(dt1$MIN_AIRT2M) ]               
  if (class(dt1$MIN_AIRT2M)=="character") dt1$MIN_AIRT2M <-as.numeric(dt1$MIN_AIRT2M)
  if (class(dt1$MAX_AIRT2M)=="factor") dt1$MAX_AIRT2M <-as.numeric(levels(dt1$MAX_AIRT2M))[as.integer(dt1$MAX_AIRT2M) ]               
  if (class(dt1$MAX_AIRT2M)=="character") dt1$MAX_AIRT2M <-as.numeric(dt1$MAX_AIRT2M)
  if (class(dt1$N_AIRT2M)=="factor") dt1$N_AIRT2M <-as.numeric(levels(dt1$N_AIRT2M))[as.integer(dt1$N_AIRT2M) ]               
  if (class(dt1$N_AIRT2M)=="character") dt1$N_AIRT2M <-as.numeric(dt1$N_AIRT2M)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STDDEV_AIRT3M)=="factor") dt1$STDDEV_AIRT3M <-as.numeric(levels(dt1$STDDEV_AIRT3M))[as.integer(dt1$STDDEV_AIRT3M) ]               
  if (class(dt1$STDDEV_AIRT3M)=="character") dt1$STDDEV_AIRT3M <-as.numeric(dt1$STDDEV_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT2M <- ifelse((trimws(as.character(dt1$AVG_AIRT2M))==trimws("Null")),NA,dt1$AVG_AIRT2M)               
  suppressWarnings(dt1$AVG_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT2M))
  dt1$STDDEV_AIRT2M <- ifelse((trimws(as.character(dt1$STDDEV_AIRT2M))==trimws("Null")),NA,dt1$STDDEV_AIRT2M)               
  suppressWarnings(dt1$STDDEV_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STDDEV_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$STDDEV_AIRT2M))
  dt1$MIN_AIRT2M <- ifelse((trimws(as.character(dt1$MIN_AIRT2M))==trimws("Null")),NA,dt1$MIN_AIRT2M)               
  suppressWarnings(dt1$MIN_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT2M))
  dt1$MAX_AIRT2M <- ifelse((trimws(as.character(dt1$MAX_AIRT2M))==trimws("Null")),NA,dt1$MAX_AIRT2M)               
  suppressWarnings(dt1$MAX_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT2M))
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STDDEV_AIRT3M <- ifelse((trimws(as.character(dt1$STDDEV_AIRT3M))==trimws("Null")),NA,dt1$STDDEV_AIRT3M)               
  suppressWarnings(dt1$STDDEV_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STDDEV_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STDDEV_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$N_AIRT3M <- ifelse((trimws(as.character(dt1$N_AIRT3M))==trimws("Null")),NA,dt1$N_AIRT3M)               
  suppressWarnings(dt1$N_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$N_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$N_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT2M)
  summary(STDDEV_AIRT2M)
  summary(MIN_AIRT2M)
  summary(MAX_AIRT2M)
  summary(N_AIRT2M)
  summary(AVG_AIRT3M)
  summary(STDDEV_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7118/7/2bfef2772cfdd88053a3bab469137c8e" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PRESSTA",     
                   "STD_PRESSTA",     
                   "MIN_PRESSTA",     
                   "MAX_PRESSTA",     
                   "N_PRESSTA",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PRESSTA)=="factor") dt2$AVG_PRESSTA <-as.numeric(levels(dt2$AVG_PRESSTA))[as.integer(dt2$AVG_PRESSTA) ]               
  if (class(dt2$AVG_PRESSTA)=="character") dt2$AVG_PRESSTA <-as.numeric(dt2$AVG_PRESSTA)
  if (class(dt2$STD_PRESSTA)=="factor") dt2$STD_PRESSTA <-as.numeric(levels(dt2$STD_PRESSTA))[as.integer(dt2$STD_PRESSTA) ]               
  if (class(dt2$STD_PRESSTA)=="character") dt2$STD_PRESSTA <-as.numeric(dt2$STD_PRESSTA)
  if (class(dt2$MIN_PRESSTA)=="factor") dt2$MIN_PRESSTA <-as.numeric(levels(dt2$MIN_PRESSTA))[as.integer(dt2$MIN_PRESSTA) ]               
  if (class(dt2$MIN_PRESSTA)=="character") dt2$MIN_PRESSTA <-as.numeric(dt2$MIN_PRESSTA)
  if (class(dt2$MAX_PRESSTA)=="factor") dt2$MAX_PRESSTA <-as.numeric(levels(dt2$MAX_PRESSTA))[as.integer(dt2$MAX_PRESSTA) ]               
  if (class(dt2$MAX_PRESSTA)=="character") dt2$MAX_PRESSTA <-as.numeric(dt2$MAX_PRESSTA)
  if (class(dt2$N_PRESSTA)=="factor") dt2$N_PRESSTA <-as.numeric(levels(dt2$N_PRESSTA))[as.integer(dt2$N_PRESSTA) ]               
  if (class(dt2$N_PRESSTA)=="character") dt2$N_PRESSTA <-as.numeric(dt2$N_PRESSTA)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PRESSTA <- ifelse((trimws(as.character(dt2$AVG_PRESSTA))==trimws("NULL")),NA,dt2$AVG_PRESSTA)               
  suppressWarnings(dt2$AVG_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt2$AVG_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt2$AVG_PRESSTA))
  dt2$STD_PRESSTA <- ifelse((trimws(as.character(dt2$STD_PRESSTA))==trimws("NULL")),NA,dt2$STD_PRESSTA)               
  suppressWarnings(dt2$STD_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt2$STD_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt2$STD_PRESSTA))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PRESSTA)
  summary(STD_PRESSTA)
  summary(MIN_PRESSTA)
  summary(MAX_PRESSTA)
  summary(N_PRESSTA)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7118/7/1ddfc947c53fc587cd9f8c48ecb85fc2" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_RH)=="factor") dt3$AVG_RH <-as.numeric(levels(dt3$AVG_RH))[as.integer(dt3$AVG_RH) ]               
  if (class(dt3$AVG_RH)=="character") dt3$AVG_RH <-as.numeric(dt3$AVG_RH)
  if (class(dt3$STD_RH)=="factor") dt3$STD_RH <-as.numeric(levels(dt3$STD_RH))[as.integer(dt3$STD_RH) ]               
  if (class(dt3$STD_RH)=="character") dt3$STD_RH <-as.numeric(dt3$STD_RH)
  if (class(dt3$MIN_RH)=="factor") dt3$MIN_RH <-as.numeric(levels(dt3$MIN_RH))[as.integer(dt3$MIN_RH) ]               
  if (class(dt3$MIN_RH)=="character") dt3$MIN_RH <-as.numeric(dt3$MIN_RH)
  if (class(dt3$MAX_RH)=="factor") dt3$MAX_RH <-as.numeric(levels(dt3$MAX_RH))[as.integer(dt3$MAX_RH) ]               
  if (class(dt3$MAX_RH)=="character") dt3$MAX_RH <-as.numeric(dt3$MAX_RH)
  if (class(dt3$N_RH)=="factor") dt3$N_RH <-as.numeric(levels(dt3$N_RH))[as.integer(dt3$N_RH) ]               
  if (class(dt3$N_RH)=="character") dt3$N_RH <-as.numeric(dt3$N_RH)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7118/7/9d319a4f02a05bd405214fb7af4fb9ed" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)                                   
  if (class(dt4$AVG_WSPD)=="factor") dt4$AVG_WSPD <-as.numeric(levels(dt4$AVG_WSPD))[as.integer(dt4$AVG_WSPD) ]               
  if (class(dt4$AVG_WSPD)=="character") dt4$AVG_WSPD <-as.numeric(dt4$AVG_WSPD)
  if (class(dt4$STDDEV_WSPD)=="factor") dt4$STDDEV_WSPD <-as.numeric(levels(dt4$STDDEV_WSPD))[as.integer(dt4$STDDEV_WSPD) ]               
  if (class(dt4$STDDEV_WSPD)=="character") dt4$STDDEV_WSPD <-as.numeric(dt4$STDDEV_WSPD)
  if (class(dt4$MIN_WSPD)=="factor") dt4$MIN_WSPD <-as.numeric(levels(dt4$MIN_WSPD))[as.integer(dt4$MIN_WSPD) ]               
  if (class(dt4$MIN_WSPD)=="character") dt4$MIN_WSPD <-as.numeric(dt4$MIN_WSPD)
  if (class(dt4$MAX_WSPD)=="factor") dt4$MAX_WSPD <-as.numeric(levels(dt4$MAX_WSPD))[as.integer(dt4$MAX_WSPD) ]               
  if (class(dt4$MAX_WSPD)=="character") dt4$MAX_WSPD <-as.numeric(dt4$MAX_WSPD)
  if (class(dt4$N_WSPD)=="factor") dt4$N_WSPD <-as.numeric(levels(dt4$N_WSPD))[as.integer(dt4$N_WSPD) ]               
  if (class(dt4$N_WSPD)=="character") dt4$N_WSPD <-as.numeric(dt4$N_WSPD)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  ##Remane Data
  airtemp <- dt1 
  #radiation <- dt2
  humidity <- dt3
  #soiltemp <- dt4
  windspeed <- dt4
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7350/download?token=MMEDZqt5NJkh5sVoS3JWbgkMxyUoBssxJToUWYIH35c")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil

if(location == "Taylor Glacier"){
  
  pdf('TaylorGlaciergraphs.pdf')
  
  # Package ID: knb-lter-mcm.7113.10 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Taylor Glacier Meteorological Station (TARM), McMurdo Dry Valleys, Antarctica (1994-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/df588c2104d4b26d9ad1e272b7e271c0" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT1M",     
                   "STD_AIRT1M",     
                   "MIN_AIRT1M",     
                   "MAX_AIRT1M",     
                   "N_AIRT1M",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT1M)=="factor") dt1$AVG_AIRT1M <-as.numeric(levels(dt1$AVG_AIRT1M))[as.integer(dt1$AVG_AIRT1M) ]               
  if (class(dt1$AVG_AIRT1M)=="character") dt1$AVG_AIRT1M <-as.numeric(dt1$AVG_AIRT1M)
  if (class(dt1$STD_AIRT1M)=="factor") dt1$STD_AIRT1M <-as.numeric(levels(dt1$STD_AIRT1M))[as.integer(dt1$STD_AIRT1M) ]               
  if (class(dt1$STD_AIRT1M)=="character") dt1$STD_AIRT1M <-as.numeric(dt1$STD_AIRT1M)
  if (class(dt1$MIN_AIRT1M)=="factor") dt1$MIN_AIRT1M <-as.numeric(levels(dt1$MIN_AIRT1M))[as.integer(dt1$MIN_AIRT1M) ]               
  if (class(dt1$MIN_AIRT1M)=="character") dt1$MIN_AIRT1M <-as.numeric(dt1$MIN_AIRT1M)
  if (class(dt1$MAX_AIRT1M)=="factor") dt1$MAX_AIRT1M <-as.numeric(levels(dt1$MAX_AIRT1M))[as.integer(dt1$MAX_AIRT1M) ]               
  if (class(dt1$MAX_AIRT1M)=="character") dt1$MAX_AIRT1M <-as.numeric(dt1$MAX_AIRT1M)
  if (class(dt1$N_AIRT1M)=="factor") dt1$N_AIRT1M <-as.numeric(levels(dt1$N_AIRT1M))[as.integer(dt1$N_AIRT1M) ]               
  if (class(dt1$N_AIRT1M)=="character") dt1$N_AIRT1M <-as.numeric(dt1$N_AIRT1M)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT1M <- ifelse((trimws(as.character(dt1$AVG_AIRT1M))==trimws("Null")),NA,dt1$AVG_AIRT1M)               
  suppressWarnings(dt1$AVG_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT1M))
  dt1$STD_AIRT1M <- ifelse((trimws(as.character(dt1$STD_AIRT1M))==trimws("Null")),NA,dt1$STD_AIRT1M)               
  suppressWarnings(dt1$STD_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT1M))
  dt1$MIN_AIRT1M <- ifelse((trimws(as.character(dt1$MIN_AIRT1M))==trimws("Null")),NA,dt1$MIN_AIRT1M)               
  suppressWarnings(dt1$MIN_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT1M))
  dt1$MAX_AIRT1M <- ifelse((trimws(as.character(dt1$MAX_AIRT1M))==trimws("Null")),NA,dt1$MAX_AIRT1M)               
  suppressWarnings(dt1$MAX_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT1M))
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$N_COMMENTS <- ifelse((trimws(as.character(dt1$N_COMMENTS))==trimws("Null")),NA,dt1$N_COMMENTS)               
  suppressWarnings(dt1$N_COMMENTS <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$N_COMMENTS))==as.character(as.numeric("Null"))),NA,dt1$N_COMMENTS))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT1M)
  summary(STD_AIRT1M)
  summary(MIN_AIRT1M)
  summary(MAX_AIRT1M)
  summary(N_AIRT1M)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/d2f41bf13d0926bd50d5973b8293775a" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_DEPTH",     
                   "STD_DEPTH",     
                   "MIN_DEPTH",     
                   "MAX_DEPTH",     
                   "N_DEPTH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_DEPTH)=="factor") dt2$AVG_DEPTH <-as.numeric(levels(dt2$AVG_DEPTH))[as.integer(dt2$AVG_DEPTH) ]               
  if (class(dt2$AVG_DEPTH)=="character") dt2$AVG_DEPTH <-as.numeric(dt2$AVG_DEPTH)
  if (class(dt2$STD_DEPTH)=="factor") dt2$STD_DEPTH <-as.numeric(levels(dt2$STD_DEPTH))[as.integer(dt2$STD_DEPTH) ]               
  if (class(dt2$STD_DEPTH)=="character") dt2$STD_DEPTH <-as.numeric(dt2$STD_DEPTH)
  if (class(dt2$MIN_DEPTH)=="factor") dt2$MIN_DEPTH <-as.numeric(levels(dt2$MIN_DEPTH))[as.integer(dt2$MIN_DEPTH) ]               
  if (class(dt2$MIN_DEPTH)=="character") dt2$MIN_DEPTH <-as.numeric(dt2$MIN_DEPTH)
  if (class(dt2$MAX_DEPTH)=="factor") dt2$MAX_DEPTH <-as.numeric(levels(dt2$MAX_DEPTH))[as.integer(dt2$MAX_DEPTH) ]               
  if (class(dt2$MAX_DEPTH)=="character") dt2$MAX_DEPTH <-as.numeric(dt2$MAX_DEPTH)
  if (class(dt2$N_DEPTH)=="factor") dt2$N_DEPTH <-as.numeric(levels(dt2$N_DEPTH))[as.integer(dt2$N_DEPTH) ]               
  if (class(dt2$N_DEPTH)=="character") dt2$N_DEPTH <-as.numeric(dt2$N_DEPTH)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_DEPTH <- ifelse((trimws(as.character(dt2$AVG_DEPTH))==trimws("Null")),NA,dt2$AVG_DEPTH)               
  suppressWarnings(dt2$AVG_DEPTH <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_DEPTH))==as.character(as.numeric("Null"))),NA,dt2$AVG_DEPTH))
  dt2$STD_DEPTH <- ifelse((trimws(as.character(dt2$STD_DEPTH))==trimws("Null")),NA,dt2$STD_DEPTH)               
  suppressWarnings(dt2$STD_DEPTH <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_DEPTH))==as.character(as.numeric("Null"))),NA,dt2$STD_DEPTH))
  dt2$MIN_DEPTH <- ifelse((trimws(as.character(dt2$MIN_DEPTH))==trimws("Null")),NA,dt2$MIN_DEPTH)               
  suppressWarnings(dt2$MIN_DEPTH <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_DEPTH))==as.character(as.numeric("Null"))),NA,dt2$MIN_DEPTH))
  dt2$MAX_DEPTH <- ifelse((trimws(as.character(dt2$MAX_DEPTH))==trimws("Null")),NA,dt2$MAX_DEPTH)               
  suppressWarnings(dt2$MAX_DEPTH <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_DEPTH))==as.character(as.numeric("Null"))),NA,dt2$MAX_DEPTH))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_DEPTH)
  summary(STD_DEPTH)
  summary(MIN_DEPTH)
  summary(MAX_DEPTH)
  summary(N_DEPTH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/80fd0fc9d3619ccde82d2624f8a2ff81" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICESURF",     
                   "STDDEV_ICESURF",     
                   "MIN_ICESURF",     
                   "MAX_ICESURF",     
                   "N_ICESURF",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_ICESURF)=="factor") dt3$AVG_ICESURF <-as.numeric(levels(dt3$AVG_ICESURF))[as.integer(dt3$AVG_ICESURF) ]               
  if (class(dt3$AVG_ICESURF)=="character") dt3$AVG_ICESURF <-as.numeric(dt3$AVG_ICESURF)
  if (class(dt3$STDDEV_ICESURF)=="factor") dt3$STDDEV_ICESURF <-as.numeric(levels(dt3$STDDEV_ICESURF))[as.integer(dt3$STDDEV_ICESURF) ]               
  if (class(dt3$STDDEV_ICESURF)=="character") dt3$STDDEV_ICESURF <-as.numeric(dt3$STDDEV_ICESURF)
  if (class(dt3$MIN_ICESURF)=="factor") dt3$MIN_ICESURF <-as.numeric(levels(dt3$MIN_ICESURF))[as.integer(dt3$MIN_ICESURF) ]               
  if (class(dt3$MIN_ICESURF)=="character") dt3$MIN_ICESURF <-as.numeric(dt3$MIN_ICESURF)
  if (class(dt3$MAX_ICESURF)=="factor") dt3$MAX_ICESURF <-as.numeric(levels(dt3$MAX_ICESURF))[as.integer(dt3$MAX_ICESURF) ]               
  if (class(dt3$MAX_ICESURF)=="character") dt3$MAX_ICESURF <-as.numeric(dt3$MAX_ICESURF)
  if (class(dt3$N_ICESURF)=="factor") dt3$N_ICESURF <-as.numeric(levels(dt3$N_ICESURF))[as.integer(dt3$N_ICESURF) ]               
  if (class(dt3$N_ICESURF)=="character") dt3$N_ICESURF <-as.numeric(dt3$N_ICESURF)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_ICESURF <- ifelse((trimws(as.character(dt3$AVG_ICESURF))==trimws("Null")),NA,dt3$AVG_ICESURF)               
  suppressWarnings(dt3$AVG_ICESURF <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_ICESURF))==as.character(as.numeric("Null"))),NA,dt3$AVG_ICESURF))
  dt3$STDDEV_ICESURF <- ifelse((trimws(as.character(dt3$STDDEV_ICESURF))==trimws("Null")),NA,dt3$STDDEV_ICESURF)               
  suppressWarnings(dt3$STDDEV_ICESURF <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STDDEV_ICESURF))==as.character(as.numeric("Null"))),NA,dt3$STDDEV_ICESURF))
  dt3$MIN_ICESURF <- ifelse((trimws(as.character(dt3$MIN_ICESURF))==trimws("Null")),NA,dt3$MIN_ICESURF)               
  suppressWarnings(dt3$MIN_ICESURF <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_ICESURF))==as.character(as.numeric("Null"))),NA,dt3$MIN_ICESURF))
  dt3$MAX_ICESURF <- ifelse((trimws(as.character(dt3$MAX_ICESURF))==trimws("Null")),NA,dt3$MAX_ICESURF)               
  suppressWarnings(dt3$MAX_ICESURF <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_ICESURF))==as.character(as.numeric("Null"))),NA,dt3$MAX_ICESURF))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICESURF)
  summary(STDDEV_ICESURF)
  summary(MIN_ICESURF)
  summary(MAX_ICESURF)
  summary(N_ICESURF)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/8c1f59b1c689842183bd6df32ba55c90" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_LWRADIN2",     
                   "STD_LWRADIN2",     
                   "MIN_LWRADIN2",     
                   "MAX_LWRADIN2",     
                   "N_LWRADIN2",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_LWRADIN)=="factor") dt4$AVG_LWRADIN <-as.numeric(levels(dt4$AVG_LWRADIN))[as.integer(dt4$AVG_LWRADIN) ]               
  if (class(dt4$AVG_LWRADIN)=="character") dt4$AVG_LWRADIN <-as.numeric(dt4$AVG_LWRADIN)
  if (class(dt4$STD_LWRADIN)=="factor") dt4$STD_LWRADIN <-as.numeric(levels(dt4$STD_LWRADIN))[as.integer(dt4$STD_LWRADIN) ]               
  if (class(dt4$STD_LWRADIN)=="character") dt4$STD_LWRADIN <-as.numeric(dt4$STD_LWRADIN)
  if (class(dt4$MIN_LWRADIN)=="factor") dt4$MIN_LWRADIN <-as.numeric(levels(dt4$MIN_LWRADIN))[as.integer(dt4$MIN_LWRADIN) ]               
  if (class(dt4$MIN_LWRADIN)=="character") dt4$MIN_LWRADIN <-as.numeric(dt4$MIN_LWRADIN)
  if (class(dt4$MAX_LWRADIN)=="factor") dt4$MAX_LWRADIN <-as.numeric(levels(dt4$MAX_LWRADIN))[as.integer(dt4$MAX_LWRADIN) ]               
  if (class(dt4$MAX_LWRADIN)=="character") dt4$MAX_LWRADIN <-as.numeric(dt4$MAX_LWRADIN)
  if (class(dt4$N_LWRADIN)=="factor") dt4$N_LWRADIN <-as.numeric(levels(dt4$N_LWRADIN))[as.integer(dt4$N_LWRADIN) ]               
  if (class(dt4$N_LWRADIN)=="character") dt4$N_LWRADIN <-as.numeric(dt4$N_LWRADIN)
  if (class(dt4$AVG_LWRADIN2)=="factor") dt4$AVG_LWRADIN2 <-as.numeric(levels(dt4$AVG_LWRADIN2))[as.integer(dt4$AVG_LWRADIN2) ]               
  if (class(dt4$AVG_LWRADIN2)=="character") dt4$AVG_LWRADIN2 <-as.numeric(dt4$AVG_LWRADIN2)
  if (class(dt4$STD_LWRADIN2)=="factor") dt4$STD_LWRADIN2 <-as.numeric(levels(dt4$STD_LWRADIN2))[as.integer(dt4$STD_LWRADIN2) ]               
  if (class(dt4$STD_LWRADIN2)=="character") dt4$STD_LWRADIN2 <-as.numeric(dt4$STD_LWRADIN2)
  if (class(dt4$MIN_LWRADIN2)=="factor") dt4$MIN_LWRADIN2 <-as.numeric(levels(dt4$MIN_LWRADIN2))[as.integer(dt4$MIN_LWRADIN2) ]               
  if (class(dt4$MIN_LWRADIN2)=="character") dt4$MIN_LWRADIN2 <-as.numeric(dt4$MIN_LWRADIN2)
  if (class(dt4$MAX_LWRADIN2)=="factor") dt4$MAX_LWRADIN2 <-as.numeric(levels(dt4$MAX_LWRADIN2))[as.integer(dt4$MAX_LWRADIN2) ]               
  if (class(dt4$MAX_LWRADIN2)=="character") dt4$MAX_LWRADIN2 <-as.numeric(dt4$MAX_LWRADIN2)
  if (class(dt4$N_LWRADIN2)=="factor") dt4$N_LWRADIN2 <-as.numeric(levels(dt4$N_LWRADIN2))[as.integer(dt4$N_LWRADIN2) ]               
  if (class(dt4$N_LWRADIN2)=="character") dt4$N_LWRADIN2 <-as.numeric(dt4$N_LWRADIN2)
  if (class(dt4$AVG_SWRADIN)=="factor") dt4$AVG_SWRADIN <-as.numeric(levels(dt4$AVG_SWRADIN))[as.integer(dt4$AVG_SWRADIN) ]               
  if (class(dt4$AVG_SWRADIN)=="character") dt4$AVG_SWRADIN <-as.numeric(dt4$AVG_SWRADIN)
  if (class(dt4$STD_SWRADIN)=="factor") dt4$STD_SWRADIN <-as.numeric(levels(dt4$STD_SWRADIN))[as.integer(dt4$STD_SWRADIN) ]               
  if (class(dt4$STD_SWRADIN)=="character") dt4$STD_SWRADIN <-as.numeric(dt4$STD_SWRADIN)
  if (class(dt4$MIN_SWRADIN)=="factor") dt4$MIN_SWRADIN <-as.numeric(levels(dt4$MIN_SWRADIN))[as.integer(dt4$MIN_SWRADIN) ]               
  if (class(dt4$MIN_SWRADIN)=="character") dt4$MIN_SWRADIN <-as.numeric(dt4$MIN_SWRADIN)
  if (class(dt4$MAX_SWRADIN)=="factor") dt4$MAX_SWRADIN <-as.numeric(levels(dt4$MAX_SWRADIN))[as.integer(dt4$MAX_SWRADIN) ]               
  if (class(dt4$MAX_SWRADIN)=="character") dt4$MAX_SWRADIN <-as.numeric(dt4$MAX_SWRADIN)
  if (class(dt4$N_SWRADIN)=="factor") dt4$N_SWRADIN <-as.numeric(levels(dt4$N_SWRADIN))[as.integer(dt4$N_SWRADIN) ]               
  if (class(dt4$N_SWRADIN)=="character") dt4$N_SWRADIN <-as.numeric(dt4$N_SWRADIN)
  if (class(dt4$AVG_SWRADOUT)=="factor") dt4$AVG_SWRADOUT <-as.numeric(levels(dt4$AVG_SWRADOUT))[as.integer(dt4$AVG_SWRADOUT) ]               
  if (class(dt4$AVG_SWRADOUT)=="character") dt4$AVG_SWRADOUT <-as.numeric(dt4$AVG_SWRADOUT)
  if (class(dt4$STD_SWRADOUT)=="factor") dt4$STD_SWRADOUT <-as.numeric(levels(dt4$STD_SWRADOUT))[as.integer(dt4$STD_SWRADOUT) ]               
  if (class(dt4$STD_SWRADOUT)=="character") dt4$STD_SWRADOUT <-as.numeric(dt4$STD_SWRADOUT)
  if (class(dt4$MIN_SWRADOUT)=="factor") dt4$MIN_SWRADOUT <-as.numeric(levels(dt4$MIN_SWRADOUT))[as.integer(dt4$MIN_SWRADOUT) ]               
  if (class(dt4$MIN_SWRADOUT)=="character") dt4$MIN_SWRADOUT <-as.numeric(dt4$MIN_SWRADOUT)
  if (class(dt4$MAX_SWRADOUT)=="factor") dt4$MAX_SWRADOUT <-as.numeric(levels(dt4$MAX_SWRADOUT))[as.integer(dt4$MAX_SWRADOUT) ]               
  if (class(dt4$MAX_SWRADOUT)=="character") dt4$MAX_SWRADOUT <-as.numeric(dt4$MAX_SWRADOUT)
  if (class(dt4$N_SWRADOUT)=="factor") dt4$N_SWRADOUT <-as.numeric(levels(dt4$N_SWRADOUT))[as.integer(dt4$N_SWRADOUT) ]               
  if (class(dt4$N_SWRADOUT)=="character") dt4$N_SWRADOUT <-as.numeric(dt4$N_SWRADOUT)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt4$AVG_LWRADIN <- ifelse((trimws(as.character(dt4$AVG_LWRADIN))==trimws("Null")),NA,dt4$AVG_LWRADIN)               
  suppressWarnings(dt4$AVG_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_LWRADIN))==as.character(as.numeric("Null"))),NA,dt4$AVG_LWRADIN))
  dt4$STD_LWRADIN <- ifelse((trimws(as.character(dt4$STD_LWRADIN))==trimws("Null")),NA,dt4$STD_LWRADIN)               
  suppressWarnings(dt4$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt4$STD_LWRADIN))
  dt4$MIN_LWRADIN <- ifelse((trimws(as.character(dt4$MIN_LWRADIN))==trimws("Null")),NA,dt4$MIN_LWRADIN)               
  suppressWarnings(dt4$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MIN_LWRADIN))
  dt4$MAX_LWRADIN <- ifelse((trimws(as.character(dt4$MAX_LWRADIN))==trimws("Null")),NA,dt4$MAX_LWRADIN)               
  suppressWarnings(dt4$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MAX_LWRADIN))
  dt4$AVG_LWRADIN2 <- ifelse((trimws(as.character(dt4$AVG_LWRADIN2))==trimws("Null")),NA,dt4$AVG_LWRADIN2)               
  suppressWarnings(dt4$AVG_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt4$AVG_LWRADIN2))
  dt4$STD_LWRADIN2 <- ifelse((trimws(as.character(dt4$STD_LWRADIN2))==trimws("Null")),NA,dt4$STD_LWRADIN2)               
  suppressWarnings(dt4$STD_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt4$STD_LWRADIN2))
  dt4$MIN_LWRADIN2 <- ifelse((trimws(as.character(dt4$MIN_LWRADIN2))==trimws("Null")),NA,dt4$MIN_LWRADIN2)               
  suppressWarnings(dt4$MIN_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt4$MIN_LWRADIN2))
  dt4$MAX_LWRADIN2 <- ifelse((trimws(as.character(dt4$MAX_LWRADIN2))==trimws("Null")),NA,dt4$MAX_LWRADIN2)               
  suppressWarnings(dt4$MAX_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt4$MAX_LWRADIN2))
  dt4$AVG_SWRADIN <- ifelse((trimws(as.character(dt4$AVG_SWRADIN))==trimws("Null")),NA,dt4$AVG_SWRADIN)               
  suppressWarnings(dt4$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$AVG_SWRADIN))
  dt4$STD_SWRADIN <- ifelse((trimws(as.character(dt4$STD_SWRADIN))==trimws("Null")),NA,dt4$STD_SWRADIN)               
  suppressWarnings(dt4$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$STD_SWRADIN))
  dt4$MIN_SWRADIN <- ifelse((trimws(as.character(dt4$MIN_SWRADIN))==trimws("Null")),NA,dt4$MIN_SWRADIN)               
  suppressWarnings(dt4$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MIN_SWRADIN))
  dt4$MAX_SWRADIN <- ifelse((trimws(as.character(dt4$MAX_SWRADIN))==trimws("Null")),NA,dt4$MAX_SWRADIN)               
  suppressWarnings(dt4$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt4$MAX_SWRADIN))
  dt4$AVG_SWRADOUT <- ifelse((trimws(as.character(dt4$AVG_SWRADOUT))==trimws("Null")),NA,dt4$AVG_SWRADOUT)               
  suppressWarnings(dt4$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$AVG_SWRADOUT))
  dt4$STD_SWRADOUT <- ifelse((trimws(as.character(dt4$STD_SWRADOUT))==trimws("Null")),NA,dt4$STD_SWRADOUT)               
  suppressWarnings(dt4$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$STD_SWRADOUT))
  dt4$MIN_SWRADOUT <- ifelse((trimws(as.character(dt4$MIN_SWRADOUT))==trimws("Null")),NA,dt4$MIN_SWRADOUT)               
  suppressWarnings(dt4$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$MIN_SWRADOUT))
  dt4$MAX_SWRADOUT <- ifelse((trimws(as.character(dt4$MAX_SWRADOUT))==trimws("Null")),NA,dt4$MAX_SWRADOUT)               
  suppressWarnings(dt4$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt4$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt4$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_LWRADIN2)
  summary(STD_LWRADIN2)
  summary(MIN_LWRADIN2)
  summary(MAX_LWRADIN2)
  summary(N_LWRADIN2)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/d3e3011a809143d4cff71ecd9ea49363" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "AVG_RH1M",     
                   "STD_RH1M",     
                   "MIN_RH1M",     
                   "MAX_RH1M",     
                   "N_RH1M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_RH)=="factor") dt5$AVG_RH <-as.numeric(levels(dt5$AVG_RH))[as.integer(dt5$AVG_RH) ]               
  if (class(dt5$AVG_RH)=="character") dt5$AVG_RH <-as.numeric(dt5$AVG_RH)
  if (class(dt5$STD_RH)=="factor") dt5$STD_RH <-as.numeric(levels(dt5$STD_RH))[as.integer(dt5$STD_RH) ]               
  if (class(dt5$STD_RH)=="character") dt5$STD_RH <-as.numeric(dt5$STD_RH)
  if (class(dt5$MIN_RH)=="factor") dt5$MIN_RH <-as.numeric(levels(dt5$MIN_RH))[as.integer(dt5$MIN_RH) ]               
  if (class(dt5$MIN_RH)=="character") dt5$MIN_RH <-as.numeric(dt5$MIN_RH)
  if (class(dt5$MAX_RH)=="factor") dt5$MAX_RH <-as.numeric(levels(dt5$MAX_RH))[as.integer(dt5$MAX_RH) ]               
  if (class(dt5$MAX_RH)=="character") dt5$MAX_RH <-as.numeric(dt5$MAX_RH)
  if (class(dt5$N_RH)=="factor") dt5$N_RH <-as.numeric(levels(dt5$N_RH))[as.integer(dt5$N_RH) ]               
  if (class(dt5$N_RH)=="character") dt5$N_RH <-as.numeric(dt5$N_RH)
  if (class(dt5$AVG_RH1M)=="factor") dt5$AVG_RH1M <-as.numeric(levels(dt5$AVG_RH1M))[as.integer(dt5$AVG_RH1M) ]               
  if (class(dt5$AVG_RH1M)=="character") dt5$AVG_RH1M <-as.numeric(dt5$AVG_RH1M)
  if (class(dt5$STD_RH1M)=="factor") dt5$STD_RH1M <-as.numeric(levels(dt5$STD_RH1M))[as.integer(dt5$STD_RH1M) ]               
  if (class(dt5$STD_RH1M)=="character") dt5$STD_RH1M <-as.numeric(dt5$STD_RH1M)
  if (class(dt5$MIN_RH1M)=="factor") dt5$MIN_RH1M <-as.numeric(levels(dt5$MIN_RH1M))[as.integer(dt5$MIN_RH1M) ]               
  if (class(dt5$MIN_RH1M)=="character") dt5$MIN_RH1M <-as.numeric(dt5$MIN_RH1M)
  if (class(dt5$MAX_RH1M)=="factor") dt5$MAX_RH1M <-as.numeric(levels(dt5$MAX_RH1M))[as.integer(dt5$MAX_RH1M) ]               
  if (class(dt5$MAX_RH1M)=="character") dt5$MAX_RH1M <-as.numeric(dt5$MAX_RH1M)
  if (class(dt5$N_RH1M)=="factor") dt5$N_RH1M <-as.numeric(levels(dt5$N_RH1M))[as.integer(dt5$N_RH1M) ]               
  if (class(dt5$N_RH1M)=="character") dt5$N_RH1M <-as.numeric(dt5$N_RH1M)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(AVG_RH1M)
  summary(STD_RH1M)
  summary(MIN_RH1M)
  summary(MAX_RH1M)
  summary(N_RH1M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7113/10/50ca4981b34c691d51ca2e07fcfa766f" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)!="factor") dt6$N_COMMENTS<- as.factor(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID)) 
  summary(as.factor(dt6$N_COMMENTS))
  detach(dt6)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt4
  humidity <- dt5
  #soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7399/download?token=EO0rSEASv0FSPyAerg9_C2IUCRFbSdY3B74sY4vBVtE")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil

if(location == "Canada Glacier"){
  
  pdf('CanadaGlaciergraphs.pdf')
  
  # Package ID: knb-lter-mcm.7106.7 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Canada Glacier Meteorological Station (CAAM), McMurdo Dry Valleys, Antarctica (1994-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/0552fd97d691212bd6a7c00e39d3af28" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT2M",     
                   "STD_AIRT2M",     
                   "MIN_AIRT2M",     
                   "MAX_AIRT2M",     
                   "N_AIRT2M",     
                   "AVG_AIRT1M",     
                   "STD_AIRT1M",     
                   "MIN_AIRT1M",     
                   "MAX_AIRT1M",     
                   "N_AIRT1M",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT2M)=="factor") dt1$AVG_AIRT2M <-as.numeric(levels(dt1$AVG_AIRT2M))[as.integer(dt1$AVG_AIRT2M) ]               
  if (class(dt1$AVG_AIRT2M)=="character") dt1$AVG_AIRT2M <-as.numeric(dt1$AVG_AIRT2M)
  if (class(dt1$STD_AIRT2M)=="factor") dt1$STD_AIRT2M <-as.numeric(levels(dt1$STD_AIRT2M))[as.integer(dt1$STD_AIRT2M) ]               
  if (class(dt1$STD_AIRT2M)=="character") dt1$STD_AIRT2M <-as.numeric(dt1$STD_AIRT2M)
  if (class(dt1$MIN_AIRT2M)=="factor") dt1$MIN_AIRT2M <-as.numeric(levels(dt1$MIN_AIRT2M))[as.integer(dt1$MIN_AIRT2M) ]               
  if (class(dt1$MIN_AIRT2M)=="character") dt1$MIN_AIRT2M <-as.numeric(dt1$MIN_AIRT2M)
  if (class(dt1$MAX_AIRT2M)=="factor") dt1$MAX_AIRT2M <-as.numeric(levels(dt1$MAX_AIRT2M))[as.integer(dt1$MAX_AIRT2M) ]               
  if (class(dt1$MAX_AIRT2M)=="character") dt1$MAX_AIRT2M <-as.numeric(dt1$MAX_AIRT2M)
  if (class(dt1$N_AIRT2M)=="factor") dt1$N_AIRT2M <-as.numeric(levels(dt1$N_AIRT2M))[as.integer(dt1$N_AIRT2M) ]               
  if (class(dt1$N_AIRT2M)=="character") dt1$N_AIRT2M <-as.numeric(dt1$N_AIRT2M)
  if (class(dt1$AVG_AIRT1M)=="factor") dt1$AVG_AIRT1M <-as.numeric(levels(dt1$AVG_AIRT1M))[as.integer(dt1$AVG_AIRT1M) ]               
  if (class(dt1$AVG_AIRT1M)=="character") dt1$AVG_AIRT1M <-as.numeric(dt1$AVG_AIRT1M)
  if (class(dt1$STD_AIRT1M)=="factor") dt1$STD_AIRT1M <-as.numeric(levels(dt1$STD_AIRT1M))[as.integer(dt1$STD_AIRT1M) ]               
  if (class(dt1$STD_AIRT1M)=="character") dt1$STD_AIRT1M <-as.numeric(dt1$STD_AIRT1M)
  if (class(dt1$MIN_AIRT1M)=="factor") dt1$MIN_AIRT1M <-as.numeric(levels(dt1$MIN_AIRT1M))[as.integer(dt1$MIN_AIRT1M) ]               
  if (class(dt1$MIN_AIRT1M)=="character") dt1$MIN_AIRT1M <-as.numeric(dt1$MIN_AIRT1M)
  if (class(dt1$MAX_AIRT1M)=="factor") dt1$MAX_AIRT1M <-as.numeric(levels(dt1$MAX_AIRT1M))[as.integer(dt1$MAX_AIRT1M) ]               
  if (class(dt1$MAX_AIRT1M)=="character") dt1$MAX_AIRT1M <-as.numeric(dt1$MAX_AIRT1M)
  if (class(dt1$N_AIRT1M)=="factor") dt1$N_AIRT1M <-as.numeric(levels(dt1$N_AIRT1M))[as.integer(dt1$N_AIRT1M) ]               
  if (class(dt1$N_AIRT1M)=="character") dt1$N_AIRT1M <-as.numeric(dt1$N_AIRT1M)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT2M <- ifelse((trimws(as.character(dt1$AVG_AIRT2M))==trimws("Null")),NA,dt1$AVG_AIRT2M)               
  suppressWarnings(dt1$AVG_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT2M))
  dt1$STD_AIRT2M <- ifelse((trimws(as.character(dt1$STD_AIRT2M))==trimws("Null")),NA,dt1$STD_AIRT2M)               
  suppressWarnings(dt1$STD_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT2M))
  dt1$MIN_AIRT2M <- ifelse((trimws(as.character(dt1$MIN_AIRT2M))==trimws("Null")),NA,dt1$MIN_AIRT2M)               
  suppressWarnings(dt1$MIN_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT2M))
  dt1$MAX_AIRT2M <- ifelse((trimws(as.character(dt1$MAX_AIRT2M))==trimws("Null")),NA,dt1$MAX_AIRT2M)               
  suppressWarnings(dt1$MAX_AIRT2M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT2M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT2M))
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT2M)
  summary(STD_AIRT2M)
  summary(MIN_AIRT2M)
  summary(MAX_AIRT2M)
  summary(N_AIRT2M)
  summary(AVG_AIRT1M)
  summary(STD_AIRT1M)
  summary(MIN_AIRT1M)
  summary(MAX_AIRT1M)
  summary(N_AIRT1M)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/07dedbb1bb7acfa9413b9c401f355c3d" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3ASP",     
                   "STDDEV_AIRT3ASP",     
                   "MIN_AIRT3ASP",     
                   "MAX_AIRT3ASP",     
                   "N_AIRT3ASP",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_AIRT3ASP)=="factor") dt2$AVG_AIRT3ASP <-as.numeric(levels(dt2$AVG_AIRT3ASP))[as.integer(dt2$AVG_AIRT3ASP) ]               
  if (class(dt2$AVG_AIRT3ASP)=="character") dt2$AVG_AIRT3ASP <-as.numeric(dt2$AVG_AIRT3ASP)
  if (class(dt2$STDDEV_AIRT3ASP)=="factor") dt2$STDDEV_AIRT3ASP <-as.numeric(levels(dt2$STDDEV_AIRT3ASP))[as.integer(dt2$STDDEV_AIRT3ASP) ]               
  if (class(dt2$STDDEV_AIRT3ASP)=="character") dt2$STDDEV_AIRT3ASP <-as.numeric(dt2$STDDEV_AIRT3ASP)
  if (class(dt2$MIN_AIRT3ASP)=="factor") dt2$MIN_AIRT3ASP <-as.numeric(levels(dt2$MIN_AIRT3ASP))[as.integer(dt2$MIN_AIRT3ASP) ]               
  if (class(dt2$MIN_AIRT3ASP)=="character") dt2$MIN_AIRT3ASP <-as.numeric(dt2$MIN_AIRT3ASP)
  if (class(dt2$MAX_AIRT3ASP)=="factor") dt2$MAX_AIRT3ASP <-as.numeric(levels(dt2$MAX_AIRT3ASP))[as.integer(dt2$MAX_AIRT3ASP) ]               
  if (class(dt2$MAX_AIRT3ASP)=="character") dt2$MAX_AIRT3ASP <-as.numeric(dt2$MAX_AIRT3ASP)
  if (class(dt2$N_AIRT3ASP)!="factor") dt2$N_AIRT3ASP<- as.factor(dt2$N_AIRT3ASP)
  if (class(dt2$N_COMMENTS)!="factor") dt2$N_COMMENTS<- as.factor(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_AIRT3ASP <- ifelse((trimws(as.character(dt2$AVG_AIRT3ASP))==trimws("Null")),NA,dt2$AVG_AIRT3ASP)               
  suppressWarnings(dt2$AVG_AIRT3ASP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_AIRT3ASP))==as.character(as.numeric("Null"))),NA,dt2$AVG_AIRT3ASP))
  dt2$STDDEV_AIRT3ASP <- ifelse((trimws(as.character(dt2$STDDEV_AIRT3ASP))==trimws("Null")),NA,dt2$STDDEV_AIRT3ASP)               
  suppressWarnings(dt2$STDDEV_AIRT3ASP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STDDEV_AIRT3ASP))==as.character(as.numeric("Null"))),NA,dt2$STDDEV_AIRT3ASP))
  dt2$MIN_AIRT3ASP <- ifelse((trimws(as.character(dt2$MIN_AIRT3ASP))==trimws("Null")),NA,dt2$MIN_AIRT3ASP)               
  suppressWarnings(dt2$MIN_AIRT3ASP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_AIRT3ASP))==as.character(as.numeric("Null"))),NA,dt2$MIN_AIRT3ASP))
  dt2$MAX_AIRT3ASP <- ifelse((trimws(as.character(dt2$MAX_AIRT3ASP))==trimws("Null")),NA,dt2$MAX_AIRT3ASP)               
  suppressWarnings(dt2$MAX_AIRT3ASP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_AIRT3ASP))==as.character(as.numeric("Null"))),NA,dt2$MAX_AIRT3ASP))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3ASP)
  summary(STDDEV_AIRT3ASP)
  summary(MIN_AIRT3ASP)
  summary(MAX_AIRT3ASP)
  summary(N_AIRT3ASP)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID)) 
  summary(as.factor(dt2$N_AIRT3ASP)) 
  summary(as.factor(dt2$N_COMMENTS))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/e2cab25767588050ac5cb1da283ded59" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_THMIR",     
                   "STD_THMIR",     
                   "MIN_THMIR",     
                   "MAX_THMIR",     
                   "N_THMIR",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "AVG_NETRAD",     
                   "STD_NETRAD",     
                   "MIN_NETRAD",     
                   "MAX_NETRAD",     
                   "N_NETRAD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_THMIR)=="factor") dt3$AVG_THMIR <-as.numeric(levels(dt3$AVG_THMIR))[as.integer(dt3$AVG_THMIR) ]               
  if (class(dt3$AVG_THMIR)=="character") dt3$AVG_THMIR <-as.numeric(dt3$AVG_THMIR)
  if (class(dt3$STD_THMIR)=="factor") dt3$STD_THMIR <-as.numeric(levels(dt3$STD_THMIR))[as.integer(dt3$STD_THMIR) ]               
  if (class(dt3$STD_THMIR)=="character") dt3$STD_THMIR <-as.numeric(dt3$STD_THMIR)
  if (class(dt3$MIN_THMIR)=="factor") dt3$MIN_THMIR <-as.numeric(levels(dt3$MIN_THMIR))[as.integer(dt3$MIN_THMIR) ]               
  if (class(dt3$MIN_THMIR)=="character") dt3$MIN_THMIR <-as.numeric(dt3$MIN_THMIR)
  if (class(dt3$MAX_THMIR)=="factor") dt3$MAX_THMIR <-as.numeric(levels(dt3$MAX_THMIR))[as.integer(dt3$MAX_THMIR) ]               
  if (class(dt3$MAX_THMIR)=="character") dt3$MAX_THMIR <-as.numeric(dt3$MAX_THMIR)
  if (class(dt3$N_THMIR)=="factor") dt3$N_THMIR <-as.numeric(levels(dt3$N_THMIR))[as.integer(dt3$N_THMIR) ]               
  if (class(dt3$N_THMIR)=="character") dt3$N_THMIR <-as.numeric(dt3$N_THMIR)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$AVG_NETRAD)=="factor") dt3$AVG_NETRAD <-as.numeric(levels(dt3$AVG_NETRAD))[as.integer(dt3$AVG_NETRAD) ]               
  if (class(dt3$AVG_NETRAD)=="character") dt3$AVG_NETRAD <-as.numeric(dt3$AVG_NETRAD)
  if (class(dt3$STD_NETRAD)=="factor") dt3$STD_NETRAD <-as.numeric(levels(dt3$STD_NETRAD))[as.integer(dt3$STD_NETRAD) ]               
  if (class(dt3$STD_NETRAD)=="character") dt3$STD_NETRAD <-as.numeric(dt3$STD_NETRAD)
  if (class(dt3$MIN_NETRAD)=="factor") dt3$MIN_NETRAD <-as.numeric(levels(dt3$MIN_NETRAD))[as.integer(dt3$MIN_NETRAD) ]               
  if (class(dt3$MIN_NETRAD)=="character") dt3$MIN_NETRAD <-as.numeric(dt3$MIN_NETRAD)
  if (class(dt3$MAX_NETRAD)=="factor") dt3$MAX_NETRAD <-as.numeric(levels(dt3$MAX_NETRAD))[as.integer(dt3$MAX_NETRAD) ]               
  if (class(dt3$MAX_NETRAD)=="character") dt3$MAX_NETRAD <-as.numeric(dt3$MAX_NETRAD)
  if (class(dt3$N_NETRAD)=="factor") dt3$N_NETRAD <-as.numeric(levels(dt3$N_NETRAD))[as.integer(dt3$N_NETRAD) ]               
  if (class(dt3$N_NETRAD)=="character") dt3$N_NETRAD <-as.numeric(dt3$N_NETRAD)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$STD_THMIR <- ifelse((trimws(as.character(dt3$STD_THMIR))==trimws("Null")),NA,dt3$STD_THMIR)               
  suppressWarnings(dt3$STD_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_THMIR))==as.character(as.numeric("Null"))),NA,dt3$STD_THMIR))
  dt3$MIN_THMIR <- ifelse((trimws(as.character(dt3$MIN_THMIR))==trimws("Null")),NA,dt3$MIN_THMIR)               
  suppressWarnings(dt3$MIN_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MIN_THMIR))
  dt3$MAX_THMIR <- ifelse((trimws(as.character(dt3$MAX_THMIR))==trimws("Null")),NA,dt3$MAX_THMIR)               
  suppressWarnings(dt3$MAX_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MAX_THMIR))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  dt3$STD_NETRAD <- ifelse((trimws(as.character(dt3$STD_NETRAD))==trimws("Null")),NA,dt3$STD_NETRAD)               
  suppressWarnings(dt3$STD_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$STD_NETRAD))
  dt3$MAX_NETRAD <- ifelse((trimws(as.character(dt3$MAX_NETRAD))==trimws("Null")),NA,dt3$MAX_NETRAD)               
  suppressWarnings(dt3$MAX_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$MAX_NETRAD))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_THMIR)
  summary(STD_THMIR)
  summary(MIN_THMIR)
  summary(MAX_THMIR)
  summary(N_THMIR)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(AVG_NETRAD)
  summary(STD_NETRAD)
  summary(MIN_NETRAD)
  summary(MAX_NETRAD)
  summary(N_NETRAD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/458d2515e5f4e3a04693de7f654fe44c" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH2M",     
                   "STD_RH2M",     
                   "MIN_RH2M",     
                   "MAX_RH2M",     
                   "N_RH2M",     
                   "AVG_RH1M",     
                   "STD_RH1M",     
                   "MIN_RH1M",     
                   "MAX_RH1M",     
                   "N_RH1M",     
                   "AVG_RH3M",     
                   "STD_RH3M",     
                   "MAX_RH3M",     
                   "MIN_RH3M",     
                   "N_RH3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH2M)=="factor") dt4$AVG_RH2M <-as.numeric(levels(dt4$AVG_RH2M))[as.integer(dt4$AVG_RH2M) ]               
  if (class(dt4$AVG_RH2M)=="character") dt4$AVG_RH2M <-as.numeric(dt4$AVG_RH2M)
  if (class(dt4$STD_RH2M)=="factor") dt4$STD_RH2M <-as.numeric(levels(dt4$STD_RH2M))[as.integer(dt4$STD_RH2M) ]               
  if (class(dt4$STD_RH2M)=="character") dt4$STD_RH2M <-as.numeric(dt4$STD_RH2M)
  if (class(dt4$MIN_RH2M)=="factor") dt4$MIN_RH2M <-as.numeric(levels(dt4$MIN_RH2M))[as.integer(dt4$MIN_RH2M) ]               
  if (class(dt4$MIN_RH2M)=="character") dt4$MIN_RH2M <-as.numeric(dt4$MIN_RH2M)
  if (class(dt4$MAX_RH2M)=="factor") dt4$MAX_RH2M <-as.numeric(levels(dt4$MAX_RH2M))[as.integer(dt4$MAX_RH2M) ]               
  if (class(dt4$MAX_RH2M)=="character") dt4$MAX_RH2M <-as.numeric(dt4$MAX_RH2M)
  if (class(dt4$N_RH2M)=="factor") dt4$N_RH2M <-as.numeric(levels(dt4$N_RH2M))[as.integer(dt4$N_RH2M) ]               
  if (class(dt4$N_RH2M)=="character") dt4$N_RH2M <-as.numeric(dt4$N_RH2M)
  if (class(dt4$AVG_RH1M)=="factor") dt4$AVG_RH1M <-as.numeric(levels(dt4$AVG_RH1M))[as.integer(dt4$AVG_RH1M) ]               
  if (class(dt4$AVG_RH1M)=="character") dt4$AVG_RH1M <-as.numeric(dt4$AVG_RH1M)
  if (class(dt4$STD_RH1M)=="factor") dt4$STD_RH1M <-as.numeric(levels(dt4$STD_RH1M))[as.integer(dt4$STD_RH1M) ]               
  if (class(dt4$STD_RH1M)=="character") dt4$STD_RH1M <-as.numeric(dt4$STD_RH1M)
  if (class(dt4$MIN_RH1M)=="factor") dt4$MIN_RH1M <-as.numeric(levels(dt4$MIN_RH1M))[as.integer(dt4$MIN_RH1M) ]               
  if (class(dt4$MIN_RH1M)=="character") dt4$MIN_RH1M <-as.numeric(dt4$MIN_RH1M)
  if (class(dt4$MAX_RH1M)=="factor") dt4$MAX_RH1M <-as.numeric(levels(dt4$MAX_RH1M))[as.integer(dt4$MAX_RH1M) ]               
  if (class(dt4$MAX_RH1M)=="character") dt4$MAX_RH1M <-as.numeric(dt4$MAX_RH1M)
  if (class(dt4$N_RH1M)=="factor") dt4$N_RH1M <-as.numeric(levels(dt4$N_RH1M))[as.integer(dt4$N_RH1M) ]               
  if (class(dt4$N_RH1M)=="character") dt4$N_RH1M <-as.numeric(dt4$N_RH1M)
  if (class(dt4$AVG_RH3M)=="factor") dt4$AVG_RH3M <-as.numeric(levels(dt4$AVG_RH3M))[as.integer(dt4$AVG_RH3M) ]               
  if (class(dt4$AVG_RH3M)=="character") dt4$AVG_RH3M <-as.numeric(dt4$AVG_RH3M)
  if (class(dt4$STD_RH3M)=="factor") dt4$STD_RH3M <-as.numeric(levels(dt4$STD_RH3M))[as.integer(dt4$STD_RH3M) ]               
  if (class(dt4$STD_RH3M)=="character") dt4$STD_RH3M <-as.numeric(dt4$STD_RH3M)
  if (class(dt4$MAX_RH3M)=="factor") dt4$MAX_RH3M <-as.numeric(levels(dt4$MAX_RH3M))[as.integer(dt4$MAX_RH3M) ]               
  if (class(dt4$MAX_RH3M)=="character") dt4$MAX_RH3M <-as.numeric(dt4$MAX_RH3M)
  if (class(dt4$MIN_RH3M)=="factor") dt4$MIN_RH3M <-as.numeric(levels(dt4$MIN_RH3M))[as.integer(dt4$MIN_RH3M) ]               
  if (class(dt4$MIN_RH3M)=="character") dt4$MIN_RH3M <-as.numeric(dt4$MIN_RH3M)
  if (class(dt4$N_RH3M)=="factor") dt4$N_RH3M <-as.numeric(levels(dt4$N_RH3M))[as.integer(dt4$N_RH3M) ]               
  if (class(dt4$N_RH3M)=="character") dt4$N_RH3M <-as.numeric(dt4$N_RH3M)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH2M)
  summary(STD_RH2M)
  summary(MIN_RH2M)
  summary(MAX_RH2M)
  summary(N_RH2M)
  summary(AVG_RH1M)
  summary(STD_RH1M)
  summary(MIN_RH1M)
  summary(MAX_RH1M)
  summary(N_RH1M)
  summary(AVG_RH3M)
  summary(STD_RH3M)
  summary(MAX_RH3M)
  summary(MIN_RH3M)
  summary(N_RH3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/c184ded20fe2f7104e13247ba0c5bf66" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURFTEMP",     
                   "STD_SURFTEMP",     
                   "MIN_SURFTEMP",     
                   "MAX_SURFTEMP",     
                   "N_SURFTEMP",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURFTEMP)=="factor") dt5$AVG_SURFTEMP <-as.numeric(levels(dt5$AVG_SURFTEMP))[as.integer(dt5$AVG_SURFTEMP) ]               
  if (class(dt5$AVG_SURFTEMP)=="character") dt5$AVG_SURFTEMP <-as.numeric(dt5$AVG_SURFTEMP)
  if (class(dt5$STD_SURFTEMP)=="factor") dt5$STD_SURFTEMP <-as.numeric(levels(dt5$STD_SURFTEMP))[as.integer(dt5$STD_SURFTEMP) ]               
  if (class(dt5$STD_SURFTEMP)=="character") dt5$STD_SURFTEMP <-as.numeric(dt5$STD_SURFTEMP)
  if (class(dt5$MIN_SURFTEMP)=="factor") dt5$MIN_SURFTEMP <-as.numeric(levels(dt5$MIN_SURFTEMP))[as.integer(dt5$MIN_SURFTEMP) ]               
  if (class(dt5$MIN_SURFTEMP)=="character") dt5$MIN_SURFTEMP <-as.numeric(dt5$MIN_SURFTEMP)
  if (class(dt5$MAX_SURFTEMP)=="factor") dt5$MAX_SURFTEMP <-as.numeric(levels(dt5$MAX_SURFTEMP))[as.integer(dt5$MAX_SURFTEMP) ]               
  if (class(dt5$MAX_SURFTEMP)=="character") dt5$MAX_SURFTEMP <-as.numeric(dt5$MAX_SURFTEMP)
  if (class(dt5$N_SURFTEMP)=="factor") dt5$N_SURFTEMP <-as.numeric(levels(dt5$N_SURFTEMP))[as.integer(dt5$N_SURFTEMP) ]               
  if (class(dt5$N_SURFTEMP)=="character") dt5$N_SURFTEMP <-as.numeric(dt5$N_SURFTEMP)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURFTEMP <- ifelse((trimws(as.character(dt5$AVG_SURFTEMP))==trimws("Null")),NA,dt5$AVG_SURFTEMP)               
  suppressWarnings(dt5$AVG_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURFTEMP))
  dt5$STD_SURFTEMP <- ifelse((trimws(as.character(dt5$STD_SURFTEMP))==trimws("Null")),NA,dt5$STD_SURFTEMP)               
  suppressWarnings(dt5$STD_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$STD_SURFTEMP))
  dt5$MIN_SURFTEMP <- ifelse((trimws(as.character(dt5$MIN_SURFTEMP))==trimws("Null")),NA,dt5$MIN_SURFTEMP)               
  suppressWarnings(dt5$MIN_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURFTEMP))
  dt5$MAX_SURFTEMP <- ifelse((trimws(as.character(dt5$MAX_SURFTEMP))==trimws("Null")),NA,dt5$MAX_SURFTEMP)               
  suppressWarnings(dt5$MAX_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURFTEMP))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURFTEMP)
  summary(STD_SURFTEMP)
  summary(MIN_SURFTEMP)
  summary(MAX_SURFTEMP)
  summary(N_SURFTEMP)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/76a061947e8d07d7cd3468e0d1a2051c" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/16564d6120a5469d15fa1f32a4957096" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=42
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICET50CM",     
                   "STDDEV_ICET50CM",     
                   "MIN_ICET50CM",     
                   "MAX_ICET50CM",     
                   "N_ICET50CM",     
                   "AVG_ICET1M",     
                   "STDDEV_ICET1M",     
                   "MIN_ICET1M",     
                   "MAX_ICET1M",     
                   "N_ICET1M",     
                   "AVG_NEWICET_25CM",     
                   "STDDEV_NEWICET_25CM",     
                   "MIN_NEWICET_25CM",     
                   "MAX_NEWICET_25CM",     
                   "N_NEWICET_25CM",     
                   "AVG_NEWICET_50CM",     
                   "STDDEV_NEWICET_50CM",     
                   "MIN_NEWICET_50CM",     
                   "MAX_NEWICET_50CM",     
                   "N_NEWICET_50CM",     
                   "AVG_NEWICET_75CM",     
                   "STDDEV_NEWICET_75CM",     
                   "MIN_NEWICET_75CM",     
                   "MAX_NEWICET_75CM",     
                   "N_NEWICET_75CM",     
                   "AVG_NEWICET_100CM",     
                   "STDDEV_NEWICET_100CM",     
                   "MIN_NEWICET_100CM",     
                   "MAX_NEWICET_100CM",     
                   "N_NEWICET_100CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)
  if (class(dt7$AVG_ICET50CM)=="factor") dt7$AVG_ICET50CM <-as.numeric(levels(dt7$AVG_ICET50CM))[as.integer(dt7$AVG_ICET50CM) ]               
  if (class(dt7$AVG_ICET50CM)=="character") dt7$AVG_ICET50CM <-as.numeric(dt7$AVG_ICET50CM)
  if (class(dt7$STDDEV_ICET50CM)=="factor") dt7$STDDEV_ICET50CM <-as.numeric(levels(dt7$STDDEV_ICET50CM))[as.integer(dt7$STDDEV_ICET50CM) ]               
  if (class(dt7$STDDEV_ICET50CM)=="character") dt7$STDDEV_ICET50CM <-as.numeric(dt7$STDDEV_ICET50CM)
  if (class(dt7$MIN_ICET50CM)=="factor") dt7$MIN_ICET50CM <-as.numeric(levels(dt7$MIN_ICET50CM))[as.integer(dt7$MIN_ICET50CM) ]               
  if (class(dt7$MIN_ICET50CM)=="character") dt7$MIN_ICET50CM <-as.numeric(dt7$MIN_ICET50CM)
  if (class(dt7$MAX_ICET50CM)=="factor") dt7$MAX_ICET50CM <-as.numeric(levels(dt7$MAX_ICET50CM))[as.integer(dt7$MAX_ICET50CM) ]               
  if (class(dt7$MAX_ICET50CM)=="character") dt7$MAX_ICET50CM <-as.numeric(dt7$MAX_ICET50CM)
  if (class(dt7$N_ICET50CM)=="factor") dt7$N_ICET50CM <-as.numeric(levels(dt7$N_ICET50CM))[as.integer(dt7$N_ICET50CM) ]               
  if (class(dt7$N_ICET50CM)=="character") dt7$N_ICET50CM <-as.numeric(dt7$N_ICET50CM)
  if (class(dt7$AVG_ICET1M)=="factor") dt7$AVG_ICET1M <-as.numeric(levels(dt7$AVG_ICET1M))[as.integer(dt7$AVG_ICET1M) ]               
  if (class(dt7$AVG_ICET1M)=="character") dt7$AVG_ICET1M <-as.numeric(dt7$AVG_ICET1M)
  if (class(dt7$STDDEV_ICET1M)=="factor") dt7$STDDEV_ICET1M <-as.numeric(levels(dt7$STDDEV_ICET1M))[as.integer(dt7$STDDEV_ICET1M) ]               
  if (class(dt7$STDDEV_ICET1M)=="character") dt7$STDDEV_ICET1M <-as.numeric(dt7$STDDEV_ICET1M)
  if (class(dt7$MIN_ICET1M)=="factor") dt7$MIN_ICET1M <-as.numeric(levels(dt7$MIN_ICET1M))[as.integer(dt7$MIN_ICET1M) ]               
  if (class(dt7$MIN_ICET1M)=="character") dt7$MIN_ICET1M <-as.numeric(dt7$MIN_ICET1M)
  if (class(dt7$MAX_ICET1M)=="factor") dt7$MAX_ICET1M <-as.numeric(levels(dt7$MAX_ICET1M))[as.integer(dt7$MAX_ICET1M) ]               
  if (class(dt7$MAX_ICET1M)=="character") dt7$MAX_ICET1M <-as.numeric(dt7$MAX_ICET1M)
  if (class(dt7$N_ICET1M)=="factor") dt7$N_ICET1M <-as.numeric(levels(dt7$N_ICET1M))[as.integer(dt7$N_ICET1M) ]               
  if (class(dt7$N_ICET1M)=="character") dt7$N_ICET1M <-as.numeric(dt7$N_ICET1M)
  if (class(dt7$AVG_NEWICET_25CM)=="factor") dt7$AVG_NEWICET_25CM <-as.numeric(levels(dt7$AVG_NEWICET_25CM))[as.integer(dt7$AVG_NEWICET_25CM) ]               
  if (class(dt7$AVG_NEWICET_25CM)=="character") dt7$AVG_NEWICET_25CM <-as.numeric(dt7$AVG_NEWICET_25CM)
  if (class(dt7$STDDEV_NEWICET_25CM)=="factor") dt7$STDDEV_NEWICET_25CM <-as.numeric(levels(dt7$STDDEV_NEWICET_25CM))[as.integer(dt7$STDDEV_NEWICET_25CM) ]               
  if (class(dt7$STDDEV_NEWICET_25CM)=="character") dt7$STDDEV_NEWICET_25CM <-as.numeric(dt7$STDDEV_NEWICET_25CM)
  if (class(dt7$MIN_NEWICET_25CM)=="factor") dt7$MIN_NEWICET_25CM <-as.numeric(levels(dt7$MIN_NEWICET_25CM))[as.integer(dt7$MIN_NEWICET_25CM) ]               
  if (class(dt7$MIN_NEWICET_25CM)=="character") dt7$MIN_NEWICET_25CM <-as.numeric(dt7$MIN_NEWICET_25CM)
  if (class(dt7$MAX_NEWICET_25CM)=="factor") dt7$MAX_NEWICET_25CM <-as.numeric(levels(dt7$MAX_NEWICET_25CM))[as.integer(dt7$MAX_NEWICET_25CM) ]               
  if (class(dt7$MAX_NEWICET_25CM)=="character") dt7$MAX_NEWICET_25CM <-as.numeric(dt7$MAX_NEWICET_25CM)
  if (class(dt7$N_NEWICET_25CM)=="factor") dt7$N_NEWICET_25CM <-as.numeric(levels(dt7$N_NEWICET_25CM))[as.integer(dt7$N_NEWICET_25CM) ]               
  if (class(dt7$N_NEWICET_25CM)=="character") dt7$N_NEWICET_25CM <-as.numeric(dt7$N_NEWICET_25CM)
  if (class(dt7$AVG_NEWICET_50CM)=="factor") dt7$AVG_NEWICET_50CM <-as.numeric(levels(dt7$AVG_NEWICET_50CM))[as.integer(dt7$AVG_NEWICET_50CM) ]               
  if (class(dt7$AVG_NEWICET_50CM)=="character") dt7$AVG_NEWICET_50CM <-as.numeric(dt7$AVG_NEWICET_50CM)
  if (class(dt7$STDDEV_NEWICET_50CM)=="factor") dt7$STDDEV_NEWICET_50CM <-as.numeric(levels(dt7$STDDEV_NEWICET_50CM))[as.integer(dt7$STDDEV_NEWICET_50CM) ]               
  if (class(dt7$STDDEV_NEWICET_50CM)=="character") dt7$STDDEV_NEWICET_50CM <-as.numeric(dt7$STDDEV_NEWICET_50CM)
  if (class(dt7$MIN_NEWICET_50CM)=="factor") dt7$MIN_NEWICET_50CM <-as.numeric(levels(dt7$MIN_NEWICET_50CM))[as.integer(dt7$MIN_NEWICET_50CM) ]               
  if (class(dt7$MIN_NEWICET_50CM)=="character") dt7$MIN_NEWICET_50CM <-as.numeric(dt7$MIN_NEWICET_50CM)
  if (class(dt7$MAX_NEWICET_50CM)=="factor") dt7$MAX_NEWICET_50CM <-as.numeric(levels(dt7$MAX_NEWICET_50CM))[as.integer(dt7$MAX_NEWICET_50CM) ]               
  if (class(dt7$MAX_NEWICET_50CM)=="character") dt7$MAX_NEWICET_50CM <-as.numeric(dt7$MAX_NEWICET_50CM)
  if (class(dt7$N_NEWICET_50CM)=="factor") dt7$N_NEWICET_50CM <-as.numeric(levels(dt7$N_NEWICET_50CM))[as.integer(dt7$N_NEWICET_50CM) ]               
  if (class(dt7$N_NEWICET_50CM)=="character") dt7$N_NEWICET_50CM <-as.numeric(dt7$N_NEWICET_50CM)
  if (class(dt7$AVG_NEWICET_75CM)=="factor") dt7$AVG_NEWICET_75CM <-as.numeric(levels(dt7$AVG_NEWICET_75CM))[as.integer(dt7$AVG_NEWICET_75CM) ]               
  if (class(dt7$AVG_NEWICET_75CM)=="character") dt7$AVG_NEWICET_75CM <-as.numeric(dt7$AVG_NEWICET_75CM)
  if (class(dt7$STDDEV_NEWICET_75CM)=="factor") dt7$STDDEV_NEWICET_75CM <-as.numeric(levels(dt7$STDDEV_NEWICET_75CM))[as.integer(dt7$STDDEV_NEWICET_75CM) ]               
  if (class(dt7$STDDEV_NEWICET_75CM)=="character") dt7$STDDEV_NEWICET_75CM <-as.numeric(dt7$STDDEV_NEWICET_75CM)
  if (class(dt7$MIN_NEWICET_75CM)=="factor") dt7$MIN_NEWICET_75CM <-as.numeric(levels(dt7$MIN_NEWICET_75CM))[as.integer(dt7$MIN_NEWICET_75CM) ]               
  if (class(dt7$MIN_NEWICET_75CM)=="character") dt7$MIN_NEWICET_75CM <-as.numeric(dt7$MIN_NEWICET_75CM)
  if (class(dt7$MAX_NEWICET_75CM)=="factor") dt7$MAX_NEWICET_75CM <-as.numeric(levels(dt7$MAX_NEWICET_75CM))[as.integer(dt7$MAX_NEWICET_75CM) ]               
  if (class(dt7$MAX_NEWICET_75CM)=="character") dt7$MAX_NEWICET_75CM <-as.numeric(dt7$MAX_NEWICET_75CM)
  if (class(dt7$N_NEWICET_75CM)=="factor") dt7$N_NEWICET_75CM <-as.numeric(levels(dt7$N_NEWICET_75CM))[as.integer(dt7$N_NEWICET_75CM) ]               
  if (class(dt7$N_NEWICET_75CM)=="character") dt7$N_NEWICET_75CM <-as.numeric(dt7$N_NEWICET_75CM)
  if (class(dt7$AVG_NEWICET_100CM)=="factor") dt7$AVG_NEWICET_100CM <-as.numeric(levels(dt7$AVG_NEWICET_100CM))[as.integer(dt7$AVG_NEWICET_100CM) ]               
  if (class(dt7$AVG_NEWICET_100CM)=="character") dt7$AVG_NEWICET_100CM <-as.numeric(dt7$AVG_NEWICET_100CM)
  if (class(dt7$STDDEV_NEWICET_100CM)=="factor") dt7$STDDEV_NEWICET_100CM <-as.numeric(levels(dt7$STDDEV_NEWICET_100CM))[as.integer(dt7$STDDEV_NEWICET_100CM) ]               
  if (class(dt7$STDDEV_NEWICET_100CM)=="character") dt7$STDDEV_NEWICET_100CM <-as.numeric(dt7$STDDEV_NEWICET_100CM)
  if (class(dt7$MIN_NEWICET_100CM)=="factor") dt7$MIN_NEWICET_100CM <-as.numeric(levels(dt7$MIN_NEWICET_100CM))[as.integer(dt7$MIN_NEWICET_100CM) ]               
  if (class(dt7$MIN_NEWICET_100CM)=="character") dt7$MIN_NEWICET_100CM <-as.numeric(dt7$MIN_NEWICET_100CM)
  if (class(dt7$MAX_NEWICET_100CM)=="factor") dt7$MAX_NEWICET_100CM <-as.numeric(levels(dt7$MAX_NEWICET_100CM))[as.integer(dt7$MAX_NEWICET_100CM) ]               
  if (class(dt7$MAX_NEWICET_100CM)=="character") dt7$MAX_NEWICET_100CM <-as.numeric(dt7$MAX_NEWICET_100CM)
  if (class(dt7$N_NEWICET_100CM)=="factor") dt7$N_NEWICET_100CM <-as.numeric(levels(dt7$N_NEWICET_100CM))[as.integer(dt7$N_NEWICET_100CM) ]               
  if (class(dt7$N_NEWICET_100CM)=="character") dt7$N_NEWICET_100CM <-as.numeric(dt7$N_NEWICET_100CM)
  if (class(dt7$N_COMMENTS)=="factor") dt7$N_COMMENTS <-as.numeric(levels(dt7$N_COMMENTS))[as.integer(dt7$N_COMMENTS) ]               
  if (class(dt7$N_COMMENTS)=="character") dt7$N_COMMENTS <-as.numeric(dt7$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt7$AVG_ICET50CM <- ifelse((trimws(as.character(dt7$AVG_ICET50CM))==trimws("Null")),NA,dt7$AVG_ICET50CM)               
  suppressWarnings(dt7$AVG_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICET50CM))
  dt7$STDDEV_ICET50CM <- ifelse((trimws(as.character(dt7$STDDEV_ICET50CM))==trimws("Null")),NA,dt7$STDDEV_ICET50CM)               
  suppressWarnings(dt7$STDDEV_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STDDEV_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$STDDEV_ICET50CM))
  dt7$MIN_ICET50CM <- ifelse((trimws(as.character(dt7$MIN_ICET50CM))==trimws("Null")),NA,dt7$MIN_ICET50CM)               
  suppressWarnings(dt7$MIN_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICET50CM))
  dt7$MAX_ICET50CM <- ifelse((trimws(as.character(dt7$MAX_ICET50CM))==trimws("Null")),NA,dt7$MAX_ICET50CM)               
  suppressWarnings(dt7$MAX_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICET50CM))
  dt7$N_ICET50CM <- ifelse((trimws(as.character(dt7$N_ICET50CM))==trimws("Null")),NA,dt7$N_ICET50CM)               
  suppressWarnings(dt7$N_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$N_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$N_ICET50CM))
  dt7$AVG_ICET1M <- ifelse((trimws(as.character(dt7$AVG_ICET1M))==trimws("Null")),NA,dt7$AVG_ICET1M)               
  suppressWarnings(dt7$AVG_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICET1M))
  dt7$MIN_ICET1M <- ifelse((trimws(as.character(dt7$MIN_ICET1M))==trimws("Null")),NA,dt7$MIN_ICET1M)               
  suppressWarnings(dt7$MIN_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICET1M))
  dt7$MAX_ICET1M <- ifelse((trimws(as.character(dt7$MAX_ICET1M))==trimws("Null")),NA,dt7$MAX_ICET1M)               
  suppressWarnings(dt7$MAX_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICET1M))
  dt7$AVG_NEWICET_25CM <- ifelse((trimws(as.character(dt7$AVG_NEWICET_25CM))==trimws("Null")),NA,dt7$AVG_NEWICET_25CM)               
  suppressWarnings(dt7$AVG_NEWICET_25CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_NEWICET_25CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_NEWICET_25CM))
  dt7$STDDEV_NEWICET_25CM <- ifelse((trimws(as.character(dt7$STDDEV_NEWICET_25CM))==trimws("Null")),NA,dt7$STDDEV_NEWICET_25CM)               
  suppressWarnings(dt7$STDDEV_NEWICET_25CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STDDEV_NEWICET_25CM))==as.character(as.numeric("Null"))),NA,dt7$STDDEV_NEWICET_25CM))
  dt7$MIN_NEWICET_25CM <- ifelse((trimws(as.character(dt7$MIN_NEWICET_25CM))==trimws("Null")),NA,dt7$MIN_NEWICET_25CM)               
  suppressWarnings(dt7$MIN_NEWICET_25CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_NEWICET_25CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_NEWICET_25CM))
  dt7$MAX_NEWICET_25CM <- ifelse((trimws(as.character(dt7$MAX_NEWICET_25CM))==trimws("Null")),NA,dt7$MAX_NEWICET_25CM)               
  suppressWarnings(dt7$MAX_NEWICET_25CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_NEWICET_25CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_NEWICET_25CM))
  dt7$AVG_NEWICET_50CM <- ifelse((trimws(as.character(dt7$AVG_NEWICET_50CM))==trimws("Null")),NA,dt7$AVG_NEWICET_50CM)               
  suppressWarnings(dt7$AVG_NEWICET_50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_NEWICET_50CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_NEWICET_50CM))
  dt7$STDDEV_NEWICET_50CM <- ifelse((trimws(as.character(dt7$STDDEV_NEWICET_50CM))==trimws("Null")),NA,dt7$STDDEV_NEWICET_50CM)               
  suppressWarnings(dt7$STDDEV_NEWICET_50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STDDEV_NEWICET_50CM))==as.character(as.numeric("Null"))),NA,dt7$STDDEV_NEWICET_50CM))
  dt7$MIN_NEWICET_50CM <- ifelse((trimws(as.character(dt7$MIN_NEWICET_50CM))==trimws("Null")),NA,dt7$MIN_NEWICET_50CM)               
  suppressWarnings(dt7$MIN_NEWICET_50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_NEWICET_50CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_NEWICET_50CM))
  dt7$MAX_NEWICET_50CM <- ifelse((trimws(as.character(dt7$MAX_NEWICET_50CM))==trimws("Null")),NA,dt7$MAX_NEWICET_50CM)               
  suppressWarnings(dt7$MAX_NEWICET_50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_NEWICET_50CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_NEWICET_50CM))
  dt7$AVG_NEWICET_75CM <- ifelse((trimws(as.character(dt7$AVG_NEWICET_75CM))==trimws("Null")),NA,dt7$AVG_NEWICET_75CM)               
  suppressWarnings(dt7$AVG_NEWICET_75CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_NEWICET_75CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_NEWICET_75CM))
  dt7$STDDEV_NEWICET_75CM <- ifelse((trimws(as.character(dt7$STDDEV_NEWICET_75CM))==trimws("Null")),NA,dt7$STDDEV_NEWICET_75CM)               
  suppressWarnings(dt7$STDDEV_NEWICET_75CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STDDEV_NEWICET_75CM))==as.character(as.numeric("Null"))),NA,dt7$STDDEV_NEWICET_75CM))
  dt7$MIN_NEWICET_75CM <- ifelse((trimws(as.character(dt7$MIN_NEWICET_75CM))==trimws("Null")),NA,dt7$MIN_NEWICET_75CM)               
  suppressWarnings(dt7$MIN_NEWICET_75CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_NEWICET_75CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_NEWICET_75CM))
  dt7$MAX_NEWICET_75CM <- ifelse((trimws(as.character(dt7$MAX_NEWICET_75CM))==trimws("Null")),NA,dt7$MAX_NEWICET_75CM)               
  suppressWarnings(dt7$MAX_NEWICET_75CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_NEWICET_75CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_NEWICET_75CM))
  dt7$AVG_NEWICET_100CM <- ifelse((trimws(as.character(dt7$AVG_NEWICET_100CM))==trimws("Null")),NA,dt7$AVG_NEWICET_100CM)               
  suppressWarnings(dt7$AVG_NEWICET_100CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_NEWICET_100CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_NEWICET_100CM))
  dt7$STDDEV_NEWICET_100CM <- ifelse((trimws(as.character(dt7$STDDEV_NEWICET_100CM))==trimws("Null")),NA,dt7$STDDEV_NEWICET_100CM)               
  suppressWarnings(dt7$STDDEV_NEWICET_100CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STDDEV_NEWICET_100CM))==as.character(as.numeric("Null"))),NA,dt7$STDDEV_NEWICET_100CM))
  dt7$MIN_NEWICET_100CM <- ifelse((trimws(as.character(dt7$MIN_NEWICET_100CM))==trimws("Null")),NA,dt7$MIN_NEWICET_100CM)               
  suppressWarnings(dt7$MIN_NEWICET_100CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_NEWICET_100CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_NEWICET_100CM))
  dt7$MAX_NEWICET_100CM <- ifelse((trimws(as.character(dt7$MAX_NEWICET_100CM))==trimws("Null")),NA,dt7$MAX_NEWICET_100CM)               
  suppressWarnings(dt7$MAX_NEWICET_100CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_NEWICET_100CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_NEWICET_100CM))
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICET50CM)
  summary(STDDEV_ICET50CM)
  summary(MIN_ICET50CM)
  summary(MAX_ICET50CM)
  summary(N_ICET50CM)
  summary(AVG_ICET1M)
  summary(STDDEV_ICET1M)
  summary(MIN_ICET1M)
  summary(MAX_ICET1M)
  summary(N_ICET1M)
  summary(AVG_NEWICET_25CM)
  summary(STDDEV_NEWICET_25CM)
  summary(MIN_NEWICET_25CM)
  summary(MAX_NEWICET_25CM)
  summary(N_NEWICET_25CM)
  summary(AVG_NEWICET_50CM)
  summary(STDDEV_NEWICET_50CM)
  summary(MIN_NEWICET_50CM)
  summary(MAX_NEWICET_50CM)
  summary(N_NEWICET_50CM)
  summary(AVG_NEWICET_75CM)
  summary(STDDEV_NEWICET_75CM)
  summary(MIN_NEWICET_75CM)
  summary(MAX_NEWICET_75CM)
  summary(N_NEWICET_75CM)
  summary(AVG_NEWICET_100CM)
  summary(STDDEV_NEWICET_100CM)
  summary(MIN_NEWICET_100CM)
  summary(MAX_NEWICET_100CM)
  summary(N_NEWICET_100CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID))
  detach(dt7)               
  
  
  inUrl8  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7106/7/6935281fe3628f496a10f0339ceb0638" 
  infile8 <- tempfile()
  try(download.file(inUrl8,infile8,method="curl"))
  if (is.na(file.size(infile8))) download.file(inUrl8,infile8,method="auto")
  
  
  dt8 <-read.csv(infile8,header=F 
                 ,skip=44
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PRESSTA",     
                   "STD_PRESSTA",     
                   "MIN_PRESSTA",     
                   "MAX_PRESSTA",     
                   "N_PRESSTA",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile8)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt8$METLOCID)!="factor") dt8$METLOCID<- as.factor(dt8$METLOCID)
  if (class(dt8$AVG_PRESSTA)=="factor") dt8$AVG_PRESSTA <-as.numeric(levels(dt8$AVG_PRESSTA))[as.integer(dt8$AVG_PRESSTA) ]               
  if (class(dt8$AVG_PRESSTA)=="character") dt8$AVG_PRESSTA <-as.numeric(dt8$AVG_PRESSTA)
  if (class(dt8$STD_PRESSTA)=="factor") dt8$STD_PRESSTA <-as.numeric(levels(dt8$STD_PRESSTA))[as.integer(dt8$STD_PRESSTA) ]               
  if (class(dt8$STD_PRESSTA)=="character") dt8$STD_PRESSTA <-as.numeric(dt8$STD_PRESSTA)
  if (class(dt8$MIN_PRESSTA)=="factor") dt8$MIN_PRESSTA <-as.numeric(levels(dt8$MIN_PRESSTA))[as.integer(dt8$MIN_PRESSTA) ]               
  if (class(dt8$MIN_PRESSTA)=="character") dt8$MIN_PRESSTA <-as.numeric(dt8$MIN_PRESSTA)
  if (class(dt8$MAX_PRESSTA)=="factor") dt8$MAX_PRESSTA <-as.numeric(levels(dt8$MAX_PRESSTA))[as.integer(dt8$MAX_PRESSTA) ]               
  if (class(dt8$MAX_PRESSTA)=="character") dt8$MAX_PRESSTA <-as.numeric(dt8$MAX_PRESSTA)
  if (class(dt8$N_PRESSTA)=="factor") dt8$N_PRESSTA <-as.numeric(levels(dt8$N_PRESSTA))[as.integer(dt8$N_PRESSTA) ]               
  if (class(dt8$N_PRESSTA)=="character") dt8$N_PRESSTA <-as.numeric(dt8$N_PRESSTA)
  if (class(dt8$N_COMMENTS)=="factor") dt8$N_COMMENTS <-as.numeric(levels(dt8$N_COMMENTS))[as.integer(dt8$N_COMMENTS) ]               
  if (class(dt8$N_COMMENTS)=="character") dt8$N_COMMENTS <-as.numeric(dt8$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt8)                            
  attach(dt8)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PRESSTA)
  summary(STD_PRESSTA)
  summary(MIN_PRESSTA)
  summary(MAX_PRESSTA)
  summary(N_PRESSTA)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt8$METLOCID))
  detach(dt8)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  #soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7291/download?token=0SYVlir5l_nyyyOUmVH3JIY-dLwIVo5TUn7wXqhnStc")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil 

if(location == "Commonwealth Glacier"){
  
  pdf('CommonwealthGlaciergraphs.pdf')
  
  # Package ID: knb-lter-mcm.7107.10 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Commonwealth Glacier Meteorological Station (COHM), McMurdo Dry Valleys, Antarctica (1993-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/d24458041bcb701e7719d0e457797d99" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "AVG_AIRT1M",     
                   "STD_AIRT1M",     
                   "MIN_AIRT1M",     
                   "MAX_AIRT1M",     
                   "N_AIRT1M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$AVG_AIRT1M)=="factor") dt1$AVG_AIRT1M <-as.numeric(levels(dt1$AVG_AIRT1M))[as.integer(dt1$AVG_AIRT1M) ]               
  if (class(dt1$AVG_AIRT1M)=="character") dt1$AVG_AIRT1M <-as.numeric(dt1$AVG_AIRT1M)
  if (class(dt1$STD_AIRT1M)=="factor") dt1$STD_AIRT1M <-as.numeric(levels(dt1$STD_AIRT1M))[as.integer(dt1$STD_AIRT1M) ]               
  if (class(dt1$STD_AIRT1M)=="character") dt1$STD_AIRT1M <-as.numeric(dt1$STD_AIRT1M)
  if (class(dt1$MIN_AIRT1M)=="factor") dt1$MIN_AIRT1M <-as.numeric(levels(dt1$MIN_AIRT1M))[as.integer(dt1$MIN_AIRT1M) ]               
  if (class(dt1$MIN_AIRT1M)=="character") dt1$MIN_AIRT1M <-as.numeric(dt1$MIN_AIRT1M)
  if (class(dt1$MAX_AIRT1M)=="factor") dt1$MAX_AIRT1M <-as.numeric(levels(dt1$MAX_AIRT1M))[as.integer(dt1$MAX_AIRT1M) ]               
  if (class(dt1$MAX_AIRT1M)=="character") dt1$MAX_AIRT1M <-as.numeric(dt1$MAX_AIRT1M)
  if (class(dt1$N_AIRT1M)=="factor") dt1$N_AIRT1M <-as.numeric(levels(dt1$N_AIRT1M))[as.integer(dt1$N_AIRT1M) ]               
  if (class(dt1$N_AIRT1M)=="character") dt1$N_AIRT1M <-as.numeric(dt1$N_AIRT1M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$MIN_AIRT1M <- ifelse((trimws(as.character(dt1$MIN_AIRT1M))==trimws("Null")),NA,dt1$MIN_AIRT1M)               
  suppressWarnings(dt1$MIN_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT1M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(AVG_AIRT1M)
  summary(STD_AIRT1M)
  summary(MIN_AIRT1M)
  summary(MAX_AIRT1M)
  summary(N_AIRT1M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/5c5abcd9a8a29c29b3cceca38c5e57c6" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICESURFCHANGE_CM",     
                   "STD_ICESURFCHANGE_CM",     
                   "MIN_ICESURFCHANGE_CM",     
                   "MAX_ICESURFCHANGE_CM",     
                   "N_ICESURFCHANGE_CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_ICESURFCHANGE_CM)=="factor") dt2$AVG_ICESURFCHANGE_CM <-as.numeric(levels(dt2$AVG_ICESURFCHANGE_CM))[as.integer(dt2$AVG_ICESURFCHANGE_CM) ]               
  if (class(dt2$AVG_ICESURFCHANGE_CM)=="character") dt2$AVG_ICESURFCHANGE_CM <-as.numeric(dt2$AVG_ICESURFCHANGE_CM)
  if (class(dt2$STD_ICESURFCHANGE_CM)=="factor") dt2$STD_ICESURFCHANGE_CM <-as.numeric(levels(dt2$STD_ICESURFCHANGE_CM))[as.integer(dt2$STD_ICESURFCHANGE_CM) ]               
  if (class(dt2$STD_ICESURFCHANGE_CM)=="character") dt2$STD_ICESURFCHANGE_CM <-as.numeric(dt2$STD_ICESURFCHANGE_CM)
  if (class(dt2$MIN_ICESURFCHANGE_CM)=="factor") dt2$MIN_ICESURFCHANGE_CM <-as.numeric(levels(dt2$MIN_ICESURFCHANGE_CM))[as.integer(dt2$MIN_ICESURFCHANGE_CM) ]               
  if (class(dt2$MIN_ICESURFCHANGE_CM)=="character") dt2$MIN_ICESURFCHANGE_CM <-as.numeric(dt2$MIN_ICESURFCHANGE_CM)
  if (class(dt2$MAX_ICESURFCHANGE_CM)=="factor") dt2$MAX_ICESURFCHANGE_CM <-as.numeric(levels(dt2$MAX_ICESURFCHANGE_CM))[as.integer(dt2$MAX_ICESURFCHANGE_CM) ]               
  if (class(dt2$MAX_ICESURFCHANGE_CM)=="character") dt2$MAX_ICESURFCHANGE_CM <-as.numeric(dt2$MAX_ICESURFCHANGE_CM)
  if (class(dt2$N_ICESURFCHANGE_CM)=="factor") dt2$N_ICESURFCHANGE_CM <-as.numeric(levels(dt2$N_ICESURFCHANGE_CM))[as.integer(dt2$N_ICESURFCHANGE_CM) ]               
  if (class(dt2$N_ICESURFCHANGE_CM)=="character") dt2$N_ICESURFCHANGE_CM <-as.numeric(dt2$N_ICESURFCHANGE_CM)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$AVG_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$AVG_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$AVG_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$AVG_ICESURFCHANGE_CM))
  dt2$STD_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$STD_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$STD_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$STD_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STD_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$STD_ICESURFCHANGE_CM))
  dt2$MIN_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$MIN_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$MIN_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$MIN_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$MIN_ICESURFCHANGE_CM))
  dt2$MAX_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$MAX_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$MAX_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$MAX_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$MAX_ICESURFCHANGE_CM))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICESURFCHANGE_CM)
  summary(STD_ICESURFCHANGE_CM)
  summary(MIN_ICESURFCHANGE_CM)
  summary(MAX_ICESURFCHANGE_CM)
  summary(N_ICESURFCHANGE_CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/7b0fe85bbfb487430f78147dbdb772c2" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_LWRADIN2",     
                   "STD_LWRADIN2",     
                   "MIN_LWRADIN2",     
                   "MAX_LWRADIN2",     
                   "N_LWRADIN2",     
                   "AVG_LWRADOUT",     
                   "STD_LWRADOUT",     
                   "MIN_LWRADOUT",     
                   "MAX_LWRADOUT",     
                   "N_LWRADOUT",     
                   "AVG_LWRADOUT2",     
                   "STD_LWRADOUT2",     
                   "MAX_LWRADOUT2",     
                   "N_LWRADOUT2",     
                   "AVG_SWRADIN",     
                   "MIN_LWRADOUT2",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "AVG_THMIR",     
                   "STD_THMIR",     
                   "MIN_THMIR",     
                   "MAX_THMIR",     
                   "N_THMIR",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_LWRADIN)=="factor") dt3$AVG_LWRADIN <-as.numeric(levels(dt3$AVG_LWRADIN))[as.integer(dt3$AVG_LWRADIN) ]               
  if (class(dt3$AVG_LWRADIN)=="character") dt3$AVG_LWRADIN <-as.numeric(dt3$AVG_LWRADIN)
  if (class(dt3$STD_LWRADIN)=="factor") dt3$STD_LWRADIN <-as.numeric(levels(dt3$STD_LWRADIN))[as.integer(dt3$STD_LWRADIN) ]               
  if (class(dt3$STD_LWRADIN)=="character") dt3$STD_LWRADIN <-as.numeric(dt3$STD_LWRADIN)
  if (class(dt3$MIN_LWRADIN)=="factor") dt3$MIN_LWRADIN <-as.numeric(levels(dt3$MIN_LWRADIN))[as.integer(dt3$MIN_LWRADIN) ]               
  if (class(dt3$MIN_LWRADIN)=="character") dt3$MIN_LWRADIN <-as.numeric(dt3$MIN_LWRADIN)
  if (class(dt3$MAX_LWRADIN)=="factor") dt3$MAX_LWRADIN <-as.numeric(levels(dt3$MAX_LWRADIN))[as.integer(dt3$MAX_LWRADIN) ]               
  if (class(dt3$MAX_LWRADIN)=="character") dt3$MAX_LWRADIN <-as.numeric(dt3$MAX_LWRADIN)
  if (class(dt3$N_LWRADIN)=="factor") dt3$N_LWRADIN <-as.numeric(levels(dt3$N_LWRADIN))[as.integer(dt3$N_LWRADIN) ]               
  if (class(dt3$N_LWRADIN)=="character") dt3$N_LWRADIN <-as.numeric(dt3$N_LWRADIN)
  if (class(dt3$AVG_LWRADIN2)=="factor") dt3$AVG_LWRADIN2 <-as.numeric(levels(dt3$AVG_LWRADIN2))[as.integer(dt3$AVG_LWRADIN2) ]               
  if (class(dt3$AVG_LWRADIN2)=="character") dt3$AVG_LWRADIN2 <-as.numeric(dt3$AVG_LWRADIN2)
  if (class(dt3$STD_LWRADIN2)=="factor") dt3$STD_LWRADIN2 <-as.numeric(levels(dt3$STD_LWRADIN2))[as.integer(dt3$STD_LWRADIN2) ]               
  if (class(dt3$STD_LWRADIN2)=="character") dt3$STD_LWRADIN2 <-as.numeric(dt3$STD_LWRADIN2)
  if (class(dt3$MIN_LWRADIN2)=="factor") dt3$MIN_LWRADIN2 <-as.numeric(levels(dt3$MIN_LWRADIN2))[as.integer(dt3$MIN_LWRADIN2) ]               
  if (class(dt3$MIN_LWRADIN2)=="character") dt3$MIN_LWRADIN2 <-as.numeric(dt3$MIN_LWRADIN2)
  if (class(dt3$MAX_LWRADIN2)=="factor") dt3$MAX_LWRADIN2 <-as.numeric(levels(dt3$MAX_LWRADIN2))[as.integer(dt3$MAX_LWRADIN2) ]               
  if (class(dt3$MAX_LWRADIN2)=="character") dt3$MAX_LWRADIN2 <-as.numeric(dt3$MAX_LWRADIN2)
  if (class(dt3$N_LWRADIN2)=="factor") dt3$N_LWRADIN2 <-as.numeric(levels(dt3$N_LWRADIN2))[as.integer(dt3$N_LWRADIN2) ]               
  if (class(dt3$N_LWRADIN2)=="character") dt3$N_LWRADIN2 <-as.numeric(dt3$N_LWRADIN2)
  if (class(dt3$AVG_LWRADOUT)=="factor") dt3$AVG_LWRADOUT <-as.numeric(levels(dt3$AVG_LWRADOUT))[as.integer(dt3$AVG_LWRADOUT) ]               
  if (class(dt3$AVG_LWRADOUT)=="character") dt3$AVG_LWRADOUT <-as.numeric(dt3$AVG_LWRADOUT)
  if (class(dt3$STD_LWRADOUT)=="factor") dt3$STD_LWRADOUT <-as.numeric(levels(dt3$STD_LWRADOUT))[as.integer(dt3$STD_LWRADOUT) ]               
  if (class(dt3$STD_LWRADOUT)=="character") dt3$STD_LWRADOUT <-as.numeric(dt3$STD_LWRADOUT)
  if (class(dt3$MIN_LWRADOUT)=="factor") dt3$MIN_LWRADOUT <-as.numeric(levels(dt3$MIN_LWRADOUT))[as.integer(dt3$MIN_LWRADOUT) ]               
  if (class(dt3$MIN_LWRADOUT)=="character") dt3$MIN_LWRADOUT <-as.numeric(dt3$MIN_LWRADOUT)
  if (class(dt3$MAX_LWRADOUT)=="factor") dt3$MAX_LWRADOUT <-as.numeric(levels(dt3$MAX_LWRADOUT))[as.integer(dt3$MAX_LWRADOUT) ]               
  if (class(dt3$MAX_LWRADOUT)=="character") dt3$MAX_LWRADOUT <-as.numeric(dt3$MAX_LWRADOUT)
  if (class(dt3$N_LWRADOUT)=="factor") dt3$N_LWRADOUT <-as.numeric(levels(dt3$N_LWRADOUT))[as.integer(dt3$N_LWRADOUT) ]               
  if (class(dt3$N_LWRADOUT)=="character") dt3$N_LWRADOUT <-as.numeric(dt3$N_LWRADOUT)
  if (class(dt3$AVG_LWRADOUT2)=="factor") dt3$AVG_LWRADOUT2 <-as.numeric(levels(dt3$AVG_LWRADOUT2))[as.integer(dt3$AVG_LWRADOUT2) ]               
  if (class(dt3$AVG_LWRADOUT2)=="character") dt3$AVG_LWRADOUT2 <-as.numeric(dt3$AVG_LWRADOUT2)
  if (class(dt3$STD_LWRADOUT2)=="factor") dt3$STD_LWRADOUT2 <-as.numeric(levels(dt3$STD_LWRADOUT2))[as.integer(dt3$STD_LWRADOUT2) ]               
  if (class(dt3$STD_LWRADOUT2)=="character") dt3$STD_LWRADOUT2 <-as.numeric(dt3$STD_LWRADOUT2)
  if (class(dt3$MAX_LWRADOUT2)=="factor") dt3$MAX_LWRADOUT2 <-as.numeric(levels(dt3$MAX_LWRADOUT2))[as.integer(dt3$MAX_LWRADOUT2) ]               
  if (class(dt3$MAX_LWRADOUT2)=="character") dt3$MAX_LWRADOUT2 <-as.numeric(dt3$MAX_LWRADOUT2)
  if (class(dt3$N_LWRADOUT2)=="factor") dt3$N_LWRADOUT2 <-as.numeric(levels(dt3$N_LWRADOUT2))[as.integer(dt3$N_LWRADOUT2) ]               
  if (class(dt3$N_LWRADOUT2)=="character") dt3$N_LWRADOUT2 <-as.numeric(dt3$N_LWRADOUT2)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$MIN_LWRADOUT2)=="factor") dt3$MIN_LWRADOUT2 <-as.numeric(levels(dt3$MIN_LWRADOUT2))[as.integer(dt3$MIN_LWRADOUT2) ]               
  if (class(dt3$MIN_LWRADOUT2)=="character") dt3$MIN_LWRADOUT2 <-as.numeric(dt3$MIN_LWRADOUT2)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$AVG_THMIR)=="factor") dt3$AVG_THMIR <-as.numeric(levels(dt3$AVG_THMIR))[as.integer(dt3$AVG_THMIR) ]               
  if (class(dt3$AVG_THMIR)=="character") dt3$AVG_THMIR <-as.numeric(dt3$AVG_THMIR)
  if (class(dt3$STD_THMIR)=="factor") dt3$STD_THMIR <-as.numeric(levels(dt3$STD_THMIR))[as.integer(dt3$STD_THMIR) ]               
  if (class(dt3$STD_THMIR)=="character") dt3$STD_THMIR <-as.numeric(dt3$STD_THMIR)
  if (class(dt3$MIN_THMIR)=="factor") dt3$MIN_THMIR <-as.numeric(levels(dt3$MIN_THMIR))[as.integer(dt3$MIN_THMIR) ]               
  if (class(dt3$MIN_THMIR)=="character") dt3$MIN_THMIR <-as.numeric(dt3$MIN_THMIR)
  if (class(dt3$MAX_THMIR)=="factor") dt3$MAX_THMIR <-as.numeric(levels(dt3$MAX_THMIR))[as.integer(dt3$MAX_THMIR) ]               
  if (class(dt3$MAX_THMIR)=="character") dt3$MAX_THMIR <-as.numeric(dt3$MAX_THMIR)
  if (class(dt3$N_THMIR)=="factor") dt3$N_THMIR <-as.numeric(levels(dt3$N_THMIR))[as.integer(dt3$N_THMIR) ]               
  if (class(dt3$N_THMIR)=="character") dt3$N_THMIR <-as.numeric(dt3$N_THMIR)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$STD_LWRADIN <- ifelse((trimws(as.character(dt3$STD_LWRADIN))==trimws("Null")),NA,dt3$STD_LWRADIN)               
  suppressWarnings(dt3$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN))
  dt3$MIN_LWRADIN <- ifelse((trimws(as.character(dt3$MIN_LWRADIN))==trimws("Null")),NA,dt3$MIN_LWRADIN)               
  suppressWarnings(dt3$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN))
  dt3$MAX_LWRADIN <- ifelse((trimws(as.character(dt3$MAX_LWRADIN))==trimws("Null")),NA,dt3$MAX_LWRADIN)               
  suppressWarnings(dt3$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN))
  dt3$STD_LWRADIN2 <- ifelse((trimws(as.character(dt3$STD_LWRADIN2))==trimws("Null")),NA,dt3$STD_LWRADIN2)               
  suppressWarnings(dt3$STD_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN2))
  dt3$MIN_LWRADIN2 <- ifelse((trimws(as.character(dt3$MIN_LWRADIN2))==trimws("Null")),NA,dt3$MIN_LWRADIN2)               
  suppressWarnings(dt3$MIN_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN2))
  dt3$MAX_LWRADIN2 <- ifelse((trimws(as.character(dt3$MAX_LWRADIN2))==trimws("Null")),NA,dt3$MAX_LWRADIN2)               
  suppressWarnings(dt3$MAX_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN2))
  dt3$STD_LWRADOUT <- ifelse((trimws(as.character(dt3$STD_LWRADOUT))==trimws("Null")),NA,dt3$STD_LWRADOUT)               
  suppressWarnings(dt3$STD_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT))
  dt3$MIN_LWRADOUT <- ifelse((trimws(as.character(dt3$MIN_LWRADOUT))==trimws("Null")),NA,dt3$MIN_LWRADOUT)               
  suppressWarnings(dt3$MIN_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADOUT))
  dt3$MAX_LWRADOUT <- ifelse((trimws(as.character(dt3$MAX_LWRADOUT))==trimws("Null")),NA,dt3$MAX_LWRADOUT)               
  suppressWarnings(dt3$MAX_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADOUT))
  dt3$STD_LWRADOUT2 <- ifelse((trimws(as.character(dt3$STD_LWRADOUT2))==trimws("Null")),NA,dt3$STD_LWRADOUT2)               
  suppressWarnings(dt3$STD_LWRADOUT2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT2))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  dt3$AVG_THMIR <- ifelse((trimws(as.character(dt3$AVG_THMIR))==trimws("Null")),NA,dt3$AVG_THMIR)               
  suppressWarnings(dt3$AVG_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_THMIR))==as.character(as.numeric("Null"))),NA,dt3$AVG_THMIR))
  dt3$STD_THMIR <- ifelse((trimws(as.character(dt3$STD_THMIR))==trimws("Null")),NA,dt3$STD_THMIR)               
  suppressWarnings(dt3$STD_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_THMIR))==as.character(as.numeric("Null"))),NA,dt3$STD_THMIR))
  dt3$MIN_THMIR <- ifelse((trimws(as.character(dt3$MIN_THMIR))==trimws("Null")),NA,dt3$MIN_THMIR)               
  suppressWarnings(dt3$MIN_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MIN_THMIR))
  dt3$MAX_THMIR <- ifelse((trimws(as.character(dt3$MAX_THMIR))==trimws("Null")),NA,dt3$MAX_THMIR)               
  suppressWarnings(dt3$MAX_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MAX_THMIR))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_LWRADIN2)
  summary(STD_LWRADIN2)
  summary(MIN_LWRADIN2)
  summary(MAX_LWRADIN2)
  summary(N_LWRADIN2)
  summary(AVG_LWRADOUT)
  summary(STD_LWRADOUT)
  summary(MIN_LWRADOUT)
  summary(MAX_LWRADOUT)
  summary(N_LWRADOUT)
  summary(AVG_LWRADOUT2)
  summary(STD_LWRADOUT2)
  summary(MAX_LWRADOUT2)
  summary(N_LWRADOUT2)
  summary(AVG_SWRADIN)
  summary(MIN_LWRADOUT2)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(AVG_THMIR)
  summary(STD_THMIR)
  summary(MIN_THMIR)
  summary(MAX_THMIR)
  summary(N_THMIR)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/a2d632466801e6bdccb078d53b1b29b9" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/8df21e11a5f66d7f9844b0346b01afb5" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SURFTEMP",     
                   "STD_SURFTEMP",     
                   "MIN_SURFTEMP",     
                   "MAX_SURFTEMP",     
                   "N_SURFTEMP",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)
  if (class(dt5$AVG_SURFTEMP)=="factor") dt5$AVG_SURFTEMP <-as.numeric(levels(dt5$AVG_SURFTEMP))[as.integer(dt5$AVG_SURFTEMP) ]               
  if (class(dt5$AVG_SURFTEMP)=="character") dt5$AVG_SURFTEMP <-as.numeric(dt5$AVG_SURFTEMP)
  if (class(dt5$STD_SURFTEMP)=="factor") dt5$STD_SURFTEMP <-as.numeric(levels(dt5$STD_SURFTEMP))[as.integer(dt5$STD_SURFTEMP) ]               
  if (class(dt5$STD_SURFTEMP)=="character") dt5$STD_SURFTEMP <-as.numeric(dt5$STD_SURFTEMP)
  if (class(dt5$MIN_SURFTEMP)=="factor") dt5$MIN_SURFTEMP <-as.numeric(levels(dt5$MIN_SURFTEMP))[as.integer(dt5$MIN_SURFTEMP) ]               
  if (class(dt5$MIN_SURFTEMP)=="character") dt5$MIN_SURFTEMP <-as.numeric(dt5$MIN_SURFTEMP)
  if (class(dt5$MAX_SURFTEMP)=="factor") dt5$MAX_SURFTEMP <-as.numeric(levels(dt5$MAX_SURFTEMP))[as.integer(dt5$MAX_SURFTEMP) ]               
  if (class(dt5$MAX_SURFTEMP)=="character") dt5$MAX_SURFTEMP <-as.numeric(dt5$MAX_SURFTEMP)
  if (class(dt5$N_SURFTEMP)=="factor") dt5$N_SURFTEMP <-as.numeric(levels(dt5$N_SURFTEMP))[as.integer(dt5$N_SURFTEMP) ]               
  if (class(dt5$N_SURFTEMP)=="character") dt5$N_SURFTEMP <-as.numeric(dt5$N_SURFTEMP)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt5$AVG_SURFTEMP <- ifelse((trimws(as.character(dt5$AVG_SURFTEMP))==trimws("Null")),NA,dt5$AVG_SURFTEMP)               
  suppressWarnings(dt5$AVG_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$AVG_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$AVG_SURFTEMP))
  dt5$STD_SURFTEMP <- ifelse((trimws(as.character(dt5$STD_SURFTEMP))==trimws("Null")),NA,dt5$STD_SURFTEMP)               
  suppressWarnings(dt5$STD_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$STD_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$STD_SURFTEMP))
  dt5$MIN_SURFTEMP <- ifelse((trimws(as.character(dt5$MIN_SURFTEMP))==trimws("Null")),NA,dt5$MIN_SURFTEMP)               
  suppressWarnings(dt5$MIN_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MIN_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$MIN_SURFTEMP))
  dt5$MAX_SURFTEMP <- ifelse((trimws(as.character(dt5$MAX_SURFTEMP))==trimws("Null")),NA,dt5$MAX_SURFTEMP)               
  suppressWarnings(dt5$MAX_SURFTEMP <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt5$MAX_SURFTEMP))==as.character(as.numeric("Null"))),NA,dt5$MAX_SURFTEMP))
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SURFTEMP)
  summary(STD_SURFTEMP)
  summary(MIN_SURFTEMP)
  summary(MAX_SURFTEMP)
  summary(N_SURFTEMP)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/cce30dba2634cdea2e252b652ca89f49" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_WSPD)=="factor") dt6$AVG_WSPD <-as.numeric(levels(dt6$AVG_WSPD))[as.integer(dt6$AVG_WSPD) ]               
  if (class(dt6$AVG_WSPD)=="character") dt6$AVG_WSPD <-as.numeric(dt6$AVG_WSPD)
  if (class(dt6$STDDEV_WSPD)=="factor") dt6$STDDEV_WSPD <-as.numeric(levels(dt6$STDDEV_WSPD))[as.integer(dt6$STDDEV_WSPD) ]               
  if (class(dt6$STDDEV_WSPD)=="character") dt6$STDDEV_WSPD <-as.numeric(dt6$STDDEV_WSPD)
  if (class(dt6$MIN_WSPD)=="factor") dt6$MIN_WSPD <-as.numeric(levels(dt6$MIN_WSPD))[as.integer(dt6$MIN_WSPD) ]               
  if (class(dt6$MIN_WSPD)=="character") dt6$MIN_WSPD <-as.numeric(dt6$MIN_WSPD)
  if (class(dt6$MAX_WSPD)=="factor") dt6$MAX_WSPD <-as.numeric(levels(dt6$MAX_WSPD))[as.integer(dt6$MAX_WSPD) ]               
  if (class(dt6$MAX_WSPD)=="character") dt6$MAX_WSPD <-as.numeric(dt6$MAX_WSPD)
  if (class(dt6$N_WSPD)=="factor") dt6$N_WSPD <-as.numeric(levels(dt6$N_WSPD))[as.integer(dt6$N_WSPD) ]               
  if (class(dt6$N_WSPD)=="character") dt6$N_WSPD <-as.numeric(dt6$N_WSPD)
  if (class(dt6$N_COMMENTS)!="factor") dt6$N_COMMENTS<- as.factor(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID)) 
  summary(as.factor(dt6$N_COMMENTS))
  detach(dt6)               
  
  
  inUrl7  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/40c7ae24316f248712721b5c36895d27" 
  infile7 <- tempfile()
  try(download.file(inUrl7,infile7,method="curl"))
  if (is.na(file.size(infile7))) download.file(inUrl7,infile7,method="auto")
  
  
  dt7 <-read.csv(infile7,header=F 
                 ,skip=44
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICET50CM",     
                   "STD_ICET50CM",     
                   "MIN_ICET50CM",     
                   "MAX_ICET50CM",     
                   "N_ICET50CM",     
                   "AVG_ICET1M",     
                   "STD_ICET1M",     
                   "MIN_ICET1M",     
                   "MAX_ICET1M",     
                   "N_ICET1M",     
                   "AVG_ICET20CM",     
                   "STD_ICET20CM",     
                   "MIN_ICET20CM",     
                   "MAX_ICET20CM",     
                   "N_ICET20CM",     
                   "AVG_ICEELEVATION",     
                   "STD_ICEELEVATION",     
                   "ICET_COMMENTS",     
                   "MIN_ICEELEVATION",     
                   "MAX_ICEELEVATION",     
                   "N_ICEELEVATION"    ), check.names=TRUE)
  
  unlink(infile7)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt7$METLOCID)!="factor") dt7$METLOCID<- as.factor(dt7$METLOCID)                                   
  if (class(dt7$AVG_ICET50CM)=="factor") dt7$AVG_ICET50CM <-as.numeric(levels(dt7$AVG_ICET50CM))[as.integer(dt7$AVG_ICET50CM) ]               
  if (class(dt7$AVG_ICET50CM)=="character") dt7$AVG_ICET50CM <-as.numeric(dt7$AVG_ICET50CM)
  if (class(dt7$STD_ICET50CM)=="factor") dt7$STD_ICET50CM <-as.numeric(levels(dt7$STD_ICET50CM))[as.integer(dt7$STD_ICET50CM) ]               
  if (class(dt7$STD_ICET50CM)=="character") dt7$STD_ICET50CM <-as.numeric(dt7$STD_ICET50CM)
  if (class(dt7$MIN_ICET50CM)=="factor") dt7$MIN_ICET50CM <-as.numeric(levels(dt7$MIN_ICET50CM))[as.integer(dt7$MIN_ICET50CM) ]               
  if (class(dt7$MIN_ICET50CM)=="character") dt7$MIN_ICET50CM <-as.numeric(dt7$MIN_ICET50CM)
  if (class(dt7$MAX_ICET50CM)=="factor") dt7$MAX_ICET50CM <-as.numeric(levels(dt7$MAX_ICET50CM))[as.integer(dt7$MAX_ICET50CM) ]               
  if (class(dt7$MAX_ICET50CM)=="character") dt7$MAX_ICET50CM <-as.numeric(dt7$MAX_ICET50CM)
  if (class(dt7$N_ICET50CM)=="factor") dt7$N_ICET50CM <-as.numeric(levels(dt7$N_ICET50CM))[as.integer(dt7$N_ICET50CM) ]               
  if (class(dt7$N_ICET50CM)=="character") dt7$N_ICET50CM <-as.numeric(dt7$N_ICET50CM)
  if (class(dt7$AVG_ICET1M)=="factor") dt7$AVG_ICET1M <-as.numeric(levels(dt7$AVG_ICET1M))[as.integer(dt7$AVG_ICET1M) ]               
  if (class(dt7$AVG_ICET1M)=="character") dt7$AVG_ICET1M <-as.numeric(dt7$AVG_ICET1M)
  if (class(dt7$STD_ICET1M)=="factor") dt7$STD_ICET1M <-as.numeric(levels(dt7$STD_ICET1M))[as.integer(dt7$STD_ICET1M) ]               
  if (class(dt7$STD_ICET1M)=="character") dt7$STD_ICET1M <-as.numeric(dt7$STD_ICET1M)
  if (class(dt7$MIN_ICET1M)=="factor") dt7$MIN_ICET1M <-as.numeric(levels(dt7$MIN_ICET1M))[as.integer(dt7$MIN_ICET1M) ]               
  if (class(dt7$MIN_ICET1M)=="character") dt7$MIN_ICET1M <-as.numeric(dt7$MIN_ICET1M)
  if (class(dt7$MAX_ICET1M)=="factor") dt7$MAX_ICET1M <-as.numeric(levels(dt7$MAX_ICET1M))[as.integer(dt7$MAX_ICET1M) ]               
  if (class(dt7$MAX_ICET1M)=="character") dt7$MAX_ICET1M <-as.numeric(dt7$MAX_ICET1M)
  if (class(dt7$N_ICET1M)=="factor") dt7$N_ICET1M <-as.numeric(levels(dt7$N_ICET1M))[as.integer(dt7$N_ICET1M) ]               
  if (class(dt7$N_ICET1M)=="character") dt7$N_ICET1M <-as.numeric(dt7$N_ICET1M)
  if (class(dt7$AVG_ICET20CM)=="factor") dt7$AVG_ICET20CM <-as.numeric(levels(dt7$AVG_ICET20CM))[as.integer(dt7$AVG_ICET20CM) ]               
  if (class(dt7$AVG_ICET20CM)=="character") dt7$AVG_ICET20CM <-as.numeric(dt7$AVG_ICET20CM)
  if (class(dt7$STD_ICET20CM)=="factor") dt7$STD_ICET20CM <-as.numeric(levels(dt7$STD_ICET20CM))[as.integer(dt7$STD_ICET20CM) ]               
  if (class(dt7$STD_ICET20CM)=="character") dt7$STD_ICET20CM <-as.numeric(dt7$STD_ICET20CM)
  if (class(dt7$MIN_ICET20CM)=="factor") dt7$MIN_ICET20CM <-as.numeric(levels(dt7$MIN_ICET20CM))[as.integer(dt7$MIN_ICET20CM) ]               
  if (class(dt7$MIN_ICET20CM)=="character") dt7$MIN_ICET20CM <-as.numeric(dt7$MIN_ICET20CM)
  if (class(dt7$MAX_ICET20CM)=="factor") dt7$MAX_ICET20CM <-as.numeric(levels(dt7$MAX_ICET20CM))[as.integer(dt7$MAX_ICET20CM) ]               
  if (class(dt7$MAX_ICET20CM)=="character") dt7$MAX_ICET20CM <-as.numeric(dt7$MAX_ICET20CM)
  if (class(dt7$N_ICET20CM)=="factor") dt7$N_ICET20CM <-as.numeric(levels(dt7$N_ICET20CM))[as.integer(dt7$N_ICET20CM) ]               
  if (class(dt7$N_ICET20CM)=="character") dt7$N_ICET20CM <-as.numeric(dt7$N_ICET20CM)
  if (class(dt7$AVG_ICEELEVATION)=="factor") dt7$AVG_ICEELEVATION <-as.numeric(levels(dt7$AVG_ICEELEVATION))[as.integer(dt7$AVG_ICEELEVATION) ]               
  if (class(dt7$AVG_ICEELEVATION)=="character") dt7$AVG_ICEELEVATION <-as.numeric(dt7$AVG_ICEELEVATION)
  if (class(dt7$STD_ICEELEVATION)=="factor") dt7$STD_ICEELEVATION <-as.numeric(levels(dt7$STD_ICEELEVATION))[as.integer(dt7$STD_ICEELEVATION) ]               
  if (class(dt7$STD_ICEELEVATION)=="character") dt7$STD_ICEELEVATION <-as.numeric(dt7$STD_ICEELEVATION)
  if (class(dt7$ICET_COMMENTS)!="factor") dt7$ICET_COMMENTS<- as.factor(dt7$ICET_COMMENTS)
  if (class(dt7$MIN_ICEELEVATION)=="factor") dt7$MIN_ICEELEVATION <-as.numeric(levels(dt7$MIN_ICEELEVATION))[as.integer(dt7$MIN_ICEELEVATION) ]               
  if (class(dt7$MIN_ICEELEVATION)=="character") dt7$MIN_ICEELEVATION <-as.numeric(dt7$MIN_ICEELEVATION)
  if (class(dt7$MAX_ICEELEVATION)=="factor") dt7$MAX_ICEELEVATION <-as.numeric(levels(dt7$MAX_ICEELEVATION))[as.integer(dt7$MAX_ICEELEVATION) ]               
  if (class(dt7$MAX_ICEELEVATION)=="character") dt7$MAX_ICEELEVATION <-as.numeric(dt7$MAX_ICEELEVATION)
  if (class(dt7$N_ICEELEVATION)=="factor") dt7$N_ICEELEVATION <-as.numeric(levels(dt7$N_ICEELEVATION))[as.integer(dt7$N_ICEELEVATION) ]               
  if (class(dt7$N_ICEELEVATION)=="character") dt7$N_ICEELEVATION <-as.numeric(dt7$N_ICEELEVATION)
  
  # Convert Missing Values to NA for non-dates
  
  dt7$AVG_ICET50CM <- ifelse((trimws(as.character(dt7$AVG_ICET50CM))==trimws("Null")),NA,dt7$AVG_ICET50CM)               
  suppressWarnings(dt7$AVG_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICET50CM))
  dt7$STD_ICET50CM <- ifelse((trimws(as.character(dt7$STD_ICET50CM))==trimws("Null")),NA,dt7$STD_ICET50CM)               
  suppressWarnings(dt7$STD_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STD_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$STD_ICET50CM))
  dt7$MIN_ICET50CM <- ifelse((trimws(as.character(dt7$MIN_ICET50CM))==trimws("Null")),NA,dt7$MIN_ICET50CM)               
  suppressWarnings(dt7$MIN_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICET50CM))
  dt7$MAX_ICET50CM <- ifelse((trimws(as.character(dt7$MAX_ICET50CM))==trimws("Null")),NA,dt7$MAX_ICET50CM)               
  suppressWarnings(dt7$MAX_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICET50CM))
  dt7$N_ICET50CM <- ifelse((trimws(as.character(dt7$N_ICET50CM))==trimws("Null")),NA,dt7$N_ICET50CM)               
  suppressWarnings(dt7$N_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$N_ICET50CM))==as.character(as.numeric("Null"))),NA,dt7$N_ICET50CM))
  dt7$AVG_ICET1M <- ifelse((trimws(as.character(dt7$AVG_ICET1M))==trimws("Null")),NA,dt7$AVG_ICET1M)               
  suppressWarnings(dt7$AVG_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICET1M))
  dt7$MIN_ICET1M <- ifelse((trimws(as.character(dt7$MIN_ICET1M))==trimws("Null")),NA,dt7$MIN_ICET1M)               
  suppressWarnings(dt7$MIN_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICET1M))
  dt7$MAX_ICET1M <- ifelse((trimws(as.character(dt7$MAX_ICET1M))==trimws("Null")),NA,dt7$MAX_ICET1M)               
  suppressWarnings(dt7$MAX_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICET1M))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICET1M))
  dt7$AVG_ICET20CM <- ifelse((trimws(as.character(dt7$AVG_ICET20CM))==trimws("Null")),NA,dt7$AVG_ICET20CM)               
  suppressWarnings(dt7$AVG_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICET20CM))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICET20CM))
  dt7$STD_ICET20CM <- ifelse((trimws(as.character(dt7$STD_ICET20CM))==trimws("Null")),NA,dt7$STD_ICET20CM)               
  suppressWarnings(dt7$STD_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$STD_ICET20CM))==as.character(as.numeric("Null"))),NA,dt7$STD_ICET20CM))
  dt7$MIN_ICET20CM <- ifelse((trimws(as.character(dt7$MIN_ICET20CM))==trimws("Null")),NA,dt7$MIN_ICET20CM)               
  suppressWarnings(dt7$MIN_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICET20CM))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICET20CM))
  dt7$MAX_ICET20CM <- ifelse((trimws(as.character(dt7$MAX_ICET20CM))==trimws("Null")),NA,dt7$MAX_ICET20CM)               
  suppressWarnings(dt7$MAX_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICET20CM))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICET20CM))
  dt7$N_ICET20CM <- ifelse((trimws(as.character(dt7$N_ICET20CM))==trimws("Null")),NA,dt7$N_ICET20CM)               
  suppressWarnings(dt7$N_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$N_ICET20CM))==as.character(as.numeric("Null"))),NA,dt7$N_ICET20CM))
  dt7$AVG_ICEELEVATION <- ifelse((trimws(as.character(dt7$AVG_ICEELEVATION))==trimws("Null")),NA,dt7$AVG_ICEELEVATION)               
  suppressWarnings(dt7$AVG_ICEELEVATION <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$AVG_ICEELEVATION))==as.character(as.numeric("Null"))),NA,dt7$AVG_ICEELEVATION))
  dt7$MIN_ICEELEVATION <- ifelse((trimws(as.character(dt7$MIN_ICEELEVATION))==trimws("Null")),NA,dt7$MIN_ICEELEVATION)               
  suppressWarnings(dt7$MIN_ICEELEVATION <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MIN_ICEELEVATION))==as.character(as.numeric("Null"))),NA,dt7$MIN_ICEELEVATION))
  dt7$MAX_ICEELEVATION <- ifelse((trimws(as.character(dt7$MAX_ICEELEVATION))==trimws("Null")),NA,dt7$MAX_ICEELEVATION)               
  suppressWarnings(dt7$MAX_ICEELEVATION <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt7$MAX_ICEELEVATION))==as.character(as.numeric("Null"))),NA,dt7$MAX_ICEELEVATION))
  
  
  # Here is the structure of the input data frame:
  str(dt7)                            
  attach(dt7)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICET50CM)
  summary(STD_ICET50CM)
  summary(MIN_ICET50CM)
  summary(MAX_ICET50CM)
  summary(N_ICET50CM)
  summary(AVG_ICET1M)
  summary(STD_ICET1M)
  summary(MIN_ICET1M)
  summary(MAX_ICET1M)
  summary(N_ICET1M)
  summary(AVG_ICET20CM)
  summary(STD_ICET20CM)
  summary(MIN_ICET20CM)
  summary(MAX_ICET20CM)
  summary(N_ICET20CM)
  summary(AVG_ICEELEVATION)
  summary(STD_ICEELEVATION)
  summary(ICET_COMMENTS)
  summary(MIN_ICEELEVATION)
  summary(MAX_ICEELEVATION)
  summary(N_ICEELEVATION) 
  # Get more details on character variables
  
  summary(as.factor(dt7$METLOCID)) 
  summary(as.factor(dt7$ICET_COMMENTS))
  detach(dt7)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  #soiltemp <- dt4
  windspeed <- dt6
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7315/download?token=SuhCtobMnGS4GX39RL80QcvxLi-OjZpQVVWKbScSYrs")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil

if(location == "Howard Glacier"){
  
  pdf('HowardGlaciergraphs.pdf')
  
  # Package ID: knb-lter-mcm.7112.8 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Howard Glacier Meteorological Station (HODM), McMurdo Dry Valleys, Antarctica (1993-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/8f205e628b0f9c4ab52b007edc61b535" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT1M",     
                   "STD_AIRT1M",     
                   "MIN_AIRT1M",     
                   "MAX_AIRT1M",     
                   "N_AIRT1M",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT1M)=="factor") dt1$AVG_AIRT1M <-as.numeric(levels(dt1$AVG_AIRT1M))[as.integer(dt1$AVG_AIRT1M) ]               
  if (class(dt1$AVG_AIRT1M)=="character") dt1$AVG_AIRT1M <-as.numeric(dt1$AVG_AIRT1M)
  if (class(dt1$STD_AIRT1M)=="factor") dt1$STD_AIRT1M <-as.numeric(levels(dt1$STD_AIRT1M))[as.integer(dt1$STD_AIRT1M) ]               
  if (class(dt1$STD_AIRT1M)=="character") dt1$STD_AIRT1M <-as.numeric(dt1$STD_AIRT1M)
  if (class(dt1$MIN_AIRT1M)=="factor") dt1$MIN_AIRT1M <-as.numeric(levels(dt1$MIN_AIRT1M))[as.integer(dt1$MIN_AIRT1M) ]               
  if (class(dt1$MIN_AIRT1M)=="character") dt1$MIN_AIRT1M <-as.numeric(dt1$MIN_AIRT1M)
  if (class(dt1$MAX_AIRT1M)=="factor") dt1$MAX_AIRT1M <-as.numeric(levels(dt1$MAX_AIRT1M))[as.integer(dt1$MAX_AIRT1M) ]               
  if (class(dt1$MAX_AIRT1M)=="character") dt1$MAX_AIRT1M <-as.numeric(dt1$MAX_AIRT1M)
  if (class(dt1$N_AIRT1M)=="factor") dt1$N_AIRT1M <-as.numeric(levels(dt1$N_AIRT1M))[as.integer(dt1$N_AIRT1M) ]               
  if (class(dt1$N_AIRT1M)=="character") dt1$N_AIRT1M <-as.numeric(dt1$N_AIRT1M)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT1M <- ifelse((trimws(as.character(dt1$AVG_AIRT1M))==trimws("Null")),NA,dt1$AVG_AIRT1M)               
  suppressWarnings(dt1$AVG_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT1M))
  dt1$STD_AIRT1M <- ifelse((trimws(as.character(dt1$STD_AIRT1M))==trimws("Null")),NA,dt1$STD_AIRT1M)               
  suppressWarnings(dt1$STD_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT1M))
  dt1$MIN_AIRT1M <- ifelse((trimws(as.character(dt1$MIN_AIRT1M))==trimws("Null")),NA,dt1$MIN_AIRT1M)               
  suppressWarnings(dt1$MIN_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT1M))
  dt1$MAX_AIRT1M <- ifelse((trimws(as.character(dt1$MAX_AIRT1M))==trimws("Null")),NA,dt1$MAX_AIRT1M)               
  suppressWarnings(dt1$MAX_AIRT1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT1M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT1M))
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  dt1$N_COMMENTS <- ifelse((trimws(as.character(dt1$N_COMMENTS))==trimws("Null")),NA,dt1$N_COMMENTS)               
  suppressWarnings(dt1$N_COMMENTS <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$N_COMMENTS))==as.character(as.numeric("Null"))),NA,dt1$N_COMMENTS))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT1M)
  summary(STD_AIRT1M)
  summary(MIN_AIRT1M)
  summary(MAX_AIRT1M)
  summary(N_AIRT1M)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/94906991d95d2566b0af25bcd117d4bf" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICESURFCHANGE_CM",     
                   "STDDEV_ICESURFCHANGE_CM",     
                   "MIN_ICESURFCHANGE_CM",     
                   "MAX_ICESURFCHANGE_CM",     
                   "N_ICESURFCHANGE_CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_ICESURFCHANGE_CM)=="factor") dt2$AVG_ICESURFCHANGE_CM <-as.numeric(levels(dt2$AVG_ICESURFCHANGE_CM))[as.integer(dt2$AVG_ICESURFCHANGE_CM) ]               
  if (class(dt2$AVG_ICESURFCHANGE_CM)=="character") dt2$AVG_ICESURFCHANGE_CM <-as.numeric(dt2$AVG_ICESURFCHANGE_CM)
  if (class(dt2$STDDEV_ICESURFCHANGE_CM)=="factor") dt2$STDDEV_ICESURFCHANGE_CM <-as.numeric(levels(dt2$STDDEV_ICESURFCHANGE_CM))[as.integer(dt2$STDDEV_ICESURFCHANGE_CM) ]               
  if (class(dt2$STDDEV_ICESURFCHANGE_CM)=="character") dt2$STDDEV_ICESURFCHANGE_CM <-as.numeric(dt2$STDDEV_ICESURFCHANGE_CM)
  if (class(dt2$MIN_ICESURFCHANGE_CM)=="factor") dt2$MIN_ICESURFCHANGE_CM <-as.numeric(levels(dt2$MIN_ICESURFCHANGE_CM))[as.integer(dt2$MIN_ICESURFCHANGE_CM) ]               
  if (class(dt2$MIN_ICESURFCHANGE_CM)=="character") dt2$MIN_ICESURFCHANGE_CM <-as.numeric(dt2$MIN_ICESURFCHANGE_CM)
  if (class(dt2$MAX_ICESURFCHANGE_CM)=="factor") dt2$MAX_ICESURFCHANGE_CM <-as.numeric(levels(dt2$MAX_ICESURFCHANGE_CM))[as.integer(dt2$MAX_ICESURFCHANGE_CM) ]               
  if (class(dt2$MAX_ICESURFCHANGE_CM)=="character") dt2$MAX_ICESURFCHANGE_CM <-as.numeric(dt2$MAX_ICESURFCHANGE_CM)
  if (class(dt2$N_ICESURFCHANGE_CM)=="factor") dt2$N_ICESURFCHANGE_CM <-as.numeric(levels(dt2$N_ICESURFCHANGE_CM))[as.integer(dt2$N_ICESURFCHANGE_CM) ]               
  if (class(dt2$N_ICESURFCHANGE_CM)=="character") dt2$N_ICESURFCHANGE_CM <-as.numeric(dt2$N_ICESURFCHANGE_CM)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$AVG_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$AVG_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$AVG_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$AVG_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$AVG_ICESURFCHANGE_CM))
  dt2$STDDEV_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$STDDEV_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$STDDEV_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$STDDEV_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$STDDEV_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$STDDEV_ICESURFCHANGE_CM))
  dt2$MIN_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$MIN_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$MIN_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$MIN_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MIN_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$MIN_ICESURFCHANGE_CM))
  dt2$MAX_ICESURFCHANGE_CM <- ifelse((trimws(as.character(dt2$MAX_ICESURFCHANGE_CM))==trimws("Null")),NA,dt2$MAX_ICESURFCHANGE_CM)               
  suppressWarnings(dt2$MAX_ICESURFCHANGE_CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt2$MAX_ICESURFCHANGE_CM))==as.character(as.numeric("Null"))),NA,dt2$MAX_ICESURFCHANGE_CM))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICESURFCHANGE_CM)
  summary(STDDEV_ICESURFCHANGE_CM)
  summary(MIN_ICESURFCHANGE_CM)
  summary(MAX_ICESURFCHANGE_CM)
  summary(N_ICESURFCHANGE_CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/e94a7c57aca8d93b95453074bd403bb0" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_LWRADIN)=="factor") dt3$AVG_LWRADIN <-as.numeric(levels(dt3$AVG_LWRADIN))[as.integer(dt3$AVG_LWRADIN) ]               
  if (class(dt3$AVG_LWRADIN)=="character") dt3$AVG_LWRADIN <-as.numeric(dt3$AVG_LWRADIN)
  if (class(dt3$STD_LWRADIN)=="factor") dt3$STD_LWRADIN <-as.numeric(levels(dt3$STD_LWRADIN))[as.integer(dt3$STD_LWRADIN) ]               
  if (class(dt3$STD_LWRADIN)=="character") dt3$STD_LWRADIN <-as.numeric(dt3$STD_LWRADIN)
  if (class(dt3$MIN_LWRADIN)=="factor") dt3$MIN_LWRADIN <-as.numeric(levels(dt3$MIN_LWRADIN))[as.integer(dt3$MIN_LWRADIN) ]               
  if (class(dt3$MIN_LWRADIN)=="character") dt3$MIN_LWRADIN <-as.numeric(dt3$MIN_LWRADIN)
  if (class(dt3$MAX_LWRADIN)=="factor") dt3$MAX_LWRADIN <-as.numeric(levels(dt3$MAX_LWRADIN))[as.integer(dt3$MAX_LWRADIN) ]               
  if (class(dt3$MAX_LWRADIN)=="character") dt3$MAX_LWRADIN <-as.numeric(dt3$MAX_LWRADIN)
  if (class(dt3$N_LWRADIN)=="factor") dt3$N_LWRADIN <-as.numeric(levels(dt3$N_LWRADIN))[as.integer(dt3$N_LWRADIN) ]               
  if (class(dt3$N_LWRADIN)=="character") dt3$N_LWRADIN <-as.numeric(dt3$N_LWRADIN)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_LWRADIN <- ifelse((trimws(as.character(dt3$AVG_LWRADIN))==trimws("Null")),NA,dt3$AVG_LWRADIN)               
  suppressWarnings(dt3$AVG_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_LWRADIN))
  dt3$STD_LWRADIN <- ifelse((trimws(as.character(dt3$STD_LWRADIN))==trimws("Null")),NA,dt3$STD_LWRADIN)               
  suppressWarnings(dt3$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN))
  dt3$MIN_LWRADIN <- ifelse((trimws(as.character(dt3$MIN_LWRADIN))==trimws("Null")),NA,dt3$MIN_LWRADIN)               
  suppressWarnings(dt3$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN))
  dt3$MAX_LWRADIN <- ifelse((trimws(as.character(dt3$MAX_LWRADIN))==trimws("Null")),NA,dt3$MAX_LWRADIN)               
  suppressWarnings(dt3$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN))
  dt3$AVG_SWRADIN <- ifelse((trimws(as.character(dt3$AVG_SWRADIN))==trimws("Null")),NA,dt3$AVG_SWRADIN)               
  suppressWarnings(dt3$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADIN))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/aa1378b3cedd07f92dcc433a96714c2d" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "AVG_RH1M",     
                   "STD_RH1M",     
                   "MIN_RH1M",     
                   "MAX_RH1M",     
                   "N_RH1M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$AVG_RH1M)=="factor") dt4$AVG_RH1M <-as.numeric(levels(dt4$AVG_RH1M))[as.integer(dt4$AVG_RH1M) ]               
  if (class(dt4$AVG_RH1M)=="character") dt4$AVG_RH1M <-as.numeric(dt4$AVG_RH1M)
  if (class(dt4$STD_RH1M)=="factor") dt4$STD_RH1M <-as.numeric(levels(dt4$STD_RH1M))[as.integer(dt4$STD_RH1M) ]               
  if (class(dt4$STD_RH1M)=="character") dt4$STD_RH1M <-as.numeric(dt4$STD_RH1M)
  if (class(dt4$MIN_RH1M)=="factor") dt4$MIN_RH1M <-as.numeric(levels(dt4$MIN_RH1M))[as.integer(dt4$MIN_RH1M) ]               
  if (class(dt4$MIN_RH1M)=="character") dt4$MIN_RH1M <-as.numeric(dt4$MIN_RH1M)
  if (class(dt4$MAX_RH1M)=="factor") dt4$MAX_RH1M <-as.numeric(levels(dt4$MAX_RH1M))[as.integer(dt4$MAX_RH1M) ]               
  if (class(dt4$MAX_RH1M)=="character") dt4$MAX_RH1M <-as.numeric(dt4$MAX_RH1M)
  if (class(dt4$N_RH1M)=="factor") dt4$N_RH1M <-as.numeric(levels(dt4$N_RH1M))[as.integer(dt4$N_RH1M) ]               
  if (class(dt4$N_RH1M)=="character") dt4$N_RH1M <-as.numeric(dt4$N_RH1M)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(AVG_RH1M)
  summary(STD_RH1M)
  summary(MIN_RH1M)
  summary(MAX_RH1M)
  summary(N_RH1M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/2383077736d93f076cdad53bd19d697f" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)                                   
  if (class(dt5$AVG_WSPD)=="factor") dt5$AVG_WSPD <-as.numeric(levels(dt5$AVG_WSPD))[as.integer(dt5$AVG_WSPD) ]               
  if (class(dt5$AVG_WSPD)=="character") dt5$AVG_WSPD <-as.numeric(dt5$AVG_WSPD)
  if (class(dt5$STDDEV_WSPD)=="factor") dt5$STDDEV_WSPD <-as.numeric(levels(dt5$STDDEV_WSPD))[as.integer(dt5$STDDEV_WSPD) ]               
  if (class(dt5$STDDEV_WSPD)=="character") dt5$STDDEV_WSPD <-as.numeric(dt5$STDDEV_WSPD)
  if (class(dt5$MIN_WSPD)=="factor") dt5$MIN_WSPD <-as.numeric(levels(dt5$MIN_WSPD))[as.integer(dt5$MIN_WSPD) ]               
  if (class(dt5$MIN_WSPD)=="character") dt5$MIN_WSPD <-as.numeric(dt5$MIN_WSPD)
  if (class(dt5$MAX_WSPD)=="factor") dt5$MAX_WSPD <-as.numeric(levels(dt5$MAX_WSPD))[as.integer(dt5$MAX_WSPD) ]               
  if (class(dt5$MAX_WSPD)=="character") dt5$MAX_WSPD <-as.numeric(dt5$MAX_WSPD)
  if (class(dt5$N_WSPD)=="factor") dt5$N_WSPD <-as.numeric(levels(dt5$N_WSPD))[as.integer(dt5$N_WSPD) ]               
  if (class(dt5$N_WSPD)=="character") dt5$N_WSPD <-as.numeric(dt5$N_WSPD)
  if (class(dt5$N_COMMENTS)=="factor") dt5$N_COMMENTS <-as.numeric(levels(dt5$N_COMMENTS))[as.integer(dt5$N_COMMENTS) ]               
  if (class(dt5$N_COMMENTS)=="character") dt5$N_COMMENTS <-as.numeric(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID))
  detach(dt5)               
  
  
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7112/8/93ded4eb765cd3cf5047be5d4c1815db" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=42
                 ,sep=","  
                 ,quot='"' 
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_ICET20CM",     
                   "STD_ICET20CM",     
                   "MIN_ICET20CM",     
                   "MAX_ICET20CM",     
                   "N_ICET20CM",     
                   "AVG_ICET1M",     
                   "STD_ICET1M",     
                   "MIN_ICET1M",     
                   "MAX_ICET1M",     
                   "N_ICET1M",     
                   "AVG_ICET50CM",     
                   "STD_ICET50CM",     
                   "MIN_ICET50CM",     
                   "MAX_ICET50CM",     
                   "N_ICET50CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)                                   
  if (class(dt6$AVG_ICET20CM)=="factor") dt6$AVG_ICET20CM <-as.numeric(levels(dt6$AVG_ICET20CM))[as.integer(dt6$AVG_ICET20CM) ]               
  if (class(dt6$AVG_ICET20CM)=="character") dt6$AVG_ICET20CM <-as.numeric(dt6$AVG_ICET20CM)
  if (class(dt6$STD_ICET20CM)=="factor") dt6$STD_ICET20CM <-as.numeric(levels(dt6$STD_ICET20CM))[as.integer(dt6$STD_ICET20CM) ]               
  if (class(dt6$STD_ICET20CM)=="character") dt6$STD_ICET20CM <-as.numeric(dt6$STD_ICET20CM)
  if (class(dt6$MIN_ICET20CM)=="factor") dt6$MIN_ICET20CM <-as.numeric(levels(dt6$MIN_ICET20CM))[as.integer(dt6$MIN_ICET20CM) ]               
  if (class(dt6$MIN_ICET20CM)=="character") dt6$MIN_ICET20CM <-as.numeric(dt6$MIN_ICET20CM)
  if (class(dt6$MAX_ICET20CM)=="factor") dt6$MAX_ICET20CM <-as.numeric(levels(dt6$MAX_ICET20CM))[as.integer(dt6$MAX_ICET20CM) ]               
  if (class(dt6$MAX_ICET20CM)=="character") dt6$MAX_ICET20CM <-as.numeric(dt6$MAX_ICET20CM)
  if (class(dt6$N_ICET20CM)=="factor") dt6$N_ICET20CM <-as.numeric(levels(dt6$N_ICET20CM))[as.integer(dt6$N_ICET20CM) ]               
  if (class(dt6$N_ICET20CM)=="character") dt6$N_ICET20CM <-as.numeric(dt6$N_ICET20CM)
  if (class(dt6$AVG_ICET1M)=="factor") dt6$AVG_ICET1M <-as.numeric(levels(dt6$AVG_ICET1M))[as.integer(dt6$AVG_ICET1M) ]               
  if (class(dt6$AVG_ICET1M)=="character") dt6$AVG_ICET1M <-as.numeric(dt6$AVG_ICET1M)
  if (class(dt6$STD_ICET1M)=="factor") dt6$STD_ICET1M <-as.numeric(levels(dt6$STD_ICET1M))[as.integer(dt6$STD_ICET1M) ]               
  if (class(dt6$STD_ICET1M)=="character") dt6$STD_ICET1M <-as.numeric(dt6$STD_ICET1M)
  if (class(dt6$MIN_ICET1M)=="factor") dt6$MIN_ICET1M <-as.numeric(levels(dt6$MIN_ICET1M))[as.integer(dt6$MIN_ICET1M) ]               
  if (class(dt6$MIN_ICET1M)=="character") dt6$MIN_ICET1M <-as.numeric(dt6$MIN_ICET1M)
  if (class(dt6$MAX_ICET1M)=="factor") dt6$MAX_ICET1M <-as.numeric(levels(dt6$MAX_ICET1M))[as.integer(dt6$MAX_ICET1M) ]               
  if (class(dt6$MAX_ICET1M)=="character") dt6$MAX_ICET1M <-as.numeric(dt6$MAX_ICET1M)
  if (class(dt6$N_ICET1M)=="factor") dt6$N_ICET1M <-as.numeric(levels(dt6$N_ICET1M))[as.integer(dt6$N_ICET1M) ]               
  if (class(dt6$N_ICET1M)=="character") dt6$N_ICET1M <-as.numeric(dt6$N_ICET1M)
  if (class(dt6$AVG_ICET50CM)=="factor") dt6$AVG_ICET50CM <-as.numeric(levels(dt6$AVG_ICET50CM))[as.integer(dt6$AVG_ICET50CM) ]               
  if (class(dt6$AVG_ICET50CM)=="character") dt6$AVG_ICET50CM <-as.numeric(dt6$AVG_ICET50CM)
  if (class(dt6$STD_ICET50CM)=="factor") dt6$STD_ICET50CM <-as.numeric(levels(dt6$STD_ICET50CM))[as.integer(dt6$STD_ICET50CM) ]               
  if (class(dt6$STD_ICET50CM)=="character") dt6$STD_ICET50CM <-as.numeric(dt6$STD_ICET50CM)
  if (class(dt6$MIN_ICET50CM)=="factor") dt6$MIN_ICET50CM <-as.numeric(levels(dt6$MIN_ICET50CM))[as.integer(dt6$MIN_ICET50CM) ]               
  if (class(dt6$MIN_ICET50CM)=="character") dt6$MIN_ICET50CM <-as.numeric(dt6$MIN_ICET50CM)
  if (class(dt6$MAX_ICET50CM)=="factor") dt6$MAX_ICET50CM <-as.numeric(levels(dt6$MAX_ICET50CM))[as.integer(dt6$MAX_ICET50CM) ]               
  if (class(dt6$MAX_ICET50CM)=="character") dt6$MAX_ICET50CM <-as.numeric(dt6$MAX_ICET50CM)
  if (class(dt6$N_ICET50CM)=="factor") dt6$N_ICET50CM <-as.numeric(levels(dt6$N_ICET50CM))[as.integer(dt6$N_ICET50CM) ]               
  if (class(dt6$N_ICET50CM)=="character") dt6$N_ICET50CM <-as.numeric(dt6$N_ICET50CM)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt6$AVG_ICET20CM <- ifelse((trimws(as.character(dt6$AVG_ICET20CM))==trimws("Null")),NA,dt6$AVG_ICET20CM)               
  suppressWarnings(dt6$AVG_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_ICET20CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_ICET20CM))
  dt6$STD_ICET20CM <- ifelse((trimws(as.character(dt6$STD_ICET20CM))==trimws("Null")),NA,dt6$STD_ICET20CM)               
  suppressWarnings(dt6$STD_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_ICET20CM))==as.character(as.numeric("Null"))),NA,dt6$STD_ICET20CM))
  dt6$MIN_ICET20CM <- ifelse((trimws(as.character(dt6$MIN_ICET20CM))==trimws("Null")),NA,dt6$MIN_ICET20CM)               
  suppressWarnings(dt6$MIN_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_ICET20CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_ICET20CM))
  dt6$MAX_ICET20CM <- ifelse((trimws(as.character(dt6$MAX_ICET20CM))==trimws("Null")),NA,dt6$MAX_ICET20CM)               
  suppressWarnings(dt6$MAX_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_ICET20CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_ICET20CM))
  dt6$N_ICET20CM <- ifelse((trimws(as.character(dt6$N_ICET20CM))==trimws("Null")),NA,dt6$N_ICET20CM)               
  suppressWarnings(dt6$N_ICET20CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$N_ICET20CM))==as.character(as.numeric("Null"))),NA,dt6$N_ICET20CM))
  dt6$AVG_ICET1M <- ifelse((trimws(as.character(dt6$AVG_ICET1M))==trimws("Null")),NA,dt6$AVG_ICET1M)               
  suppressWarnings(dt6$AVG_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_ICET1M))==as.character(as.numeric("Null"))),NA,dt6$AVG_ICET1M))
  dt6$MIN_ICET1M <- ifelse((trimws(as.character(dt6$MIN_ICET1M))==trimws("Null")),NA,dt6$MIN_ICET1M)               
  suppressWarnings(dt6$MIN_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_ICET1M))==as.character(as.numeric("Null"))),NA,dt6$MIN_ICET1M))
  dt6$MAX_ICET1M <- ifelse((trimws(as.character(dt6$MAX_ICET1M))==trimws("Null")),NA,dt6$MAX_ICET1M)               
  suppressWarnings(dt6$MAX_ICET1M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_ICET1M))==as.character(as.numeric("Null"))),NA,dt6$MAX_ICET1M))
  dt6$AVG_ICET50CM <- ifelse((trimws(as.character(dt6$AVG_ICET50CM))==trimws("Null")),NA,dt6$AVG_ICET50CM)               
  suppressWarnings(dt6$AVG_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_ICET50CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_ICET50CM))
  dt6$STD_ICET50CM <- ifelse((trimws(as.character(dt6$STD_ICET50CM))==trimws("Null")),NA,dt6$STD_ICET50CM)               
  suppressWarnings(dt6$STD_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_ICET50CM))==as.character(as.numeric("Null"))),NA,dt6$STD_ICET50CM))
  dt6$MIN_ICET50CM <- ifelse((trimws(as.character(dt6$MIN_ICET50CM))==trimws("Null")),NA,dt6$MIN_ICET50CM)               
  suppressWarnings(dt6$MIN_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_ICET50CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_ICET50CM))
  dt6$MAX_ICET50CM <- ifelse((trimws(as.character(dt6$MAX_ICET50CM))==trimws("Null")),NA,dt6$MAX_ICET50CM)               
  suppressWarnings(dt6$MAX_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_ICET50CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_ICET50CM))
  dt6$N_ICET50CM <- ifelse((trimws(as.character(dt6$N_ICET50CM))==trimws("Null")),NA,dt6$N_ICET50CM)               
  suppressWarnings(dt6$N_ICET50CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$N_ICET50CM))==as.character(as.numeric("Null"))),NA,dt6$N_ICET50CM))
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_ICET20CM)
  summary(STD_ICET20CM)
  summary(MIN_ICET20CM)
  summary(MAX_ICET20CM)
  summary(N_ICET20CM)
  summary(AVG_ICET1M)
  summary(STD_ICET1M)
  summary(MIN_ICET1M)
  summary(MAX_ICET1M)
  summary(N_ICET1M)
  summary(AVG_ICET50CM)
  summary(STD_ICET50CM)
  summary(MIN_ICET50CM)
  summary(MAX_ICET50CM)
  summary(N_ICET50CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)               
  
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  #soiltemp <- dt4
  windspeed <- dt5
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7364/download?token=7UXRkbaQ0bxJ_92lRG8TlgsQfSmu9PH4FPxrMBU0UQI")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

#No soil temperature

if(location == "Friis Hills"){
  
  pdf('FriisHillsgraphs.pdf')
  
  # Package ID: knb-lter-mcm.7117.9 Cataloging System:https://pasta.edirepository.org.
  # Data set title: Daily measurement summaries from Friis Hills Meteorological Station (FRSM), McMurdo Dry Valleys, Antarctica (2010-2022, ongoing).
  # Data set creator:  Peter Doran -  
  # Data set creator:  Andrew Fountain -  
  # Metadata Provider:    - McMurdo Dry Valleys LTER 
  # Contact:  McMurdo Dry Valleys LTER Information Manager -    - im@mcmlter.org
  # Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7117/9/5137b831ae83cb2ea471298aa1dd7169" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl"))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  
  dt1 <-read.csv(infile1,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_AIRT3M",     
                   "STD_AIRT3M",     
                   "MIN_AIRT3M",     
                   "MAX_AIRT3M",     
                   "N_AIRT3M",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt1$METLOCID)!="factor") dt1$METLOCID<- as.factor(dt1$METLOCID)
  if (class(dt1$AVG_AIRT3M)=="factor") dt1$AVG_AIRT3M <-as.numeric(levels(dt1$AVG_AIRT3M))[as.integer(dt1$AVG_AIRT3M) ]               
  if (class(dt1$AVG_AIRT3M)=="character") dt1$AVG_AIRT3M <-as.numeric(dt1$AVG_AIRT3M)
  if (class(dt1$STD_AIRT3M)=="factor") dt1$STD_AIRT3M <-as.numeric(levels(dt1$STD_AIRT3M))[as.integer(dt1$STD_AIRT3M) ]               
  if (class(dt1$STD_AIRT3M)=="character") dt1$STD_AIRT3M <-as.numeric(dt1$STD_AIRT3M)
  if (class(dt1$MIN_AIRT3M)=="factor") dt1$MIN_AIRT3M <-as.numeric(levels(dt1$MIN_AIRT3M))[as.integer(dt1$MIN_AIRT3M) ]               
  if (class(dt1$MIN_AIRT3M)=="character") dt1$MIN_AIRT3M <-as.numeric(dt1$MIN_AIRT3M)
  if (class(dt1$MAX_AIRT3M)=="factor") dt1$MAX_AIRT3M <-as.numeric(levels(dt1$MAX_AIRT3M))[as.integer(dt1$MAX_AIRT3M) ]               
  if (class(dt1$MAX_AIRT3M)=="character") dt1$MAX_AIRT3M <-as.numeric(dt1$MAX_AIRT3M)
  if (class(dt1$N_AIRT3M)=="factor") dt1$N_AIRT3M <-as.numeric(levels(dt1$N_AIRT3M))[as.integer(dt1$N_AIRT3M) ]               
  if (class(dt1$N_AIRT3M)=="character") dt1$N_AIRT3M <-as.numeric(dt1$N_AIRT3M)
  if (class(dt1$N_COMMENTS)=="factor") dt1$N_COMMENTS <-as.numeric(levels(dt1$N_COMMENTS))[as.integer(dt1$N_COMMENTS) ]               
  if (class(dt1$N_COMMENTS)=="character") dt1$N_COMMENTS <-as.numeric(dt1$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt1$AVG_AIRT3M <- ifelse((trimws(as.character(dt1$AVG_AIRT3M))==trimws("Null")),NA,dt1$AVG_AIRT3M)               
  suppressWarnings(dt1$AVG_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$AVG_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$AVG_AIRT3M))
  dt1$STD_AIRT3M <- ifelse((trimws(as.character(dt1$STD_AIRT3M))==trimws("Null")),NA,dt1$STD_AIRT3M)               
  suppressWarnings(dt1$STD_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$STD_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$STD_AIRT3M))
  dt1$MIN_AIRT3M <- ifelse((trimws(as.character(dt1$MIN_AIRT3M))==trimws("Null")),NA,dt1$MIN_AIRT3M)               
  suppressWarnings(dt1$MIN_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MIN_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MIN_AIRT3M))
  dt1$MAX_AIRT3M <- ifelse((trimws(as.character(dt1$MAX_AIRT3M))==trimws("Null")),NA,dt1$MAX_AIRT3M)               
  suppressWarnings(dt1$MAX_AIRT3M <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt1$MAX_AIRT3M))==as.character(as.numeric("Null"))),NA,dt1$MAX_AIRT3M))
  
  
  # Here is the structure of the input data frame:
  str(dt1)                            
  attach(dt1)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_AIRT3M)
  summary(STD_AIRT3M)
  summary(MIN_AIRT3M)
  summary(MAX_AIRT3M)
  summary(N_AIRT3M)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt1$METLOCID))
  detach(dt1)               
  
  
  inUrl2  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7117/9/932d21766aec7028c3ee0a901ee7bf91" 
  infile2 <- tempfile()
  try(download.file(inUrl2,infile2,method="curl"))
  if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")
  
  
  dt2 <-read.csv(infile2,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PRESSTA",     
                   "STD_PRESSTA",     
                   "MIN_PRESSTA",     
                   "MAX_PRESSTA",     
                   "N_PRESSTA",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile2)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt2$METLOCID)!="factor") dt2$METLOCID<- as.factor(dt2$METLOCID)
  if (class(dt2$AVG_PRESSTA)=="factor") dt2$AVG_PRESSTA <-as.numeric(levels(dt2$AVG_PRESSTA))[as.integer(dt2$AVG_PRESSTA) ]               
  if (class(dt2$AVG_PRESSTA)=="character") dt2$AVG_PRESSTA <-as.numeric(dt2$AVG_PRESSTA)
  if (class(dt2$STD_PRESSTA)=="factor") dt2$STD_PRESSTA <-as.numeric(levels(dt2$STD_PRESSTA))[as.integer(dt2$STD_PRESSTA) ]               
  if (class(dt2$STD_PRESSTA)=="character") dt2$STD_PRESSTA <-as.numeric(dt2$STD_PRESSTA)
  if (class(dt2$MIN_PRESSTA)=="factor") dt2$MIN_PRESSTA <-as.numeric(levels(dt2$MIN_PRESSTA))[as.integer(dt2$MIN_PRESSTA) ]               
  if (class(dt2$MIN_PRESSTA)=="character") dt2$MIN_PRESSTA <-as.numeric(dt2$MIN_PRESSTA)
  if (class(dt2$MAX_PRESSTA)=="factor") dt2$MAX_PRESSTA <-as.numeric(levels(dt2$MAX_PRESSTA))[as.integer(dt2$MAX_PRESSTA) ]               
  if (class(dt2$MAX_PRESSTA)=="character") dt2$MAX_PRESSTA <-as.numeric(dt2$MAX_PRESSTA)
  if (class(dt2$N_PRESSTA)=="factor") dt2$N_PRESSTA <-as.numeric(levels(dt2$N_PRESSTA))[as.integer(dt2$N_PRESSTA) ]               
  if (class(dt2$N_PRESSTA)=="character") dt2$N_PRESSTA <-as.numeric(dt2$N_PRESSTA)
  if (class(dt2$N_COMMENTS)=="factor") dt2$N_COMMENTS <-as.numeric(levels(dt2$N_COMMENTS))[as.integer(dt2$N_COMMENTS) ]               
  if (class(dt2$N_COMMENTS)=="character") dt2$N_COMMENTS <-as.numeric(dt2$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt2$AVG_PRESSTA <- ifelse((trimws(as.character(dt2$AVG_PRESSTA))==trimws("NULL")),NA,dt2$AVG_PRESSTA)               
  suppressWarnings(dt2$AVG_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt2$AVG_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt2$AVG_PRESSTA))
  dt2$STD_PRESSTA <- ifelse((trimws(as.character(dt2$STD_PRESSTA))==trimws("NULL")),NA,dt2$STD_PRESSTA)               
  suppressWarnings(dt2$STD_PRESSTA <- ifelse(!is.na(as.numeric("NULL")) & (trimws(as.character(dt2$STD_PRESSTA))==as.character(as.numeric("NULL"))),NA,dt2$STD_PRESSTA))
  
  
  # Here is the structure of the input data frame:
  str(dt2)                            
  attach(dt2)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PRESSTA)
  summary(STD_PRESSTA)
  summary(MIN_PRESSTA)
  summary(MAX_PRESSTA)
  summary(N_PRESSTA)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt2$METLOCID))
  detach(dt2)               
  
  
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7117/9/7a8af57c843c994ec6fadeebf3794ea8" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_NETRAD",     
                   "STD_NETRAD",     
                   "MIN_NETRAD",     
                   "MAX_NETRAD",     
                   "N_NETRAD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_NETRAD)=="factor") dt3$AVG_NETRAD <-as.numeric(levels(dt3$AVG_NETRAD))[as.integer(dt3$AVG_NETRAD) ]               
  if (class(dt3$AVG_NETRAD)=="character") dt3$AVG_NETRAD <-as.numeric(dt3$AVG_NETRAD)
  if (class(dt3$STD_NETRAD)=="factor") dt3$STD_NETRAD <-as.numeric(levels(dt3$STD_NETRAD))[as.integer(dt3$STD_NETRAD) ]               
  if (class(dt3$STD_NETRAD)=="character") dt3$STD_NETRAD <-as.numeric(dt3$STD_NETRAD)
  if (class(dt3$MIN_NETRAD)=="factor") dt3$MIN_NETRAD <-as.numeric(levels(dt3$MIN_NETRAD))[as.integer(dt3$MIN_NETRAD) ]               
  if (class(dt3$MIN_NETRAD)=="character") dt3$MIN_NETRAD <-as.numeric(dt3$MIN_NETRAD)
  if (class(dt3$MAX_NETRAD)=="factor") dt3$MAX_NETRAD <-as.numeric(levels(dt3$MAX_NETRAD))[as.integer(dt3$MAX_NETRAD) ]               
  if (class(dt3$MAX_NETRAD)=="character") dt3$MAX_NETRAD <-as.numeric(dt3$MAX_NETRAD)
  if (class(dt3$N_NETRAD)=="factor") dt3$N_NETRAD <-as.numeric(levels(dt3$N_NETRAD))[as.integer(dt3$N_NETRAD) ]               
  if (class(dt3$N_NETRAD)=="character") dt3$N_NETRAD <-as.numeric(dt3$N_NETRAD)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_NETRAD <- ifelse((trimws(as.character(dt3$AVG_NETRAD))==trimws("Null")),NA,dt3$AVG_NETRAD)               
  suppressWarnings(dt3$AVG_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$AVG_NETRAD))
  dt3$STD_NETRAD <- ifelse((trimws(as.character(dt3$STD_NETRAD))==trimws("Null")),NA,dt3$STD_NETRAD)               
  suppressWarnings(dt3$STD_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$STD_NETRAD))
  dt3$MIN_NETRAD <- ifelse((trimws(as.character(dt3$MIN_NETRAD))==trimws("Null")),NA,dt3$MIN_NETRAD)               
  suppressWarnings(dt3$MIN_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$MIN_NETRAD))
  dt3$MAX_NETRAD <- ifelse((trimws(as.character(dt3$MAX_NETRAD))==trimws("Null")),NA,dt3$MAX_NETRAD)               
  suppressWarnings(dt3$MAX_NETRAD <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_NETRAD))==as.character(as.numeric("Null"))),NA,dt3$MAX_NETRAD))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_NETRAD)
  summary(STD_NETRAD)
  summary(MIN_NETRAD)
  summary(MAX_NETRAD)
  summary(N_NETRAD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)               
  
  
  inUrl4  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7117/9/3612695fe45eac8faed00621e355dbb0" 
  infile4 <- tempfile()
  try(download.file(inUrl4,infile4,method="curl"))
  if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")
  
  
  dt4 <-read.csv(infile4,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_RH",     
                   "STD_RH",     
                   "MIN_RH",     
                   "MAX_RH",     
                   "N_RH",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile4)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt4$METLOCID)!="factor") dt4$METLOCID<- as.factor(dt4$METLOCID)
  if (class(dt4$AVG_RH)=="factor") dt4$AVG_RH <-as.numeric(levels(dt4$AVG_RH))[as.integer(dt4$AVG_RH) ]               
  if (class(dt4$AVG_RH)=="character") dt4$AVG_RH <-as.numeric(dt4$AVG_RH)
  if (class(dt4$STD_RH)=="factor") dt4$STD_RH <-as.numeric(levels(dt4$STD_RH))[as.integer(dt4$STD_RH) ]               
  if (class(dt4$STD_RH)=="character") dt4$STD_RH <-as.numeric(dt4$STD_RH)
  if (class(dt4$MIN_RH)=="factor") dt4$MIN_RH <-as.numeric(levels(dt4$MIN_RH))[as.integer(dt4$MIN_RH) ]               
  if (class(dt4$MIN_RH)=="character") dt4$MIN_RH <-as.numeric(dt4$MIN_RH)
  if (class(dt4$MAX_RH)=="factor") dt4$MAX_RH <-as.numeric(levels(dt4$MAX_RH))[as.integer(dt4$MAX_RH) ]               
  if (class(dt4$MAX_RH)=="character") dt4$MAX_RH <-as.numeric(dt4$MAX_RH)
  if (class(dt4$N_RH)=="factor") dt4$N_RH <-as.numeric(levels(dt4$N_RH))[as.integer(dt4$N_RH) ]               
  if (class(dt4$N_RH)=="character") dt4$N_RH <-as.numeric(dt4$N_RH)
  if (class(dt4$N_COMMENTS)=="factor") dt4$N_COMMENTS <-as.numeric(levels(dt4$N_COMMENTS))[as.integer(dt4$N_COMMENTS) ]               
  if (class(dt4$N_COMMENTS)=="character") dt4$N_COMMENTS <-as.numeric(dt4$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt4)                            
  attach(dt4)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_RH)
  summary(STD_RH)
  summary(MIN_RH)
  summary(MAX_RH)
  summary(N_RH)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt4$METLOCID))
  detach(dt4)               
  
  
  inUrl5  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7117/9/e8eb1db198ec5a4b26349156129afb10" 
  infile5 <- tempfile()
  try(download.file(inUrl5,infile5,method="curl"))
  if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")
  
  
  dt5 <-read.csv(infile5,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_WSPD",     
                   "STDDEV_WSPD",     
                   "MIN_WSPD",     
                   "MAX_WSPD",     
                   "N_WSPD",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile5)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt5$METLOCID)!="factor") dt5$METLOCID<- as.factor(dt5$METLOCID)                                   
  if (class(dt5$AVG_WSPD)=="factor") dt5$AVG_WSPD <-as.numeric(levels(dt5$AVG_WSPD))[as.integer(dt5$AVG_WSPD) ]               
  if (class(dt5$AVG_WSPD)=="character") dt5$AVG_WSPD <-as.numeric(dt5$AVG_WSPD)
  if (class(dt5$STDDEV_WSPD)=="factor") dt5$STDDEV_WSPD <-as.numeric(levels(dt5$STDDEV_WSPD))[as.integer(dt5$STDDEV_WSPD) ]               
  if (class(dt5$STDDEV_WSPD)=="character") dt5$STDDEV_WSPD <-as.numeric(dt5$STDDEV_WSPD)
  if (class(dt5$MIN_WSPD)=="factor") dt5$MIN_WSPD <-as.numeric(levels(dt5$MIN_WSPD))[as.integer(dt5$MIN_WSPD) ]               
  if (class(dt5$MIN_WSPD)=="character") dt5$MIN_WSPD <-as.numeric(dt5$MIN_WSPD)
  if (class(dt5$MAX_WSPD)=="factor") dt5$MAX_WSPD <-as.numeric(levels(dt5$MAX_WSPD))[as.integer(dt5$MAX_WSPD) ]               
  if (class(dt5$MAX_WSPD)=="character") dt5$MAX_WSPD <-as.numeric(dt5$MAX_WSPD)
  if (class(dt5$N_WSPD)=="factor") dt5$N_WSPD <-as.numeric(levels(dt5$N_WSPD))[as.integer(dt5$N_WSPD) ]               
  if (class(dt5$N_WSPD)=="character") dt5$N_WSPD <-as.numeric(dt5$N_WSPD)
  if (class(dt5$N_COMMENTS)!="factor") dt5$N_COMMENTS<- as.factor(dt5$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  
  
  # Here is the structure of the input data frame:
  str(dt5)                            
  attach(dt5)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_WSPD)
  summary(STDDEV_WSPD)
  summary(MIN_WSPD)
  summary(MAX_WSPD)
  summary(N_WSPD)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt5$METLOCID)) 
  summary(as.factor(dt5$N_COMMENTS))
  detach(dt5) 
  ##Remane Data
  airtemp <- dt1 
  radiation <- dt3
  humidity <- dt4
  #soiltemp <- dt6
  windspeed <- dt5
  
  #loads in wind data
  windall <- read.csv("https://mcm.lternet.edu/file/7210/download?token=DSrFnAaFEgBlLfKTj2QE3XYLG_n4wmb-fx7ziO7tQxM")
  #just date, direction, speed
  wind <- windall[,c(3,4,6)]
}

##No soil temperature locations will use a fake soil temperature set but all graphs/data that has soil data will not be made

##Since most of the data sets don't have long wave data we try to match locations with sites that do have it. All values calculated will be noted

CoGnote <- FALSE
LBnote <- FALSE
HGnote <- FALSE
soiltempcheck <- TRUE

#Lake Bonney LW
if(location == "Lake Vanda" || location == "Lake Vida" ||  location == "Friis Hills" || location == "Mount Fleming" || location == "Miers Valley" || location == "Taylor Glacier"){
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/538210dd8ee15b1fe13512eb8d5e487c" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_PAR",     
                   "STD_PAR",     
                   "MIN_PAR",     
                   "MAX_PAR",     
                   "N_PAR",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_LWRADIN2",     
                   "STD_LWRADIN2",     
                   "MIN_LWRADIN2",     
                   "MAX_LWRADIN2",     
                   "N_LWRADIN2",     
                   "AVG_LWRADOUT",     
                   "STD_LWRADOUT",     
                   "MIN_LWRADOUT",     
                   "MAX_LWRADOUT",     
                   "N_LWRADOUT",     
                   "AVG_LWRADOUT2",     
                   "STD_LWRADOUT2",     
                   "MIN_LWRADOUT2",     
                   "MAX_LWRADOUT2",     
                   "N_LWRADOUT2",     
                   "AVG_SWRADIN",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_PAR)=="factor") dt3$AVG_PAR <-as.numeric(levels(dt3$AVG_PAR))[as.integer(dt3$AVG_PAR) ]               
  if (class(dt3$AVG_PAR)=="character") dt3$AVG_PAR <-as.numeric(dt3$AVG_PAR)
  if (class(dt3$STD_PAR)=="factor") dt3$STD_PAR <-as.numeric(levels(dt3$STD_PAR))[as.integer(dt3$STD_PAR) ]               
  if (class(dt3$STD_PAR)=="character") dt3$STD_PAR <-as.numeric(dt3$STD_PAR)
  if (class(dt3$MIN_PAR)=="factor") dt3$MIN_PAR <-as.numeric(levels(dt3$MIN_PAR))[as.integer(dt3$MIN_PAR) ]               
  if (class(dt3$MIN_PAR)=="character") dt3$MIN_PAR <-as.numeric(dt3$MIN_PAR)
  if (class(dt3$MAX_PAR)=="factor") dt3$MAX_PAR <-as.numeric(levels(dt3$MAX_PAR))[as.integer(dt3$MAX_PAR) ]               
  if (class(dt3$MAX_PAR)=="character") dt3$MAX_PAR <-as.numeric(dt3$MAX_PAR)
  if (class(dt3$N_PAR)=="factor") dt3$N_PAR <-as.numeric(levels(dt3$N_PAR))[as.integer(dt3$N_PAR) ]               
  if (class(dt3$N_PAR)=="character") dt3$N_PAR <-as.numeric(dt3$N_PAR)
  if (class(dt3$AVG_LWRADIN)=="factor") dt3$AVG_LWRADIN <-as.numeric(levels(dt3$AVG_LWRADIN))[as.integer(dt3$AVG_LWRADIN) ]               
  if (class(dt3$AVG_LWRADIN)=="character") dt3$AVG_LWRADIN <-as.numeric(dt3$AVG_LWRADIN)
  if (class(dt3$STD_LWRADIN)=="factor") dt3$STD_LWRADIN <-as.numeric(levels(dt3$STD_LWRADIN))[as.integer(dt3$STD_LWRADIN) ]               
  if (class(dt3$STD_LWRADIN)=="character") dt3$STD_LWRADIN <-as.numeric(dt3$STD_LWRADIN)
  if (class(dt3$MIN_LWRADIN)=="factor") dt3$MIN_LWRADIN <-as.numeric(levels(dt3$MIN_LWRADIN))[as.integer(dt3$MIN_LWRADIN) ]               
  if (class(dt3$MIN_LWRADIN)=="character") dt3$MIN_LWRADIN <-as.numeric(dt3$MIN_LWRADIN)
  if (class(dt3$MAX_LWRADIN)=="factor") dt3$MAX_LWRADIN <-as.numeric(levels(dt3$MAX_LWRADIN))[as.integer(dt3$MAX_LWRADIN) ]               
  if (class(dt3$MAX_LWRADIN)=="character") dt3$MAX_LWRADIN <-as.numeric(dt3$MAX_LWRADIN)
  if (class(dt3$N_LWRADIN)=="factor") dt3$N_LWRADIN <-as.numeric(levels(dt3$N_LWRADIN))[as.integer(dt3$N_LWRADIN) ]               
  if (class(dt3$N_LWRADIN)=="character") dt3$N_LWRADIN <-as.numeric(dt3$N_LWRADIN)
  if (class(dt3$AVG_LWRADIN2)=="factor") dt3$AVG_LWRADIN2 <-as.numeric(levels(dt3$AVG_LWRADIN2))[as.integer(dt3$AVG_LWRADIN2) ]               
  if (class(dt3$AVG_LWRADIN2)=="character") dt3$AVG_LWRADIN2 <-as.numeric(dt3$AVG_LWRADIN2)
  if (class(dt3$STD_LWRADIN2)=="factor") dt3$STD_LWRADIN2 <-as.numeric(levels(dt3$STD_LWRADIN2))[as.integer(dt3$STD_LWRADIN2) ]               
  if (class(dt3$STD_LWRADIN2)=="character") dt3$STD_LWRADIN2 <-as.numeric(dt3$STD_LWRADIN2)
  if (class(dt3$MIN_LWRADIN2)=="factor") dt3$MIN_LWRADIN2 <-as.numeric(levels(dt3$MIN_LWRADIN2))[as.integer(dt3$MIN_LWRADIN2) ]               
  if (class(dt3$MIN_LWRADIN2)=="character") dt3$MIN_LWRADIN2 <-as.numeric(dt3$MIN_LWRADIN2)
  if (class(dt3$MAX_LWRADIN2)=="factor") dt3$MAX_LWRADIN2 <-as.numeric(levels(dt3$MAX_LWRADIN2))[as.integer(dt3$MAX_LWRADIN2) ]               
  if (class(dt3$MAX_LWRADIN2)=="character") dt3$MAX_LWRADIN2 <-as.numeric(dt3$MAX_LWRADIN2)
  if (class(dt3$N_LWRADIN2)=="factor") dt3$N_LWRADIN2 <-as.numeric(levels(dt3$N_LWRADIN2))[as.integer(dt3$N_LWRADIN2) ]               
  if (class(dt3$N_LWRADIN2)=="character") dt3$N_LWRADIN2 <-as.numeric(dt3$N_LWRADIN2)
  if (class(dt3$AVG_LWRADOUT)=="factor") dt3$AVG_LWRADOUT <-as.numeric(levels(dt3$AVG_LWRADOUT))[as.integer(dt3$AVG_LWRADOUT) ]               
  if (class(dt3$AVG_LWRADOUT)=="character") dt3$AVG_LWRADOUT <-as.numeric(dt3$AVG_LWRADOUT)
  if (class(dt3$STD_LWRADOUT)=="factor") dt3$STD_LWRADOUT <-as.numeric(levels(dt3$STD_LWRADOUT))[as.integer(dt3$STD_LWRADOUT) ]               
  if (class(dt3$STD_LWRADOUT)=="character") dt3$STD_LWRADOUT <-as.numeric(dt3$STD_LWRADOUT)
  if (class(dt3$MIN_LWRADOUT)=="factor") dt3$MIN_LWRADOUT <-as.numeric(levels(dt3$MIN_LWRADOUT))[as.integer(dt3$MIN_LWRADOUT) ]               
  if (class(dt3$MIN_LWRADOUT)=="character") dt3$MIN_LWRADOUT <-as.numeric(dt3$MIN_LWRADOUT)
  if (class(dt3$MAX_LWRADOUT)=="factor") dt3$MAX_LWRADOUT <-as.numeric(levels(dt3$MAX_LWRADOUT))[as.integer(dt3$MAX_LWRADOUT) ]               
  if (class(dt3$MAX_LWRADOUT)=="character") dt3$MAX_LWRADOUT <-as.numeric(dt3$MAX_LWRADOUT)
  if (class(dt3$N_LWRADOUT)=="factor") dt3$N_LWRADOUT <-as.numeric(levels(dt3$N_LWRADOUT))[as.integer(dt3$N_LWRADOUT) ]               
  if (class(dt3$N_LWRADOUT)=="character") dt3$N_LWRADOUT <-as.numeric(dt3$N_LWRADOUT)
  if (class(dt3$AVG_LWRADOUT2)=="factor") dt3$AVG_LWRADOUT2 <-as.numeric(levels(dt3$AVG_LWRADOUT2))[as.integer(dt3$AVG_LWRADOUT2) ]               
  if (class(dt3$AVG_LWRADOUT2)=="character") dt3$AVG_LWRADOUT2 <-as.numeric(dt3$AVG_LWRADOUT2)
  if (class(dt3$STD_LWRADOUT2)=="factor") dt3$STD_LWRADOUT2 <-as.numeric(levels(dt3$STD_LWRADOUT2))[as.integer(dt3$STD_LWRADOUT2) ]               
  if (class(dt3$STD_LWRADOUT2)=="character") dt3$STD_LWRADOUT2 <-as.numeric(dt3$STD_LWRADOUT2)
  if (class(dt3$MIN_LWRADOUT2)=="factor") dt3$MIN_LWRADOUT2 <-as.numeric(levels(dt3$MIN_LWRADOUT2))[as.integer(dt3$MIN_LWRADOUT2) ]               
  if (class(dt3$MIN_LWRADOUT2)=="character") dt3$MIN_LWRADOUT2 <-as.numeric(dt3$MIN_LWRADOUT2)
  if (class(dt3$MAX_LWRADOUT2)=="factor") dt3$MAX_LWRADOUT2 <-as.numeric(levels(dt3$MAX_LWRADOUT2))[as.integer(dt3$MAX_LWRADOUT2) ]               
  if (class(dt3$MAX_LWRADOUT2)=="character") dt3$MAX_LWRADOUT2 <-as.numeric(dt3$MAX_LWRADOUT2)
  if (class(dt3$N_LWRADOUT2)=="factor") dt3$N_LWRADOUT2 <-as.numeric(levels(dt3$N_LWRADOUT2))[as.integer(dt3$N_LWRADOUT2) ]               
  if (class(dt3$N_LWRADOUT2)=="character") dt3$N_LWRADOUT2 <-as.numeric(dt3$N_LWRADOUT2)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$AVG_PAR <- ifelse((trimws(as.character(dt3$AVG_PAR))==trimws("Null")),NA,dt3$AVG_PAR)               
  suppressWarnings(dt3$AVG_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_PAR))==as.character(as.numeric("Null"))),NA,dt3$AVG_PAR))
  dt3$STD_PAR <- ifelse((trimws(as.character(dt3$STD_PAR))==trimws("Null")),NA,dt3$STD_PAR)               
  suppressWarnings(dt3$STD_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_PAR))==as.character(as.numeric("Null"))),NA,dt3$STD_PAR))
  dt3$MIN_PAR <- ifelse((trimws(as.character(dt3$MIN_PAR))==trimws("Null")),NA,dt3$MIN_PAR)               
  suppressWarnings(dt3$MIN_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_PAR))==as.character(as.numeric("Null"))),NA,dt3$MIN_PAR))
  dt3$MAX_PAR <- ifelse((trimws(as.character(dt3$MAX_PAR))==trimws("Null")),NA,dt3$MAX_PAR)               
  suppressWarnings(dt3$MAX_PAR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_PAR))==as.character(as.numeric("Null"))),NA,dt3$MAX_PAR))
  dt3$STD_LWRADIN <- ifelse((trimws(as.character(dt3$STD_LWRADIN))==trimws("Null")),NA,dt3$STD_LWRADIN)               
  suppressWarnings(dt3$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN))
  dt3$MIN_LWRADIN <- ifelse((trimws(as.character(dt3$MIN_LWRADIN))==trimws("Null")),NA,dt3$MIN_LWRADIN)               
  suppressWarnings(dt3$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN))
  dt3$MAX_LWRADIN <- ifelse((trimws(as.character(dt3$MAX_LWRADIN))==trimws("Null")),NA,dt3$MAX_LWRADIN)               
  suppressWarnings(dt3$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN))
  dt3$STD_LWRADIN2 <- ifelse((trimws(as.character(dt3$STD_LWRADIN2))==trimws("Null")),NA,dt3$STD_LWRADIN2)               
  suppressWarnings(dt3$STD_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN2))
  dt3$MIN_LWRADIN2 <- ifelse((trimws(as.character(dt3$MIN_LWRADIN2))==trimws("Null")),NA,dt3$MIN_LWRADIN2)               
  suppressWarnings(dt3$MIN_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN2))
  dt3$MAX_LWRADIN2 <- ifelse((trimws(as.character(dt3$MAX_LWRADIN2))==trimws("Null")),NA,dt3$MAX_LWRADIN2)               
  suppressWarnings(dt3$MAX_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN2))
  dt3$STD_LWRADOUT <- ifelse((trimws(as.character(dt3$STD_LWRADOUT))==trimws("Null")),NA,dt3$STD_LWRADOUT)               
  suppressWarnings(dt3$STD_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT))
  dt3$MIN_LWRADOUT <- ifelse((trimws(as.character(dt3$MIN_LWRADOUT))==trimws("Null")),NA,dt3$MIN_LWRADOUT)               
  suppressWarnings(dt3$MIN_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADOUT))
  dt3$MAX_LWRADOUT <- ifelse((trimws(as.character(dt3$MAX_LWRADOUT))==trimws("Null")),NA,dt3$MAX_LWRADOUT)               
  suppressWarnings(dt3$MAX_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADOUT))
  dt3$STD_LWRADOUT2 <- ifelse((trimws(as.character(dt3$STD_LWRADOUT2))==trimws("Null")),NA,dt3$STD_LWRADOUT2)               
  suppressWarnings(dt3$STD_LWRADOUT2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT2))
  dt3$AVG_SWRADIN <- ifelse((trimws(as.character(dt3$AVG_SWRADIN))==trimws("Null")),NA,dt3$AVG_SWRADIN)               
  suppressWarnings(dt3$AVG_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADIN))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MIN_SWRADIN <- ifelse((trimws(as.character(dt3$MIN_SWRADIN))==trimws("Null")),NA,dt3$MIN_SWRADIN)               
  suppressWarnings(dt3$MIN_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_PAR)
  summary(STD_PAR)
  summary(MIN_PAR)
  summary(MAX_PAR)
  summary(N_PAR)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_LWRADIN2)
  summary(STD_LWRADIN2)
  summary(MIN_LWRADIN2)
  summary(MAX_LWRADIN2)
  summary(N_LWRADIN2)
  summary(AVG_LWRADOUT)
  summary(STD_LWRADOUT)
  summary(MIN_LWRADOUT)
  summary(MAX_LWRADOUT)
  summary(N_LWRADOUT)
  summary(AVG_LWRADOUT2)
  summary(STD_LWRADOUT2)
  summary(MIN_LWRADOUT2)
  summary(MAX_LWRADOUT2)
  summary(N_LWRADOUT2)
  summary(AVG_SWRADIN)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)
  
  radiation <- dt3
  
  LBnote <- TRUE
}

#Commonwealth Glacier LW
if(location == "Explorers Cove" || location == "Lake Fryxell" || location == "Lake Hoare" || location == "Lake Brownworth" ||location == "Canada Glacier" || location == "Howard Glacier"){
  inUrl3  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7107/10/7b0fe85bbfb487430f78147dbdb772c2" 
  infile3 <- tempfile()
  try(download.file(inUrl3,infile3,method="curl"))
  if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")
  
  
  dt3 <-read.csv(infile3,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_LWRADIN",     
                   "STD_LWRADIN",     
                   "MIN_LWRADIN",     
                   "MAX_LWRADIN",     
                   "N_LWRADIN",     
                   "AVG_LWRADIN2",     
                   "STD_LWRADIN2",     
                   "MIN_LWRADIN2",     
                   "MAX_LWRADIN2",     
                   "N_LWRADIN2",     
                   "AVG_LWRADOUT",     
                   "STD_LWRADOUT",     
                   "MIN_LWRADOUT",     
                   "MAX_LWRADOUT",     
                   "N_LWRADOUT",     
                   "AVG_LWRADOUT2",     
                   "STD_LWRADOUT2",     
                   "MAX_LWRADOUT2",     
                   "N_LWRADOUT2",     
                   "AVG_SWRADIN",     
                   "MIN_LWRADOUT2",     
                   "STD_SWRADIN",     
                   "MIN_SWRADIN",     
                   "MAX_SWRADIN",     
                   "N_SWRADIN",     
                   "AVG_SWRADOUT",     
                   "STD_SWRADOUT",     
                   "MIN_SWRADOUT",     
                   "MAX_SWRADOUT",     
                   "N_SWRADOUT",     
                   "AVG_THMIR",     
                   "STD_THMIR",     
                   "MIN_THMIR",     
                   "MAX_THMIR",     
                   "N_THMIR",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile3)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt3$METLOCID)!="factor") dt3$METLOCID<- as.factor(dt3$METLOCID)
  if (class(dt3$AVG_LWRADIN)=="factor") dt3$AVG_LWRADIN <-as.numeric(levels(dt3$AVG_LWRADIN))[as.integer(dt3$AVG_LWRADIN) ]               
  if (class(dt3$AVG_LWRADIN)=="character") dt3$AVG_LWRADIN <-as.numeric(dt3$AVG_LWRADIN)
  if (class(dt3$STD_LWRADIN)=="factor") dt3$STD_LWRADIN <-as.numeric(levels(dt3$STD_LWRADIN))[as.integer(dt3$STD_LWRADIN) ]               
  if (class(dt3$STD_LWRADIN)=="character") dt3$STD_LWRADIN <-as.numeric(dt3$STD_LWRADIN)
  if (class(dt3$MIN_LWRADIN)=="factor") dt3$MIN_LWRADIN <-as.numeric(levels(dt3$MIN_LWRADIN))[as.integer(dt3$MIN_LWRADIN) ]               
  if (class(dt3$MIN_LWRADIN)=="character") dt3$MIN_LWRADIN <-as.numeric(dt3$MIN_LWRADIN)
  if (class(dt3$MAX_LWRADIN)=="factor") dt3$MAX_LWRADIN <-as.numeric(levels(dt3$MAX_LWRADIN))[as.integer(dt3$MAX_LWRADIN) ]               
  if (class(dt3$MAX_LWRADIN)=="character") dt3$MAX_LWRADIN <-as.numeric(dt3$MAX_LWRADIN)
  if (class(dt3$N_LWRADIN)=="factor") dt3$N_LWRADIN <-as.numeric(levels(dt3$N_LWRADIN))[as.integer(dt3$N_LWRADIN) ]               
  if (class(dt3$N_LWRADIN)=="character") dt3$N_LWRADIN <-as.numeric(dt3$N_LWRADIN)
  if (class(dt3$AVG_LWRADIN2)=="factor") dt3$AVG_LWRADIN2 <-as.numeric(levels(dt3$AVG_LWRADIN2))[as.integer(dt3$AVG_LWRADIN2) ]               
  if (class(dt3$AVG_LWRADIN2)=="character") dt3$AVG_LWRADIN2 <-as.numeric(dt3$AVG_LWRADIN2)
  if (class(dt3$STD_LWRADIN2)=="factor") dt3$STD_LWRADIN2 <-as.numeric(levels(dt3$STD_LWRADIN2))[as.integer(dt3$STD_LWRADIN2) ]               
  if (class(dt3$STD_LWRADIN2)=="character") dt3$STD_LWRADIN2 <-as.numeric(dt3$STD_LWRADIN2)
  if (class(dt3$MIN_LWRADIN2)=="factor") dt3$MIN_LWRADIN2 <-as.numeric(levels(dt3$MIN_LWRADIN2))[as.integer(dt3$MIN_LWRADIN2) ]               
  if (class(dt3$MIN_LWRADIN2)=="character") dt3$MIN_LWRADIN2 <-as.numeric(dt3$MIN_LWRADIN2)
  if (class(dt3$MAX_LWRADIN2)=="factor") dt3$MAX_LWRADIN2 <-as.numeric(levels(dt3$MAX_LWRADIN2))[as.integer(dt3$MAX_LWRADIN2) ]               
  if (class(dt3$MAX_LWRADIN2)=="character") dt3$MAX_LWRADIN2 <-as.numeric(dt3$MAX_LWRADIN2)
  if (class(dt3$N_LWRADIN2)=="factor") dt3$N_LWRADIN2 <-as.numeric(levels(dt3$N_LWRADIN2))[as.integer(dt3$N_LWRADIN2) ]               
  if (class(dt3$N_LWRADIN2)=="character") dt3$N_LWRADIN2 <-as.numeric(dt3$N_LWRADIN2)
  if (class(dt3$AVG_LWRADOUT)=="factor") dt3$AVG_LWRADOUT <-as.numeric(levels(dt3$AVG_LWRADOUT))[as.integer(dt3$AVG_LWRADOUT) ]               
  if (class(dt3$AVG_LWRADOUT)=="character") dt3$AVG_LWRADOUT <-as.numeric(dt3$AVG_LWRADOUT)
  if (class(dt3$STD_LWRADOUT)=="factor") dt3$STD_LWRADOUT <-as.numeric(levels(dt3$STD_LWRADOUT))[as.integer(dt3$STD_LWRADOUT) ]               
  if (class(dt3$STD_LWRADOUT)=="character") dt3$STD_LWRADOUT <-as.numeric(dt3$STD_LWRADOUT)
  if (class(dt3$MIN_LWRADOUT)=="factor") dt3$MIN_LWRADOUT <-as.numeric(levels(dt3$MIN_LWRADOUT))[as.integer(dt3$MIN_LWRADOUT) ]               
  if (class(dt3$MIN_LWRADOUT)=="character") dt3$MIN_LWRADOUT <-as.numeric(dt3$MIN_LWRADOUT)
  if (class(dt3$MAX_LWRADOUT)=="factor") dt3$MAX_LWRADOUT <-as.numeric(levels(dt3$MAX_LWRADOUT))[as.integer(dt3$MAX_LWRADOUT) ]               
  if (class(dt3$MAX_LWRADOUT)=="character") dt3$MAX_LWRADOUT <-as.numeric(dt3$MAX_LWRADOUT)
  if (class(dt3$N_LWRADOUT)=="factor") dt3$N_LWRADOUT <-as.numeric(levels(dt3$N_LWRADOUT))[as.integer(dt3$N_LWRADOUT) ]               
  if (class(dt3$N_LWRADOUT)=="character") dt3$N_LWRADOUT <-as.numeric(dt3$N_LWRADOUT)
  if (class(dt3$AVG_LWRADOUT2)=="factor") dt3$AVG_LWRADOUT2 <-as.numeric(levels(dt3$AVG_LWRADOUT2))[as.integer(dt3$AVG_LWRADOUT2) ]               
  if (class(dt3$AVG_LWRADOUT2)=="character") dt3$AVG_LWRADOUT2 <-as.numeric(dt3$AVG_LWRADOUT2)
  if (class(dt3$STD_LWRADOUT2)=="factor") dt3$STD_LWRADOUT2 <-as.numeric(levels(dt3$STD_LWRADOUT2))[as.integer(dt3$STD_LWRADOUT2) ]               
  if (class(dt3$STD_LWRADOUT2)=="character") dt3$STD_LWRADOUT2 <-as.numeric(dt3$STD_LWRADOUT2)
  if (class(dt3$MAX_LWRADOUT2)=="factor") dt3$MAX_LWRADOUT2 <-as.numeric(levels(dt3$MAX_LWRADOUT2))[as.integer(dt3$MAX_LWRADOUT2) ]               
  if (class(dt3$MAX_LWRADOUT2)=="character") dt3$MAX_LWRADOUT2 <-as.numeric(dt3$MAX_LWRADOUT2)
  if (class(dt3$N_LWRADOUT2)=="factor") dt3$N_LWRADOUT2 <-as.numeric(levels(dt3$N_LWRADOUT2))[as.integer(dt3$N_LWRADOUT2) ]               
  if (class(dt3$N_LWRADOUT2)=="character") dt3$N_LWRADOUT2 <-as.numeric(dt3$N_LWRADOUT2)
  if (class(dt3$AVG_SWRADIN)=="factor") dt3$AVG_SWRADIN <-as.numeric(levels(dt3$AVG_SWRADIN))[as.integer(dt3$AVG_SWRADIN) ]               
  if (class(dt3$AVG_SWRADIN)=="character") dt3$AVG_SWRADIN <-as.numeric(dt3$AVG_SWRADIN)
  if (class(dt3$MIN_LWRADOUT2)=="factor") dt3$MIN_LWRADOUT2 <-as.numeric(levels(dt3$MIN_LWRADOUT2))[as.integer(dt3$MIN_LWRADOUT2) ]               
  if (class(dt3$MIN_LWRADOUT2)=="character") dt3$MIN_LWRADOUT2 <-as.numeric(dt3$MIN_LWRADOUT2)
  if (class(dt3$STD_SWRADIN)=="factor") dt3$STD_SWRADIN <-as.numeric(levels(dt3$STD_SWRADIN))[as.integer(dt3$STD_SWRADIN) ]               
  if (class(dt3$STD_SWRADIN)=="character") dt3$STD_SWRADIN <-as.numeric(dt3$STD_SWRADIN)
  if (class(dt3$MIN_SWRADIN)=="factor") dt3$MIN_SWRADIN <-as.numeric(levels(dt3$MIN_SWRADIN))[as.integer(dt3$MIN_SWRADIN) ]               
  if (class(dt3$MIN_SWRADIN)=="character") dt3$MIN_SWRADIN <-as.numeric(dt3$MIN_SWRADIN)
  if (class(dt3$MAX_SWRADIN)=="factor") dt3$MAX_SWRADIN <-as.numeric(levels(dt3$MAX_SWRADIN))[as.integer(dt3$MAX_SWRADIN) ]               
  if (class(dt3$MAX_SWRADIN)=="character") dt3$MAX_SWRADIN <-as.numeric(dt3$MAX_SWRADIN)
  if (class(dt3$N_SWRADIN)=="factor") dt3$N_SWRADIN <-as.numeric(levels(dt3$N_SWRADIN))[as.integer(dt3$N_SWRADIN) ]               
  if (class(dt3$N_SWRADIN)=="character") dt3$N_SWRADIN <-as.numeric(dt3$N_SWRADIN)
  if (class(dt3$AVG_SWRADOUT)=="factor") dt3$AVG_SWRADOUT <-as.numeric(levels(dt3$AVG_SWRADOUT))[as.integer(dt3$AVG_SWRADOUT) ]               
  if (class(dt3$AVG_SWRADOUT)=="character") dt3$AVG_SWRADOUT <-as.numeric(dt3$AVG_SWRADOUT)
  if (class(dt3$STD_SWRADOUT)=="factor") dt3$STD_SWRADOUT <-as.numeric(levels(dt3$STD_SWRADOUT))[as.integer(dt3$STD_SWRADOUT) ]               
  if (class(dt3$STD_SWRADOUT)=="character") dt3$STD_SWRADOUT <-as.numeric(dt3$STD_SWRADOUT)
  if (class(dt3$MIN_SWRADOUT)=="factor") dt3$MIN_SWRADOUT <-as.numeric(levels(dt3$MIN_SWRADOUT))[as.integer(dt3$MIN_SWRADOUT) ]               
  if (class(dt3$MIN_SWRADOUT)=="character") dt3$MIN_SWRADOUT <-as.numeric(dt3$MIN_SWRADOUT)
  if (class(dt3$MAX_SWRADOUT)=="factor") dt3$MAX_SWRADOUT <-as.numeric(levels(dt3$MAX_SWRADOUT))[as.integer(dt3$MAX_SWRADOUT) ]               
  if (class(dt3$MAX_SWRADOUT)=="character") dt3$MAX_SWRADOUT <-as.numeric(dt3$MAX_SWRADOUT)
  if (class(dt3$N_SWRADOUT)=="factor") dt3$N_SWRADOUT <-as.numeric(levels(dt3$N_SWRADOUT))[as.integer(dt3$N_SWRADOUT) ]               
  if (class(dt3$N_SWRADOUT)=="character") dt3$N_SWRADOUT <-as.numeric(dt3$N_SWRADOUT)
  if (class(dt3$AVG_THMIR)=="factor") dt3$AVG_THMIR <-as.numeric(levels(dt3$AVG_THMIR))[as.integer(dt3$AVG_THMIR) ]               
  if (class(dt3$AVG_THMIR)=="character") dt3$AVG_THMIR <-as.numeric(dt3$AVG_THMIR)
  if (class(dt3$STD_THMIR)=="factor") dt3$STD_THMIR <-as.numeric(levels(dt3$STD_THMIR))[as.integer(dt3$STD_THMIR) ]               
  if (class(dt3$STD_THMIR)=="character") dt3$STD_THMIR <-as.numeric(dt3$STD_THMIR)
  if (class(dt3$MIN_THMIR)=="factor") dt3$MIN_THMIR <-as.numeric(levels(dt3$MIN_THMIR))[as.integer(dt3$MIN_THMIR) ]               
  if (class(dt3$MIN_THMIR)=="character") dt3$MIN_THMIR <-as.numeric(dt3$MIN_THMIR)
  if (class(dt3$MAX_THMIR)=="factor") dt3$MAX_THMIR <-as.numeric(levels(dt3$MAX_THMIR))[as.integer(dt3$MAX_THMIR) ]               
  if (class(dt3$MAX_THMIR)=="character") dt3$MAX_THMIR <-as.numeric(dt3$MAX_THMIR)
  if (class(dt3$N_THMIR)=="factor") dt3$N_THMIR <-as.numeric(levels(dt3$N_THMIR))[as.integer(dt3$N_THMIR) ]               
  if (class(dt3$N_THMIR)=="character") dt3$N_THMIR <-as.numeric(dt3$N_THMIR)
  if (class(dt3$N_COMMENTS)=="factor") dt3$N_COMMENTS <-as.numeric(levels(dt3$N_COMMENTS))[as.integer(dt3$N_COMMENTS) ]               
  if (class(dt3$N_COMMENTS)=="character") dt3$N_COMMENTS <-as.numeric(dt3$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt3$STD_LWRADIN <- ifelse((trimws(as.character(dt3$STD_LWRADIN))==trimws("Null")),NA,dt3$STD_LWRADIN)               
  suppressWarnings(dt3$STD_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN))
  dt3$MIN_LWRADIN <- ifelse((trimws(as.character(dt3$MIN_LWRADIN))==trimws("Null")),NA,dt3$MIN_LWRADIN)               
  suppressWarnings(dt3$MIN_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN))
  dt3$MAX_LWRADIN <- ifelse((trimws(as.character(dt3$MAX_LWRADIN))==trimws("Null")),NA,dt3$MAX_LWRADIN)               
  suppressWarnings(dt3$MAX_LWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN))
  dt3$STD_LWRADIN2 <- ifelse((trimws(as.character(dt3$STD_LWRADIN2))==trimws("Null")),NA,dt3$STD_LWRADIN2)               
  suppressWarnings(dt3$STD_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADIN2))
  dt3$MIN_LWRADIN2 <- ifelse((trimws(as.character(dt3$MIN_LWRADIN2))==trimws("Null")),NA,dt3$MIN_LWRADIN2)               
  suppressWarnings(dt3$MIN_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADIN2))
  dt3$MAX_LWRADIN2 <- ifelse((trimws(as.character(dt3$MAX_LWRADIN2))==trimws("Null")),NA,dt3$MAX_LWRADIN2)               
  suppressWarnings(dt3$MAX_LWRADIN2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADIN2))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADIN2))
  dt3$STD_LWRADOUT <- ifelse((trimws(as.character(dt3$STD_LWRADOUT))==trimws("Null")),NA,dt3$STD_LWRADOUT)               
  suppressWarnings(dt3$STD_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT))
  dt3$MIN_LWRADOUT <- ifelse((trimws(as.character(dt3$MIN_LWRADOUT))==trimws("Null")),NA,dt3$MIN_LWRADOUT)               
  suppressWarnings(dt3$MIN_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_LWRADOUT))
  dt3$MAX_LWRADOUT <- ifelse((trimws(as.character(dt3$MAX_LWRADOUT))==trimws("Null")),NA,dt3$MAX_LWRADOUT)               
  suppressWarnings(dt3$MAX_LWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_LWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_LWRADOUT))
  dt3$STD_LWRADOUT2 <- ifelse((trimws(as.character(dt3$STD_LWRADOUT2))==trimws("Null")),NA,dt3$STD_LWRADOUT2)               
  suppressWarnings(dt3$STD_LWRADOUT2 <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_LWRADOUT2))==as.character(as.numeric("Null"))),NA,dt3$STD_LWRADOUT2))
  dt3$STD_SWRADIN <- ifelse((trimws(as.character(dt3$STD_SWRADIN))==trimws("Null")),NA,dt3$STD_SWRADIN)               
  suppressWarnings(dt3$STD_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADIN))
  dt3$MAX_SWRADIN <- ifelse((trimws(as.character(dt3$MAX_SWRADIN))==trimws("Null")),NA,dt3$MAX_SWRADIN)               
  suppressWarnings(dt3$MAX_SWRADIN <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADIN))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADIN))
  dt3$AVG_SWRADOUT <- ifelse((trimws(as.character(dt3$AVG_SWRADOUT))==trimws("Null")),NA,dt3$AVG_SWRADOUT)               
  suppressWarnings(dt3$AVG_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$AVG_SWRADOUT))
  dt3$STD_SWRADOUT <- ifelse((trimws(as.character(dt3$STD_SWRADOUT))==trimws("Null")),NA,dt3$STD_SWRADOUT)               
  suppressWarnings(dt3$STD_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$STD_SWRADOUT))
  dt3$MIN_SWRADOUT <- ifelse((trimws(as.character(dt3$MIN_SWRADOUT))==trimws("Null")),NA,dt3$MIN_SWRADOUT)               
  suppressWarnings(dt3$MIN_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MIN_SWRADOUT))
  dt3$MAX_SWRADOUT <- ifelse((trimws(as.character(dt3$MAX_SWRADOUT))==trimws("Null")),NA,dt3$MAX_SWRADOUT)               
  suppressWarnings(dt3$MAX_SWRADOUT <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_SWRADOUT))==as.character(as.numeric("Null"))),NA,dt3$MAX_SWRADOUT))
  dt3$AVG_THMIR <- ifelse((trimws(as.character(dt3$AVG_THMIR))==trimws("Null")),NA,dt3$AVG_THMIR)               
  suppressWarnings(dt3$AVG_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$AVG_THMIR))==as.character(as.numeric("Null"))),NA,dt3$AVG_THMIR))
  dt3$STD_THMIR <- ifelse((trimws(as.character(dt3$STD_THMIR))==trimws("Null")),NA,dt3$STD_THMIR)               
  suppressWarnings(dt3$STD_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$STD_THMIR))==as.character(as.numeric("Null"))),NA,dt3$STD_THMIR))
  dt3$MIN_THMIR <- ifelse((trimws(as.character(dt3$MIN_THMIR))==trimws("Null")),NA,dt3$MIN_THMIR)               
  suppressWarnings(dt3$MIN_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MIN_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MIN_THMIR))
  dt3$MAX_THMIR <- ifelse((trimws(as.character(dt3$MAX_THMIR))==trimws("Null")),NA,dt3$MAX_THMIR)               
  suppressWarnings(dt3$MAX_THMIR <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt3$MAX_THMIR))==as.character(as.numeric("Null"))),NA,dt3$MAX_THMIR))
  
  
  # Here is the structure of the input data frame:
  str(dt3)                            
  attach(dt3)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_LWRADIN)
  summary(STD_LWRADIN)
  summary(MIN_LWRADIN)
  summary(MAX_LWRADIN)
  summary(N_LWRADIN)
  summary(AVG_LWRADIN2)
  summary(STD_LWRADIN2)
  summary(MIN_LWRADIN2)
  summary(MAX_LWRADIN2)
  summary(N_LWRADIN2)
  summary(AVG_LWRADOUT)
  summary(STD_LWRADOUT)
  summary(MIN_LWRADOUT)
  summary(MAX_LWRADOUT)
  summary(N_LWRADOUT)
  summary(AVG_LWRADOUT2)
  summary(STD_LWRADOUT2)
  summary(MAX_LWRADOUT2)
  summary(N_LWRADOUT2)
  summary(AVG_SWRADIN)
  summary(MIN_LWRADOUT2)
  summary(STD_SWRADIN)
  summary(MIN_SWRADIN)
  summary(MAX_SWRADIN)
  summary(N_SWRADIN)
  summary(AVG_SWRADOUT)
  summary(STD_SWRADOUT)
  summary(MIN_SWRADOUT)
  summary(MAX_SWRADOUT)
  summary(N_SWRADOUT)
  summary(AVG_THMIR)
  summary(STD_THMIR)
  summary(MIN_THMIR)
  summary(MAX_THMIR)
  summary(N_THMIR)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt3$METLOCID))
  detach(dt3)
  
  radiation <- dt3
  
  CoGnote <- TRUE
}

#No Soil temperature locations will use the lake bonney data to fill in the code that needs it but the graphs and summary are adjusted to not include in the output
if(location == "Miers Valley" || location == "Mount Fleming" || location == "Taylor Glacier" || location == "Canada Glacier" || location == "Commonwealth Glacier" || location == "Howard Glacier" || location == "Friis Hills"){
  inUrl6  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-mcm/7103/10/1d35c69228ee34b66bc5dfc89e6e347c" 
  infile6 <- tempfile()
  try(download.file(inUrl6,infile6,method="curl"))
  if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")
  
  
  dt6 <-read.csv(infile6,header=F 
                 ,skip=1
                 ,sep=","  
                 , col.names=c(
                   "METLOCID",     
                   "DATE_TIME",     
                   "AVG_SOILT0CM",     
                   "STD_SOILT0CM",     
                   "MIN_SOILT0CM",     
                   "MAX_SOILT0CM",     
                   "N_SOILT0CM",     
                   "AVG_SOILT5CM",     
                   "STD_SOILT5CM",     
                   "MIN_SOILT5CM",     
                   "MAX_SOILT5CM",     
                   "N_SOILT5CM",     
                   "AVG_SOILT10CM",     
                   "STD_SOILT10CM",     
                   "MIN_SOILT10CM",     
                   "MAX_SOILT10CM",     
                   "N_SOILT10CM",     
                   "N_COMMENTS"    ), check.names=TRUE)
  
  unlink(infile6)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(dt6$METLOCID)!="factor") dt6$METLOCID<- as.factor(dt6$METLOCID)
  if (class(dt6$AVG_SOILT0CM)=="factor") dt6$AVG_SOILT0CM <-as.numeric(levels(dt6$AVG_SOILT0CM))[as.integer(dt6$AVG_SOILT0CM) ]               
  if (class(dt6$AVG_SOILT0CM)=="character") dt6$AVG_SOILT0CM <-as.numeric(dt6$AVG_SOILT0CM)
  if (class(dt6$STD_SOILT0CM)=="factor") dt6$STD_SOILT0CM <-as.numeric(levels(dt6$STD_SOILT0CM))[as.integer(dt6$STD_SOILT0CM) ]               
  if (class(dt6$STD_SOILT0CM)=="character") dt6$STD_SOILT0CM <-as.numeric(dt6$STD_SOILT0CM)
  if (class(dt6$MIN_SOILT0CM)=="factor") dt6$MIN_SOILT0CM <-as.numeric(levels(dt6$MIN_SOILT0CM))[as.integer(dt6$MIN_SOILT0CM) ]               
  if (class(dt6$MIN_SOILT0CM)=="character") dt6$MIN_SOILT0CM <-as.numeric(dt6$MIN_SOILT0CM)
  if (class(dt6$MAX_SOILT0CM)=="factor") dt6$MAX_SOILT0CM <-as.numeric(levels(dt6$MAX_SOILT0CM))[as.integer(dt6$MAX_SOILT0CM) ]               
  if (class(dt6$MAX_SOILT0CM)=="character") dt6$MAX_SOILT0CM <-as.numeric(dt6$MAX_SOILT0CM)
  if (class(dt6$N_SOILT0CM)=="factor") dt6$N_SOILT0CM <-as.numeric(levels(dt6$N_SOILT0CM))[as.integer(dt6$N_SOILT0CM) ]               
  if (class(dt6$N_SOILT0CM)=="character") dt6$N_SOILT0CM <-as.numeric(dt6$N_SOILT0CM)
  if (class(dt6$AVG_SOILT5CM)=="factor") dt6$AVG_SOILT5CM <-as.numeric(levels(dt6$AVG_SOILT5CM))[as.integer(dt6$AVG_SOILT5CM) ]               
  if (class(dt6$AVG_SOILT5CM)=="character") dt6$AVG_SOILT5CM <-as.numeric(dt6$AVG_SOILT5CM)
  if (class(dt6$STD_SOILT5CM)=="factor") dt6$STD_SOILT5CM <-as.numeric(levels(dt6$STD_SOILT5CM))[as.integer(dt6$STD_SOILT5CM) ]               
  if (class(dt6$STD_SOILT5CM)=="character") dt6$STD_SOILT5CM <-as.numeric(dt6$STD_SOILT5CM)
  if (class(dt6$MIN_SOILT5CM)=="factor") dt6$MIN_SOILT5CM <-as.numeric(levels(dt6$MIN_SOILT5CM))[as.integer(dt6$MIN_SOILT5CM) ]               
  if (class(dt6$MIN_SOILT5CM)=="character") dt6$MIN_SOILT5CM <-as.numeric(dt6$MIN_SOILT5CM)
  if (class(dt6$MAX_SOILT5CM)=="factor") dt6$MAX_SOILT5CM <-as.numeric(levels(dt6$MAX_SOILT5CM))[as.integer(dt6$MAX_SOILT5CM) ]               
  if (class(dt6$MAX_SOILT5CM)=="character") dt6$MAX_SOILT5CM <-as.numeric(dt6$MAX_SOILT5CM)
  if (class(dt6$N_SOILT5CM)=="factor") dt6$N_SOILT5CM <-as.numeric(levels(dt6$N_SOILT5CM))[as.integer(dt6$N_SOILT5CM) ]               
  if (class(dt6$N_SOILT5CM)=="character") dt6$N_SOILT5CM <-as.numeric(dt6$N_SOILT5CM)
  if (class(dt6$AVG_SOILT10CM)=="factor") dt6$AVG_SOILT10CM <-as.numeric(levels(dt6$AVG_SOILT10CM))[as.integer(dt6$AVG_SOILT10CM) ]               
  if (class(dt6$AVG_SOILT10CM)=="character") dt6$AVG_SOILT10CM <-as.numeric(dt6$AVG_SOILT10CM)
  if (class(dt6$STD_SOILT10CM)=="factor") dt6$STD_SOILT10CM <-as.numeric(levels(dt6$STD_SOILT10CM))[as.integer(dt6$STD_SOILT10CM) ]               
  if (class(dt6$STD_SOILT10CM)=="character") dt6$STD_SOILT10CM <-as.numeric(dt6$STD_SOILT10CM)
  if (class(dt6$MIN_SOILT10CM)=="factor") dt6$MIN_SOILT10CM <-as.numeric(levels(dt6$MIN_SOILT10CM))[as.integer(dt6$MIN_SOILT10CM) ]               
  if (class(dt6$MIN_SOILT10CM)=="character") dt6$MIN_SOILT10CM <-as.numeric(dt6$MIN_SOILT10CM)
  if (class(dt6$MAX_SOILT10CM)=="factor") dt6$MAX_SOILT10CM <-as.numeric(levels(dt6$MAX_SOILT10CM))[as.integer(dt6$MAX_SOILT10CM) ]               
  if (class(dt6$MAX_SOILT10CM)=="character") dt6$MAX_SOILT10CM <-as.numeric(dt6$MAX_SOILT10CM)
  if (class(dt6$N_SOILT10CM)=="factor") dt6$N_SOILT10CM <-as.numeric(levels(dt6$N_SOILT10CM))[as.integer(dt6$N_SOILT10CM) ]               
  if (class(dt6$N_SOILT10CM)=="character") dt6$N_SOILT10CM <-as.numeric(dt6$N_SOILT10CM)
  if (class(dt6$N_COMMENTS)=="factor") dt6$N_COMMENTS <-as.numeric(levels(dt6$N_COMMENTS))[as.integer(dt6$N_COMMENTS) ]               
  if (class(dt6$N_COMMENTS)=="character") dt6$N_COMMENTS <-as.numeric(dt6$N_COMMENTS)
  
  # Convert Missing Values to NA for non-dates
  
  dt6$AVG_SOILT0CM <- ifelse((trimws(as.character(dt6$AVG_SOILT0CM))==trimws("Null")),NA,dt6$AVG_SOILT0CM)               
  suppressWarnings(dt6$AVG_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT0CM))
  dt6$STD_SOILT0CM <- ifelse((trimws(as.character(dt6$STD_SOILT0CM))==trimws("Null")),NA,dt6$STD_SOILT0CM)               
  suppressWarnings(dt6$STD_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT0CM))
  dt6$MIN_SOILT0CM <- ifelse((trimws(as.character(dt6$MIN_SOILT0CM))==trimws("Null")),NA,dt6$MIN_SOILT0CM)               
  suppressWarnings(dt6$MIN_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT0CM))
  dt6$MAX_SOILT0CM <- ifelse((trimws(as.character(dt6$MAX_SOILT0CM))==trimws("Null")),NA,dt6$MAX_SOILT0CM)               
  suppressWarnings(dt6$MAX_SOILT0CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT0CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT0CM))
  dt6$AVG_SOILT5CM <- ifelse((trimws(as.character(dt6$AVG_SOILT5CM))==trimws("Null")),NA,dt6$AVG_SOILT5CM)               
  suppressWarnings(dt6$AVG_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT5CM))
  dt6$STD_SOILT5CM <- ifelse((trimws(as.character(dt6$STD_SOILT5CM))==trimws("Null")),NA,dt6$STD_SOILT5CM)               
  suppressWarnings(dt6$STD_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT5CM))
  dt6$MIN_SOILT5CM <- ifelse((trimws(as.character(dt6$MIN_SOILT5CM))==trimws("Null")),NA,dt6$MIN_SOILT5CM)               
  suppressWarnings(dt6$MIN_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT5CM))
  dt6$MAX_SOILT5CM <- ifelse((trimws(as.character(dt6$MAX_SOILT5CM))==trimws("Null")),NA,dt6$MAX_SOILT5CM)               
  suppressWarnings(dt6$MAX_SOILT5CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT5CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT5CM))
  dt6$AVG_SOILT10CM <- ifelse((trimws(as.character(dt6$AVG_SOILT10CM))==trimws("Null")),NA,dt6$AVG_SOILT10CM)               
  suppressWarnings(dt6$AVG_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$AVG_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$AVG_SOILT10CM))
  dt6$STD_SOILT10CM <- ifelse((trimws(as.character(dt6$STD_SOILT10CM))==trimws("Null")),NA,dt6$STD_SOILT10CM)               
  suppressWarnings(dt6$STD_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$STD_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$STD_SOILT10CM))
  dt6$MIN_SOILT10CM <- ifelse((trimws(as.character(dt6$MIN_SOILT10CM))==trimws("Null")),NA,dt6$MIN_SOILT10CM)               
  suppressWarnings(dt6$MIN_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MIN_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MIN_SOILT10CM))
  dt6$MAX_SOILT10CM <- ifelse((trimws(as.character(dt6$MAX_SOILT10CM))==trimws("Null")),NA,dt6$MAX_SOILT10CM)               
  suppressWarnings(dt6$MAX_SOILT10CM <- ifelse(!is.na(as.numeric("Null")) & (trimws(as.character(dt6$MAX_SOILT10CM))==as.character(as.numeric("Null"))),NA,dt6$MAX_SOILT10CM))
  
  
  # Here is the structure of the input data frame:
  str(dt6)                            
  attach(dt6)                            
  # The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 
  
  summary(METLOCID)
  summary(DATE_TIME)
  summary(AVG_SOILT0CM)
  summary(STD_SOILT0CM)
  summary(MIN_SOILT0CM)
  summary(MAX_SOILT0CM)
  summary(N_SOILT0CM)
  summary(AVG_SOILT5CM)
  summary(STD_SOILT5CM)
  summary(MIN_SOILT5CM)
  summary(MAX_SOILT5CM)
  summary(N_SOILT5CM)
  summary(AVG_SOILT10CM)
  summary(STD_SOILT10CM)
  summary(MIN_SOILT10CM)
  summary(MAX_SOILT10CM)
  summary(N_SOILT10CM)
  summary(N_COMMENTS) 
  # Get more details on character variables
  
  summary(as.factor(dt6$METLOCID))
  detach(dt6)
  
  soiltemp <- dt6
  
  soiltempcheck <- FALSE
}

##Soil and Air Temperature
#This section of code looks at the basic information from the air and soil temperature data
#In this we create a daily temperature plot, as well as create a plot using only the winter data, which helps us to get a basic understanding of the overall themes and trends.
#Converts date column into something usable for air temperature and soil temperature data. Then creates a decimal date, year, and day of year column for both
pfdat <- soiltemp
pfdat <- pfdat[complete.cases(pfdat[,c(3,8,13)]),]
pfdat$date <- as.Date(pfdat$DATE_TIME, format = "%m/%d/%y")
pfdat$decimalyear <- decimal_date(pfdat$date)
pfdat$year <- floor(pfdat$decimalyear)  
pfdat$doy <- yday(pfdat$date)
airtemp <- airtemp[complete.cases(airtemp$AVG_AIRT3M),]
airtemp$date <- as.Date(airtemp$DATE_TIME, format = "%m/%d/%y")
airtemp$decimalyear <- decimal_date(airtemp$date)
airtemp$year <- floor(airtemp$decimalyear) 
airtemp$doy <- yday(airtemp$date)

#Daily Soil Temperature plot
if(soiltempcheck){
plot(pfdat$AVG_SOILT0CM~pfdat$decimalyear, type = "l", ylab = "Temperature (\u00B0C)", xlab = "Year", main = "Daily Soil Temperature")
}
#Daily Air Temperature plot
plot(airtemp$AVG_AIRT3M~airtemp$decimalyear, type = "l", ylab = "Temperature (\u00B0C)", xlab = "Year", main = "Daily Air Temperature")

#This creates a new data frame containing only data from the winter days
fullpfdat_winter <- pfdat[pfdat$doy >= 121 & pfdat$doy <= 273,]
fullairtemp_winter <- airtemp[airtemp$doy >= 121 & airtemp$doy <= 273,]

#To clean the winter time data we remove a year if it has data for less than 90% of the days in the winter months.
n = 0
pfdat_winter <- fullpfdat_winter
for (j in 1:length(fullpfdat_winter$year)){
  if (j == 1){n = 0} #Need this because there is no fullpfdat_winter$year[0]
  else{
    if (fullpfdat_winter$year[j]==fullpfdat_winter$year[j-1]){
      n = n+1
    }
    if (fullpfdat_winter$year[j]!=fullpfdat_winter$year[j-1]){
      if ((n/(273-121))<0.90){
        pfdat_winter <- pfdat_winter[pfdat_winter$year != fullpfdat_winter$year[j-1],]
      }
      n = 0
    }
  }
}
n = 0
airtemp_winter <- fullairtemp_winter
for (j in 1:length(fullairtemp_winter$year)){
  if (j == 1){n = 0}
  else{
    if (fullairtemp_winter$year[j]==fullairtemp_winter$year[j-1]){
      n = n+1
    }
    if (fullairtemp_winter$year[j]!=fullairtemp_winter$year[j-1]){
      if ((n/(273-121))<0.90){
        airtemp_winter <- airtemp_winter[airtemp_winter$year != fullairtemp_winter$year[j-1],]
      }
      n = 0
    }
  }
}

#This group collects data on the yearly mean, minimum, and maximum temperatures for each year 
meanT0 <- mean(pfdat_winter$AVG_SOILT0CM, na.rm = TRUE)
maxes <- aggregate(pfdat_winter$AVG_SOILT0CM, list(pfdat_winter$year), max)
mins <- aggregate(pfdat_winter$AVG_SOILT0CM, list(pfdat_winter$year), min)
means <- aggregate(pfdat_winter$AVG_SOILT0CM, list(pfdat_winter$year), mean)
ourmax <- mean(maxes$x, na.rm = TRUE)
ourmin <- mean(mins$x, na.rm = TRUE)
ourmean <- mean(means$x, na.rm = TRUE)

#Plots winter time 0cm temperature 
if(soiltempcheck){
plot(pfdat_winter$AVG_SOILT0CM~pfdat_winter$decimalyear, pch = 20, ylab = "Temperature (\u00B0C)", xlab = "Year", main = "Winter Temperatures")+
  abline(h = meanT0)+
  abline(h = ourmax)+
  abline(h = ourmin)+
  abline(h = ourmean, lty = 3, col = "red")

#Plots yearly wintertime minimums
plot(mins$Group.1, mins$x, ylab = "Temperature (\u00B0C)", xlab = "Year", main = "Minimum Winter Temperature", pch = 20)
abline(lm(mins$x~mins$Group.1))
iswinterwarming <- lm(mins$x~mins$Group.1)
summary(iswinterwarming)

#Plots yearly wintertime maxes
plot(maxes$Group.1, maxes$x, ylab = "Temperature (\u00B0C)", xlab = "Year", main = "Maximum Winter Temperature", pch = 20)
abline(lm(maxes$x~maxes$Group.1))
iswinterwarmingmax <- lm(maxes$x~maxes$Group.1)
summary(iswinterwarmingmax)
}
###Freezing Degree Days Soil and Air Temperatures
#This part of the script adds up all the temperature in the winter months for each year to create what we call freezing degree days. This helps us to get a full understanding of how much freezing is actually occurring during the winter.

#Add all the temperature up using R's aggregate function and relabels columns

temptotalforyear0cm <- aggregate(pfdat_winter$AVG_SOILT0CM, list(pfdat_winter$year), sum)
temptotalforyear0cm <- setNames(temptotalforyear0cm, c("year", "totaltemp0"))
temptotalforyear5cm <- aggregate(pfdat_winter$AVG_SOILT5CM, list(pfdat_winter$year), sum)
temptotalforyear5cm <- setNames(temptotalforyear5cm, c("year", "totaltemp5"))
temptotalforyear10cm <- aggregate(pfdat_winter$AVG_SOILT10CM, list(pfdat_winter$year), sum)
temptotalforyear10cm <- setNames(temptotalforyear10cm, c("year", "totaltemp10"))
airtemptotalforyear <- aggregate(airtemp_winter$AVG_AIRT3M, list(airtemp_winter$year), sum)
airtemptotalforyear <- setNames(airtemptotalforyear, c("year", "totaltempair"))

#Plot data: This plots soil temperature freezing degree days and includes all three depths
if(soiltempcheck){
plot(temptotalforyear0cm$year, temptotalforyear0cm$totaltemp0, ylab = "Soil Freezing Index (Summed FDD)", xlab = "Year", main = "Winter Soil Freezing Index", col = "black", pch = 20)
abline(lm(temptotalforyear0cm$totaltemp0~temptotalforyear0cm$year), col = "black")
points(temptotalforyear5cm$year, temptotalforyear5cm$totaltemp5, col = "green", pch = 20)
abline(lm(temptotalforyear5cm$totaltemp5~temptotalforyear5cm$year), col= "green")
points(temptotalforyear10cm$year, temptotalforyear10cm$totaltemp10, col = "red", pch = 20)
abline(lm(temptotalforyear10cm$totaltemp10~temptotalforyear10cm$year), col= "red")
legend("bottomright", legend = c("0cm", "5cm", "10cm"), col = c("black", "green", "red"), pch = 20)
#This gives us the statistical values for the linear best fit lines
iswinterwarmingFDD0cm <- lm(temptotalforyear0cm$totaltemp0~temptotalforyear0cm$year)
sumiswinterwarmingFDD0cm <- summary(iswinterwarmingFDD0cm)
iswinterwarmingFDD5cm <- lm(temptotalforyear5cm$totaltemp5~temptotalforyear5cm$year)
sumiswinterwarmingFDD5cm <- summary(iswinterwarmingFDD5cm)
iswinterwarmingFDD10cm <- lm(temptotalforyear10cm$totaltemp10~temptotalforyear10cm$year)
sumiswinterwarmingFDD10cm <- summary(iswinterwarmingFDD10cm)
}
#Plot data: This plots air temperature freezing degree days
plot(airtemptotalforyear$year, airtemptotalforyear$totaltempair, ylab = "Air Freezing Index (Summed FDD)", xlab = "Year", main = "Winter Air Freezing Index", col = "black", pch = 20)
abline(lm(airtemptotalforyear$totaltempair~airtemptotalforyear$year), col = "black")
#This gives us the statistical values for the best fit lines
iswinterwarmingFDDAir <- lm(airtemptotalforyear$totaltempair~airtemptotalforyear$year)
sumiswinterwarmingFDDAir <- summary(iswinterwarmingFDDAir)

yearofzerofreezing0cm = -iswinterwarmingFDD0cm$coefficients[1]/iswinterwarmingFDD0cm$coefficients[2]
yearofzerofreezing5cm = -iswinterwarmingFDD5cm$coefficients[1]/iswinterwarmingFDD5cm$coefficients[2]
yearofzerofreezing10cm = -iswinterwarmingFDD10cm$coefficients[1]/iswinterwarmingFDD10cm$coefficients[2]
yearofzerofreezingAir = -iswinterwarmingFDDAir$coefficients[1]/iswinterwarmingFDDAir$coefficients[2]

##write zero FDD

freezinginfo <- data.frame(yearofzerofreezing0cm,iswinterwarmingFDD0cm$coefficients[1],iswinterwarmingFDD0cm$coefficients[2])
writeloc <- paste(location,"_year_of_zero.csv", sep = "")

write.csv(freezinginfo, writeloc)

##Wind data
#Now that we have the temperature data it is now time to look at the wind data. The section of the code is a repeat of the first section concerning the temperature data.
windspeed <- windspeed[complete.cases(windspeed$AVG_WSPD),] #Since this only contains one section of data we can clear points that don't have the wind speed average
windspeed$date <- as.Date(windspeed$DATE_TIME, format = "%m/%d/%y")
windspeed$decimalyear <- decimal_date(windspeed$date)
windspeed$year <- floor(windspeed$decimalyear)
windspeed$doy <- yday(windspeed$date)

#This creates a new data frame containing only data from the winter days
fullwinddat_winter <- windspeed[windspeed$doy >= 121 & windspeed$doy <= 273,]

#Clean data: Make sure that each winter has at least 90% of the days if it doesn't 
#we will ignore that year
n = 0
winddat_winter <- fullwinddat_winter
for (j in 1:length(fullwinddat_winter$year)){
  if (j == 1){n = 0}
  else{
    if (fullwinddat_winter$year[j]==fullwinddat_winter$year[j-1]){
      n = n+1
    }
    if (fullwinddat_winter$year[j]!=fullwinddat_winter$year[j-1]){
      if (n/(273-121)<0.90){
        winddat_winter <- winddat_winter[winddat_winter$year != fullwinddat_winter$year[j-1],]
      }
      n = 0
    }
  }
}

#Plots the Winter time wind speed data
plot(winddat_winter$AVG_WSPD~winddat_winter$decimalyear, pch = 20, ylab = "Wind Speed (m/s)", xlab = "Year", main = "Winter Daily Wind Speed")
meanT0 <- mean(winddat_winter$AVG_WSPD, na.rm = TRUE)
abline(h = meanT0)

#Wintertime maximum data, yearly and continuous 
wmaxes <- aggregate(winddat_winter$AVG_WSPD, list(winddat_winter$year), max)
wourmax <- mean(wmaxes$x, na.rm = TRUE)
abline(h = wourmax)
#Wintertime minimum data, yearly and continuous 
wmins <- aggregate(winddat_winter$AVG_WSPD, list(winddat_winter$year), min)
wourmin <- mean(wmins$x, na.rm = TRUE)
abline(h = wourmin)
#Wintertime mean data, yearly and continuous 
wmeans <- aggregate(winddat_winter$AVG_WSPD, list(winddat_winter$year), mean)
wourmean <- mean(wmeans$x, na.rm = TRUE)
abline(h = wourmean, lty = 3, col = "red")

#Data that contains days with no Down-Valley Wind day. As a rough estimate we are using 5 m/s daily average windspeed as the threshold to determine if it is Down-Valley Wind or not.
winddat_winter_noDW <- winddat_winter[winddat_winter$AVG_WSPD < 5,]

###Wind Days
#Just like the freezing degree days this section looks at the total wind during the winter for each year. This will give us a broad sense of how much wind the area experienced during the winter. A more detialed analysis will look into the Down-Valley Winds.

totalwinddays_noDW <- aggregate(winddat_winter_noDW$AVG_WSPD, list(winddat_winter_noDW$year), sum)
totalwinddays_noDW <- setNames(totalwinddays_noDW, c("year", "totalwind_noDW"))

totalwinddays <- aggregate(winddat_winter$AVG_WSPD, list(winddat_winter$year), sum)
totalwinddays <- setNames(totalwinddays, c("year", "totalwind"))

plot(totalwinddays$year, totalwinddays$totalwind, pch = 20, ylab = "Wind Velocity Days", xlab = "Year", main = "Yearly Winter Wind Total")
abline(lm(totalwinddays$totalwind~totalwinddays$year))
iswinterwarmingWD <- lm(totalwinddays$totalwind~totalwinddays$year)
sumiswinterwarmingWD <- summary(iswinterwarmingWD)

plot(totalwinddays_noDW$year, totalwinddays_noDW$totalwind_noDW, pch = 20, ylab = "Wind Velocity Days", xlab = "Year", main = "Yearly Winter Wind Total Down-Valley Wind Days Removed")
abline(lm(totalwinddays$totalwind~totalwinddays$year))
iswinterwarmingWD_noDW <- lm(totalwinddays_noDW$totalwind_noDW~totalwinddays_noDW$year)
sumiswinterwarmingWD_noDW <- summary(iswinterwarmingWD_noDW)

##Temperature data without Down-Valley Wind events
#Creates a data frame of soil temperature with only the days that have average wind speed below 5 m/s
df_list4 <- list(pfdat_winter[,c(3,8,13,19)], winddat_winter_noDW[,c(which(colnames(winddat_winter_noDW)=="AVG_WSPD"),which(colnames(winddat_winter_noDW)=="date"))]) #have to create a list by the date
wintertempnhwe <- Reduce(function(x, y) merge(x, y, all=TRUE), df_list4) #combines the data based on the date
wintertempnhwe <- wintertempnhwe[complete.cases(wintertempnhwe),] #by looking at complete cases it removes the days with Down-Valley Wind
wintertempnhwe$decimalyear <- decimal_date(wintertempnhwe$date)
wintertempnhwe$year <- floor(wintertempnhwe$decimalyear)

#Repeats for air temperature
df_list4 <- list(winddat_winter_noDW[,c(which(colnames(winddat_winter_noDW)=="AVG_WSPD"),which(colnames(winddat_winter_noDW)=="date"))], airtemp_winter[,c(which(colnames(airtemp_winter)=="AVG_AIRT3M"),which(colnames(airtemp_winter)=="date"))])
winterairtempnhwe <- Reduce(function(x, y) merge(x, y, all=TRUE), df_list4)
winterairtempnhwe <- winterairtempnhwe[complete.cases(winterairtempnhwe),]
winterairtempnhwe$decimalyear <- decimal_date(winterairtempnhwe$date)
winterairtempnhwe$year <- floor(winterairtempnhwe$decimalyear)

#calculates temperature FDD without Down-Valley Wind events. 
temptotalforyear0cmnhwe <- aggregate(wintertempnhwe$AVG_SOILT0CM, list(wintertempnhwe$year), sum)
temptotalforyear0cmnhwe <- setNames(temptotalforyear0cmnhwe, c("year", "totaltemp0"))
temptotalforyear5cmnhwe <- aggregate(wintertempnhwe$AVG_SOILT5CM, list(wintertempnhwe$year), sum)
temptotalforyear5cmnhwe <- setNames(temptotalforyear5cmnhwe, c("year", "totaltemp5"))
temptotalforyear10cmnhwe <- aggregate(wintertempnhwe$AVG_SOILT10CM, list(wintertempnhwe$year), sum)
temptotalforyear10cmnhwe <- setNames(temptotalforyear10cmnhwe, c("year", "totaltemp10"))
airtemptotalforyearnhwe <- aggregate(winterairtempnhwe$AVG_AIRT3M, list(winterairtempnhwe$year), sum)
airtemptotalforyearnhwe <- setNames(airtemptotalforyearnhwe, c("year", "totaltempair"))

#Plots the yearly soil temperature without Down-Valley Wind Days
if(soiltempcheck){
plot(temptotalforyear0cmnhwe$totaltemp0~temptotalforyear0cmnhwe$year, ylab = "Soil Freezing Index (Summed FDD)", xlab = "Year", main = "Freezing Index\n (Down-Valley Wind Days removed)", col = "black", pch = 20)
abline(lm(temptotalforyear0cmnhwe$totaltemp0~temptotalforyear0cmnhwe$year), col = "black")
points(temptotalforyear5cmnhwe$year, temptotalforyear5cmnhwe$totaltemp5, col = "green", pch = 20)
abline(lm(temptotalforyear5cmnhwe$totaltemp5~temptotalforyear5cmnhwe$year), col= "green")
points(temptotalforyear10cmnhwe$year, temptotalforyear10cmnhwe$totaltemp10, col = "red", pch = 20)
abline(lm(temptotalforyear10cmnhwe$totaltemp10~temptotalforyear10cmnhwe$year), col= "red")
legend("bottomright", legend = c("0cm", "5cm", "10cm"), col = c("black", "green", "red"), pch = 20)
#This gives us the statistical values for the linear best fit lines
iswinterwarmingFDD0cmnhwe <- lm(temptotalforyear0cmnhwe$totaltemp0~temptotalforyear0cmnhwe$year)
sumiswinterwarmingFDD0cmnhwe <- summary(iswinterwarmingFDD0cmnhwe)
iswinterwarmingFDD5cmnhwe <- lm(temptotalforyear5cmnhwe$totaltemp5~temptotalforyear5cmnhwe$year)
sumiswinterwarmingFDD5cmnhwe <- summary(iswinterwarmingFDD5cmnhwe)
iswinterwarmingFDD10cmnhwe <- lm(temptotalforyear10cmnhwe$totaltemp10~temptotalforyear10cmnhwe$year)
sumiswinterwarmingFDD10cmnhwe <- summary(iswinterwarmingFDD10cmnhwe)
}
#Plots the yearly air temperature without Down-Valley Wind Days
plot(airtemptotalforyearnhwe$year, airtemptotalforyearnhwe$totaltempair, ylab = "Air Freezing Index (Summed FDD)", xlab = "Year", main = "Air Freezing Index\n (Down-Valley Wind Days removed)", col = "black", pch = 20)
abline(lm(airtemptotalforyearnhwe$totaltempair~airtemptotalforyearnhwe$year), col = "black")
#This gives us the statistical values for the best fit lines
iswinterwarmingFDDAirnhwe <- lm(airtemptotalforyearnhwe$totaltempair~airtemptotalforyearnhwe$year)
sumiswinterwarmingFDDAirnhwe <- summary(iswinterwarmingFDDAirnhwe)

#Calculates when there will be no more freezing in the winter
yearofzerofreezing0cmnhwe = -iswinterwarmingFDD0cmnhwe$coefficients[1]/iswinterwarmingFDD0cmnhwe$coefficients[2]
yearofzerofreezing5cmnhwe = -iswinterwarmingFDD5cmnhwe$coefficients[1]/iswinterwarmingFDD5cmnhwe$coefficients[2]
yearofzerofreezing10cmnhwe = -iswinterwarmingFDD10cmnhwe$coefficients[1]/iswinterwarmingFDD10cmnhwe$coefficients[2]
yearofzerofreezingAirnhwe = -iswinterwarmingFDDAirnhwe$coefficients[1]/iswinterwarmingFDDAirnhwe$coefficients[2]

##High Frequency Wind Data

#show the data. This helps us to determine direction of Down-Valley Winds.
plot(wind$wspd~wind$wdir, pch = ".", main = "Wind Speed and Direction", xlab = "Wind Direction", ylab = "Wind Speed (m/s)")

#flag measurements with down-valley wind
wind$dircheck <- ifelse(wind$wdir<360 & wind$wdir > 150,1,0)

#flag measurements with windspeed > 5 m/s
wind$speedcheck <- ifelse(wind$wspd>5,1,0)

#flag measurments that are both the right speed and direction
wind$DWs <- wind$dircheck*wind$speedcheck

#simplify to dates
wind$date <- as.Date(wind$date_time, format = "%m/%d/%y")

###Down-Valley Wind per year (full year)
#calculate number of measurements per day that are Down-Valley Wind-like
fullwindsum <- aggregate(wind$DWs, by = list(wind$date), FUN = "sum", na.rm = TRUE)
#finds how many measurements were taken each day, which is needed for the fraction calculation
numwindmeasurements <- aggregate(wind$date, by = list(wind$date), FUN = "length")
fullwindsum <- setNames(fullwindsum, c("date", "DWeventsperday"))
fullwindsum$nummeasurements <- numwindmeasurements$x
fullwindsum$year <- year(fullwindsum$date)
fullwindsum$decimalyear <- decimal_date(fullwindsum$date)
fullwindsum$doy <- yday(fullwindsum$date)
fullwindsum <- fullwindsum[complete.cases(fullwindsum),]

#Clean data: Make sure that each winter has at least 90% of the days if it doesn't 
#we will ignore that year
windsum <- fullwindsum
for (j in 1:length(fullwindsum$year)){
  if (j == 1){n = 0}
  else{
    if (fullwindsum$year[j]==fullwindsum$year[j-1]){
      n = n+1
    }
    if (fullwindsum$year[j]!=fullwindsum$year[j-1]){
      if (n/(365)<0.90){
        windsum <- windsum[windsum$year != fullwindsum$year[j-1],]
      }
      n = 0
    }
  }
}
windsum$DW_frac <- windsum$DWeventsperday/windsum$nummeasurements

#plot fraction of day that is Down-Valley Wind like 
#plot(windsum$DW_frac ~ windsum$date, pch = ".")

#pick out dates where Down-Valley Wind conditions persisted for more than half the day
justDWs2 <- windsum[windsum$DW_frac>0.5,]
justDWs <- data.frame()
#This checks to see if there are two days in a row with Down-Valley Wind conditions or if the day has Down-Valley Wind conditions for more than half the day. If one of these is true then it is flagged.
for (j in 1:length(windsum$DW_frac)){
  if (j == 1){
    if((windsum$DW_frac[j]>0.5 & windsum$DW_frac[j+1]>0.5) || (windsum$DW_frac[j]>0.75)){
      justDWs <- rbind(justDWs, windsum[j,])
    }
  }
  else{
    if (j == length(windsum$DW_frac)){
      if((windsum$DW_frac[j]>0.5 & windsum$DW_frac[j-1]>0.5) || (windsum$DW_frac[j]>0.75)){
        justDWs <- rbind(justDWs, windsum[j,])
      }
    }
    else{
      if((windsum$DW_frac[j]>0.5 & windsum$DW_frac[j+1]>0.5) || (windsum$DW_frac[j]>0.75) || (windsum$DW_frac[j]>0.5 & windsum$DW_frac[j-1]>0.5)){
        justDWs <- rbind(justDWs, windsum[j,])
      }
    }
  }
}

#how many Down-Valley Wind Days per year
DWs_by_year <- aggregate(justDWs$DWeventsperday, by = list(justDWs$year), FUN = "length")
DWs_by_year <- setNames(DWs_by_year, c("year", "DWperyear"))

plot(DWs_by_year$DWperyear~DWs_by_year$year, pch = 20, ylab = "Number of Down-Valley Wind Events", xlab = "Year", main = "Yearly Down-Valley Wind Event Days")

###Down-Valley Wind events per year (winter)
#Need only winter Down-Valley Wind
fullwindsumwinter <- windsum[windsum$doy >= 121 & windsum$doy <= 273,]

windsumwinter <- fullwindsumwinter
for (j in 1:length(fullwindsumwinter$year)){
  if (j == 1){n = 0}
  else{
    if (fullwindsumwinter$year[j]==fullwindsumwinter$year[j-1]){
      n = n+1
    }
    if (fullwindsumwinter$year[j]!=fullwindsumwinter$year[j-1]){
      if (n/(273-121)<0.90){
        windsumwinter <- windsumwinter[windsumwinter$year != fullwindsumwinter$year[j-1],]
      }
      n = 0
    }
  }
}

#plot fraction of day that is Down-Valley Wind like 
#plot(windsumwinter$DW_frac ~ windsumwinter$date, pch = ".")

#total winter fraction of measurements that are Down-Valley Wind
DW_events <- aggregate(windsumwinter$DWeventsperday, by = list(windsumwinter$year), FUN = "sum")
DW_events <- setNames(DW_events, c("year", "DWtotal"))
wind_measurements <- aggregate(windsumwinter$nummeasurements, by = list(windsumwinter$year), FUN = "sum")
wind_measurements <- setNames(wind_measurements, c("year", "windmeasurements"))
df_list3 <- list(DW_events, wind_measurements)
windDWtotal <- Reduce(function(x, y) merge(x, y, all=TRUE), df_list3)
windDWtotal$frac <- windDWtotal$DWtotal/windDWtotal$windmeasurements
DWfrac <- windDWtotal[c(2:24),c(1,4)]

#pick out dates where Down-Valley Wind conditions persisted for more than half the day
justDWswinter <- windsumwinter[windsumwinter$DW_frac>0.5,]
justDWswinter2 <- windsumwinter[windsumwinter$DW_frac>0.6,]
justDWswinter3 <- windsumwinter[windsumwinter$DW_frac>0.7,]
justDWswinter4 <- windsumwinter[windsumwinter$DW_frac>0.8,]

#how many Down-Valley Wind Days per year
DWs_by_yearwinter <- aggregate(justDWswinter$DWeventsperday, by = list(justDWswinter$year), FUN = "length")
DWs_by_yearwinter <- setNames(DWs_by_yearwinter, c("year", "DWperyear"))
DWs_by_yearwinter2 <- aggregate(justDWswinter2$DWeventsperday, by = list(justDWswinter2$year), FUN = "length")
DWs_by_yearwinter2 <- setNames(DWs_by_yearwinter2, c("year", "DWperyear2"))
DWs_by_yearwinter3 <- aggregate(justDWswinter3$DWeventsperday, by = list(justDWswinter3$year), FUN = "length")
DWs_by_yearwinter3 <- setNames(DWs_by_yearwinter3, c("year", "DWperyear3"))
DWs_by_yearwinter4 <- aggregate(justDWswinter4$DWeventsperday, by = list(justDWswinter4$year), FUN = "length")
DWs_by_yearwinter4 <- setNames(DWs_by_yearwinter4, c("year", "DWperyear4"))

NotDW_by_yearwinter <- (273-121) - DWs_by_yearwinter$DWperyear

dwby50 <- lm(DWs_by_yearwinter$DWperyear~DWs_by_yearwinter$year)
dwby60 <- lm(DWs_by_yearwinter2$DWperyear2~DWs_by_yearwinter2$year)
dwby70 <- lm(DWs_by_yearwinter3$DWperyear3~DWs_by_yearwinter3$year)
dwby80 <- lm(DWs_by_yearwinter4$DWperyear4~DWs_by_yearwinter4$year)

sumdwby50 <- summary(dwby50)
sumdwby60 <- summary(dwby60)
sumdwby70 <- summary(dwby70)
sumdwby80 <- summary(dwby80)

#plots Down-Valley Winds per year for 
plot(DWs_by_yearwinter$DWperyear~DWs_by_yearwinter$year, pch = 20, ylab = "Number of Down-Valley Wind Days", xlab = "Year", main = "Yearly Wintertime Down-Valley Wind Days (50%)")
abline(dwby50)
plot(DWs_by_yearwinter2$DWperyear2~DWs_by_yearwinter2$year, pch = 20, ylab = "Number of Down-Valley Wind Days", xlab = "Year", main = "Yearly Wintertime Down-Valley Wind Days (60%)")
abline(dwby60)
plot(DWs_by_yearwinter3$DWperyear3~DWs_by_yearwinter3$year, pch = 20, ylab = "Number of Down-Valley Wind Days", xlab = "Year", main = "Yearly Wintertime Down-Valley Wind Days (70%)")
abline(dwby70)
plot(DWs_by_yearwinter4$DWperyear4~DWs_by_yearwinter4$year, pch = 20, ylab = "Number of Down-Valley Wind Days", xlab = "Year", main = "Yearly Wintertime Down-Valley Wind Days (80%)")
abline(dwby80)

##Longwave radiation
#We don't have Longwave for every site we only have it for data in one valley so this can be a problem, but lets start of by looking at those valleys and going from there.

radiation <- radiation[complete.cases(radiation$AVG_LWRADIN),] #Since we are only looking at long wave radiation we only want data with it

#Converts date column into something use able for radiation. Then creates a decimal date, year, and day of year column for both
radiation$date <- as.Date(radiation$DATE_TIME, format = "%m/%d/%y")
radiation$decimalyear <- decimal_date(radiation$date)
radiation$year <- floor(radiation$decimalyear)
radiation$doy <- yday(radiation$date)

#This creates a new data frame containing only data from the winter days
fullradiation_winter <- radiation[radiation$doy >= 121 & radiation$doy <= 273,]

#Clean data: Make sure that each winter has at least 90% of the days if it doesn't 
#we will ignore that year
n = 0
radiation_winter <- fullradiation_winter
for (j in 1:length(fullradiation_winter$year)){
  if (j == 1){n = 0}
  else{
    if (fullradiation_winter$year[j]==fullradiation_winter$year[j-1]){
      n = n+1
    }
    if (fullradiation_winter$year[j]!=fullradiation_winter$year[j-1]){
      if (n/(273-121)<0.90){
        radiation_winter <- radiation_winter[radiation_winter$year != fullradiation_winter$year[j-1],]
      }
      n = 0
    }
  }
}

#Plots the Winter time longwave radiation data
#plot(radiation_winter$AVG_LWRADIN~radiation_winter$decimalyear, pch = ".")
meanrad <- mean(radiation_winter$AVG_LWRADIN, na.rm = TRUE)
abline(h = meanrad)

#Wintertime maximum data, yearly and continuous 
wmaxes <- aggregate(radiation_winter$AVG_LWRADIN, list(radiation_winter$year), max)
wourmax <- mean(wmaxes$x, na.rm = TRUE)
abline(h = wourmax)
#Wintertime minimum data, yearly and continuous 
wmins <- aggregate(radiation_winter$AVG_LWRADIN, list(radiation_winter$year), min)
wourmin <- mean(wmins$x, na.rm = TRUE)
abline(h = wourmin)
#Wintertime mean data, yearly and continuous 
wmeans <- aggregate(radiation_winter$AVG_LWRADIN, list(radiation_winter$year), mean)
wourmean <- mean(wmeans$x, na.rm = TRUE)
abline(h = wourmean, lty = 3, col = "red")
#Just like the freezing degree days this section looks at the total longwave radiation during the winter for each year. This will give us a broad sense of how much longwave radiation the Earth is radiating during the winter. 

totalradiationdays <- aggregate(radiation_winter$AVG_LWRADIN, list(radiation_winter$year), sum)
totalradiationdays <- setNames(totalradiationdays, c("year", "totalradiation"))

plot(totalradiationdays$year, totalradiationdays$totalradiation, ylab = "Longwave Radiation Days", xlab = "Year", main = "Yearly Winter Long Wave Radiation Total", pch = 20)
abline(lm(totalradiationdays$totalradiation~totalradiationdays$year))
iswinterwarmingRD <- lm(totalradiationdays$totalradiation~totalradiationdays$year)
sumiswinterwarmingRD <- summary(iswinterwarmingRD)

radandwind <- merge(totalradiationdays,DWs_by_year, by = "year")

plot(radandwind$totalradiation~radandwind$DWperyear, ylab = "Longwave Radiation Days", xlab = "Down-Valley Wind Days", pch = 20, main = "Down-Valley Winds (50%) versus Incoming Longwave Radiation")

iswinterwarmingRDDWD50 <- lm(radandwind$totalradiation~radandwind$DWperyear)
abline(iswinterwarmingRDDWD50)
sumiswinterwarmingRDDWD50 <- summary(iswinterwarmingRDDWD50)

#Clean Data
#Combine all data in one data frame (Make it easier to remove incomplete rows)

df_list <- list(totalwinddays, temptotalforyear0cm, temptotalforyear5cm, temptotalforyear10cm, airtemptotalforyear, DWs_by_yearwinter, DWs_by_yearwinter2, DWs_by_yearwinter3, DWs_by_yearwinter4, totalradiationdays, totalwinddays_noDW, DWfrac)
combineddata <- Reduce(function(x, y) merge(x, y, all=TRUE), df_list)

#Analysis
##Wind vs Soil Temp
#Makes wind and soil temperature plot. This includes best fit lines for each depth.
if(soiltempcheck){
plot(combineddata$totalwind, combineddata$totaltemp0, pch = 20, main = "Wintertime Wind\n and Soil Freezing Index", xlab = "Wind Velocity Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$totalwind))
points(combineddata$totalwind, combineddata$totaltemp5, col = "green", pch = 20)
abline(lm(combineddata$totaltemp5~combineddata$totalwind), col = "green")
points(combineddata$totalwind, combineddata$totaltemp10, col = "red", pch = 20)
abline(lm(combineddata$totaltemp10~combineddata$totalwind), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
#This gives us the statistical values for the linear best fit lines
windvtemp0 <- lm(combineddata$totaltemp0~combineddata$totalwind)
sumwindvtemp0 <- summary(windvtemp0)
windvtemp5 <- lm(combineddata$totaltemp5~combineddata$totalwind)
sumwindvtemp5 <- summary(windvtemp5)
windvtemp10 <- lm(combineddata$totaltemp10~combineddata$totalwind)
sumwindvtemp10 <- summary(windvtemp10)

#Same plot but no Down-Valley Wind events
plot(combineddata$totalwind_noDW, combineddata$totaltemp0, pch = 20, main = "Wintertime Wind\n and Soil Freezing Index (Down-Valley Wind Days removed)", xlab = "Wind Velocity Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$totalwind_noDW))
points(combineddata$totalwind_noDW, combineddata$totaltemp5, col = "green", pch = 20)
abline(lm(combineddata$totaltemp5~combineddata$totalwind_noDW), col = "green")
points(combineddata$totalwind_noDW, combineddata$totaltemp10, col = "red", pch = 20)
abline(lm(combineddata$totaltemp10~combineddata$totalwind_noDW), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
#This gives us the statistical values for the linear best fit lines
windvtemp0_noDW <- lm(combineddata$totaltemp0~combineddata$totalwind_noDW)
sumwindvtemp0_noDW <- summary(windvtemp0_noDW)
windvtemp5_noDW <- lm(combineddata$totaltemp5~combineddata$totalwind_noDW)
sumwindvtemp5_noDW <- summary(windvtemp5_noDW)
windvtemp10_noDW <- lm(combineddata$totaltemp10~combineddata$totalwind_noDW)
sumwindvtemp10_noDW <- summary(windvtemp10_noDW)
}
#Looks at daily Data
#pfdat_winteryear <- pfdat_winter[,c(3,8,13,19,20,21,22)]
#winddat_winteryear <- winddat_winter[,c(3, 9, 10, 11, 12)]
#df_list2 <- list(pfdat_winteryear,winddat_winteryear)
#combineddataoneyear <- Reduce(function(x, y) merge(x, y, all=TRUE), df_list2)
#combineddataoneyear <- combineddataoneyear[complete.cases(combineddataoneyear),]
#plot(combineddataoneyear$AVG_WSPD, combineddataoneyear$AVG_SOILT0CM)

##Wind v Air temperature
#air temperature v wind
plot(combineddata$totalwind, combineddata$totaltempair, pch = 20, main = "Wintertime Wind\n and Air Freezing Index", xlab = "Wind Velocity Days", ylab = "Air Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$totalwind))
windvtempair <- lm(combineddata$totaltempair~combineddata$totalwind)
sumwindvtempair <- summary(windvtempair)

#air temperature v wind no Down-Valley Wind events
plot(combineddata$totalwind_noDW, combineddata$totaltempair, pch = 20, main = "Wintertime Wind\n and Air Freezing Index (Down-Valley Wind Days removed)", xlab = "Wind Velocity Days", ylab = "Air Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$totalwind_noDW))
windvtempair_noDW <- lm(combineddata$totaltempair~combineddata$totalwind_noDW)
sumwindvtempair_noDW <- summary(windvtempair_noDW)

##Longwave Radiation v soil Temperature 
#Makes wind and soil temperature plot. This includes best fit lines for each depth.
if(soiltempcheck){
plot(combineddata$totalradiation, combineddata$totaltemp0, pch = 20, main = "Longwave Radiation\n and Soil Freezing Index", xlab = expression("Radiation W/m"^2*" Days"), ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$totalradiation))
points(combineddata$totalradiation, combineddata$totaltemp5, col = "green", pch = 20)
abline(lm(combineddata$totaltemp5~combineddata$totalradiation), col = "green")
points(combineddata$totalradiation, combineddata$totaltemp10, col = "red", pch = 20)
abline(lm(combineddata$totaltemp10~combineddata$totalradiation), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
#This gives us the statistical values for the linear best fit lines
radvtemp0 <- lm(combineddata$totaltemp0~combineddata$totalradiation)
sumradvtemp0 <-summary(radvtemp0)
radvtemp5 <- lm(combineddata$totaltemp5~combineddata$totalradiation)
sumradvtemp5 <-summary(radvtemp5)
radvtemp10 <- lm(combineddata$totaltemp10~combineddata$totalradiation)
sumradvtemp10 <- summary(radvtemp10)
}

##Long wave radiation v Air temperature
plot(combineddata$totalradiation, combineddata$totaltempair, pch = 20, main = "Wintertime Longwave Radiation\n and Air Freezing Index", xlab = "Radiation W/m^2 Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$totalradiation))
radiationvtempair <- lm(combineddata$totaltempair~combineddata$totalradiation)
sumradiationvtempair <- summary(radiationvtempair)

##Down-Valley Winds v Temperature
#compares Down-Valley Wind Days per year to soil temperature 0,5,10 cm (50%)
if(soiltempcheck){
plot(combineddata$totaltemp0~combineddata$DWperyear, pch = 20, col = "black", main = "Wintertime Down-Valley Winds\n and Soil Freezing Index (50%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$DWperyear), col = "black")
points(combineddata$totaltemp5~combineddata$DWperyear, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$DWperyear), col = "green")
points(combineddata$totaltemp10~combineddata$DWperyear, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$DWperyear), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
DWvtemp0 <- lm(combineddata$totaltemp0~combineddata$DWperyear)
sumDWvtemp0 <- summary(DWvtemp0)
DWvtemp5 <- lm(combineddata$totaltemp5~combineddata$DWperyear)
sumDWvtemp5 <- summary(DWvtemp5)
DWvtemp10 <- lm(combineddata$totaltemp10~combineddata$DWperyear)
sumDWvtemp10 <- summary(DWvtemp10)
}

#compares Down-Valley Wind Days per year to air temp (50%)
plot(combineddata$totaltempair~combineddata$DWperyear, pch =20, col = "black", main = "Wintertime Down-Valley Winds\n and Air Freezing Index (50%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$DWperyear), col = "black")
DWvairtemp <- lm(combineddata$totaltempair~combineddata$DWperyear)
sumDWvairtemp <- summary(DWvairtemp)

if(soiltempcheck){
#compares Down-Valley Wind Days per year to soil temperature 0,5,10 cm (60%)
plot(combineddata$totaltemp0~combineddata$DWperyear2, pch = 20, col = "black", main = "Wintertime Down-Valley Winds\n and Soil Freezing Index (60%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$DWperyear2), col = "black")
points(combineddata$totaltemp5~combineddata$DWperyear2, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$DWperyear2), col = "green")
points(combineddata$totaltemp10~combineddata$DWperyear2, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$DWperyear2), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
DWvtemp02 <- lm(combineddata$totaltemp0~combineddata$DWperyear2)
sumDWvtemp02 <- summary(DWvtemp02)
DWvtemp52 <- lm(combineddata$totaltemp5~combineddata$DWperyear2)
sumDWvtemp52 <- summary(DWvtemp52)
DWvtemp102 <- lm(combineddata$totaltemp10~combineddata$DWperyear2)
sumDWvtemp102 <- summary(DWvtemp102)
}

#compares Down-Valley Wind Days per year to air temp (60%)
plot(combineddata$totaltempair~combineddata$DWperyear2, pch =20, col = "black", main = "Wintertime Down-Valley Winds\n and Air Freezing Index (60%)", xlab = "Down-Valley Wind Days", ylab = "Air Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$DWperyear2), col = "black")
DWvairtemp2 <- lm(combineddata$totaltempair~combineddata$DWperyear2)
sumDWvairtemp2 <- summary(DWvairtemp2)

if(soiltempcheck){
#compares Down-Valley Wind Days per year to soil temperature 0,5,10 cm (70%)
plot(combineddata$totaltemp0~combineddata$DWperyear3, pch = 20, col = "black", main = "Wintertime Down-Valley Winds\n and Soil Freezing Index (70%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$DWperyear3), col = "black")
points(combineddata$totaltemp5~combineddata$DWperyear3, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$DWperyear3), col = "green")
points(combineddata$totaltemp10~combineddata$DWperyear3, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$DWperyear3), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
DWvtemp03 <- lm(combineddata$totaltemp0~combineddata$DWperyear3)
sumDWvtemp03 <- summary(DWvtemp03)
DWvtemp53 <- lm(combineddata$totaltemp5~combineddata$DWperyear3)
sumDWvtemp53 <- summary(DWvtemp53)
DWvtemp103 <- lm(combineddata$totaltemp10~combineddata$DWperyear3)
sumDWvtemp103 <- summary(DWvtemp103)
}

#compares Down-Valley Wind Days per year to air temp (70%)
plot(combineddata$totaltempair~combineddata$DWperyear3, pch =20, col = "black", main = "Wintertime Down-Valley Winds\n and Air Freezing Index (70%)", xlab = "Down-Valley Wind Days", ylab = "Air Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$DWperyear3), col = "black")
DWvairtemp3 <- lm(combineddata$totaltempair~combineddata$DWperyear3)
sumDWvairtemp3 <- summary(DWvairtemp3)

if(soiltempcheck){
#compares Down-Valley Wind Days per year to soil temperature 0,5,10 cm (80%)
plot(combineddata$totaltemp0~combineddata$DWperyear4, pch = 20, col = "black", main = "Wintertime Down-Valley Winds\n and Soil Freezing Index (80%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$DWperyear4), col = "black")
points(combineddata$totaltemp5~combineddata$DWperyear4, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$DWperyear4), col = "green")
points(combineddata$totaltemp10~combineddata$DWperyear4, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$DWperyear4), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
DWvtemp04 <- lm(combineddata$totaltemp0~combineddata$DWperyear4)
sumDWvtemp04 <- summary(DWvtemp04)
DWvtemp54 <- lm(combineddata$totaltemp5~combineddata$DWperyear4)
sumDWvtemp54 <- summary(DWvtemp54)
DWvtemp104 <- lm(combineddata$totaltemp10~combineddata$DWperyear4)
sumDWvtemp104 <- summary(DWvtemp104)
}

#compares Down-Valley Wind Days per year to air temp (80%)
plot(combineddata$totaltempair~combineddata$DWperyear4, pch =20, col = "black", main = "Wintertime Down-Valley Winds\n and Air Freezing Index (80%)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$DWperyear4), col = "black")
DWvairtemp4 <- lm(combineddata$totaltempair~combineddata$DWperyear4)
sumDWvairtemp4 <- summary(DWvairtemp4)

if(soiltempcheck){
#compares Down-Valley Wind Days per year to soil temperature 0,5,10 cm (fraction)
plot(combineddata$totaltemp0~combineddata$frac, pch = 20, col = "black", main = "Wintertime Down-Valley Winds\n and Soil Freezing Index (fraction)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$frac), col = "black")
points(combineddata$totaltemp5~combineddata$frac, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$frac), col = "green")
points(combineddata$totaltemp10~combineddata$frac, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$frac), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)
DWvtemp0frac <- lm(combineddata$totaltemp0~combineddata$frac)
sumDWvtemp0frac <- summary(DWvtemp03)
DWvtemp5frac <- lm(combineddata$totaltemp5~combineddata$frac)
sumDWvtemp5frac <- summary(DWvtemp53)
DWvtemp10frac <- lm(combineddata$totaltemp10~combineddata$frac)
sumDWvtemp10frac <- summary(DWvtemp103)
}

#compares Down-Valley Wind Days per year to air temp (fraction)
plot(combineddata$totaltempair~combineddata$frac, pch =20, col = "black", main = "Wintertime Down-Valley Winds\n and Air Freezing Index (fraction)", xlab = "Down-Valley Wind Days", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltempair~combineddata$frac), col = "black")
DWvairtempfrac <- lm(combineddata$totaltempair~combineddata$frac)
sumDWvairtempfrac <- summary(DWvairtemp3)


## Air temperature v Soil temperature
#compares Air temperature to soil temperature 0,5,10 cm 
if(soiltempcheck){
plot(combineddata$totaltemp0~combineddata$totaltempair, pch = 20, col = "black", main = "Air and Soil Freezing Index", xlab = "Air Freezing Index (Summed FDD)", ylab = "Soil Freezing Index (Summed FDD)")
abline(lm(combineddata$totaltemp0~combineddata$totaltempair), col = "black")
points(combineddata$totaltemp5~combineddata$totaltempair, pch =20, col = "green")
abline(lm(combineddata$totaltemp5~combineddata$totaltempair), col = "green")
points(combineddata$totaltemp10~combineddata$totaltempair, pch =20, col = "red")
abline(lm(combineddata$totaltemp10~combineddata$totaltempair), col = "red")
legend("bottomright", legend = c("0cm","5cm", "10cm"), col = c("black","green", "red"), pch = 20)

airvtemp0 <- lm(combineddata$totaltemp0~combineddata$totaltempair)
sumairvtemp0 <- summary(airvtemp0)
airvtemp5 <- lm(combineddata$totaltemp5~combineddata$totaltempair)
sumairvtemp5 <- summary(airvtemp5)
airvtemp10 <- lm(combineddata$totaltemp10~combineddata$totaltempair)
sumairvtemp10 <- summary(airvtemp10)
}



#Summary Table
#Combine all of the summaries into one data table. This specifically includes the linear intercepts and slopes, as well as the r-square value and p-value
if(soiltempcheck){
Note <- c("","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","")
if(CoGnote){
Note <- c("","","","","","","","","CoG LW","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","CoG LW","CoG LW","CoG LW","CoG LW","","","","","","","","")
}
if(LBnote){
  Note <- c("","","","","","","","","LB LW","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","LB LW","LB LW","LB LW","LB LW","","","","","","","","")
}
Intercept <- c(iswinterwarmingFDD0cm$coefficients[1], iswinterwarmingFDD5cm$coefficients[1], iswinterwarmingFDD10cm$coefficients[1], iswinterwarmingFDDAir$coefficients[1], iswinterwarmingFDD0cmnhwe$coefficients[1], iswinterwarmingFDD5cmnhwe$coefficients[1], iswinterwarmingFDD10cmnhwe$coefficients[1], iswinterwarmingFDDAirnhwe$coefficients[1], iswinterwarmingRD$coefficients[1], iswinterwarmingWD$coefficients[1], windvtemp0$coefficients[1], windvtemp5$coefficients[1], windvtemp10$coefficients[1], windvtempair$coefficients[1], windvtemp0_noDW$coefficients[1], windvtemp5_noDW$coefficients[1], windvtemp10_noDW$coefficients[1], windvtempair_noDW$coefficients[1], DWvtemp0$coefficients[1], DWvtemp5$coefficients[1], DWvtemp10$coefficients[1], DWvairtemp$coefficients[1], DWvtemp02$coefficients[1], DWvtemp52$coefficients[1], DWvtemp102$coefficients[1], DWvairtemp2$coefficients[1], DWvtemp03$coefficients[1], DWvtemp53$coefficients[1], DWvtemp103$coefficients[1], DWvairtemp3$coefficients[1], DWvtemp04$coefficients[1], DWvtemp54$coefficients[1], DWvtemp104$coefficients[1], DWvairtemp4$coefficients[1], DWvtemp0frac$coefficients[1], DWvtemp5frac$coefficients[1], DWvtemp10frac$coefficients[1], DWvairtempfrac$coefficients[1], radvtemp0$coefficients[1], radvtemp5$coefficients[1], radvtemp10$coefficients[1], radiationvtempair$coefficients[1], airvtemp0$coefficients[1], airvtemp5$coefficients[1], airvtemp10$coefficients[1], dwby50$coefficients[1],dwby60$coefficients[1], dwby70$coefficients[1], dwby80$coefficients[1], iswinterwarmingRDDWD50$coefficients[1])
slope <- c(iswinterwarmingFDD0cm$coefficients[2], iswinterwarmingFDD5cm$coefficients[2], iswinterwarmingFDD10cm$coefficients[2], iswinterwarmingFDDAir$coefficients[2], iswinterwarmingFDD0cmnhwe$coefficients[2], iswinterwarmingFDD5cmnhwe$coefficients[2], iswinterwarmingFDD10cmnhwe$coefficients[2], iswinterwarmingFDDAirnhwe$coefficients[2], iswinterwarmingRD$coefficients[2], iswinterwarmingWD$coefficients[2], windvtemp0$coefficients[2], windvtemp5$coefficients[2], windvtemp10$coefficients[2], windvtempair$coefficients[2], windvtemp0_noDW$coefficients[2], windvtemp5_noDW$coefficients[2], windvtemp10_noDW$coefficients[2], windvtempair_noDW$coefficients[2], DWvtemp0$coefficients[2], DWvtemp5$coefficients[2], DWvtemp10$coefficients[2], DWvairtemp$coefficients[2], DWvtemp02$coefficients[2], DWvtemp52$coefficients[2], DWvtemp102$coefficients[2], DWvairtemp2$coefficients[2], DWvtemp03$coefficients[2], DWvtemp53$coefficients[2], DWvtemp103$coefficients[2], DWvairtemp3$coefficients[2], DWvtemp04$coefficients[2], DWvtemp54$coefficients[2], DWvtemp104$coefficients[2], DWvairtemp4$coefficients[2], DWvtemp0frac$coefficients[2], DWvtemp5frac$coefficients[2], DWvtemp10frac$coefficients[2], DWvairtempfrac$coefficients[2], radvtemp0$coefficients[2], radvtemp5$coefficients[2], radvtemp10$coefficients[2], radiationvtempair$coefficients[2], airvtemp0$coefficients[2], airvtemp5$coefficients[2], airvtemp10$coefficients[2], dwby50$coefficients[2],dwby60$coefficients[2], dwby70$coefficients[2], dwby80$coefficients[2], iswinterwarmingRDDWD50$coefficients[2])
p_value <- c(sumiswinterwarmingFDD0cm$coefficients[8], sumiswinterwarmingFDD5cm$coefficients[8], sumiswinterwarmingFDD10cm$coefficients[8], sumiswinterwarmingFDDAir$coefficients[8], sumiswinterwarmingFDD0cmnhwe$coefficients[8], sumiswinterwarmingFDD5cmnhwe$coefficients[8], sumiswinterwarmingFDD10cmnhwe$coefficients[8], sumiswinterwarmingFDDAirnhwe$coefficients[8], sumiswinterwarmingRD$coefficients[8], sumiswinterwarmingWD$coefficients[8], sumwindvtemp0$coefficients[8], sumwindvtemp5$coefficients[8], sumwindvtemp10$coefficients[8], sumwindvtempair$coefficients[8], sumwindvtemp0_noDW$coefficients[8], sumwindvtemp5_noDW$coefficients[8], sumwindvtemp10_noDW$coefficients[8], sumwindvtempair_noDW$coefficients[8], sumDWvtemp0$coefficients[8], sumDWvtemp5$coefficients[8], sumDWvtemp10$coefficients[8], sumDWvairtemp$coefficients[8], sumDWvtemp02$coefficients[8], sumDWvtemp52$coefficients[8], sumDWvtemp102$coefficients[8], sumDWvairtemp2$coefficients[8], sumDWvtemp03$coefficients[8], sumDWvtemp53$coefficients[8], sumDWvtemp103$coefficients[8], sumDWvairtemp3$coefficients[8], sumDWvtemp04$coefficients[8], sumDWvtemp54$coefficients[8], sumDWvtemp104$coefficients[8], sumDWvairtemp4$coefficients[8], sumDWvtemp0frac$coefficients[8], sumDWvtemp5frac$coefficients[8], sumDWvtemp10frac$coefficients[8], sumDWvairtempfrac$coefficients[8], sumradvtemp0$coefficients[8], sumradvtemp5$coefficients[8], sumradvtemp10$coefficients[8], sumradiationvtempair$coefficients[8], sumairvtemp0$coefficients[8], sumairvtemp5$coefficients[8], sumairvtemp10$coefficients[8], sumdwby50$coefficients[8], sumdwby60$coefficients[8], sumdwby70$coefficients[8], sumdwby80$coefficients[8], sumiswinterwarmingRDDWD50$coefficients[8])
R_squared <- c(sumiswinterwarmingFDD0cm$r.squared, sumiswinterwarmingFDD5cm$r.squared, sumiswinterwarmingFDD10cm$r.squared, sumiswinterwarmingFDDAir$r.squared, sumiswinterwarmingFDD0cmnhwe$r.squared, sumiswinterwarmingFDD5cmnhwe$r.squared, sumiswinterwarmingFDD10cmnhwe$r.squared, sumiswinterwarmingFDDAirnhwe$r.squared, sumiswinterwarmingRD$r.squared, sumiswinterwarmingWD$r.squared, sumwindvtemp0$r.squared, sumwindvtemp5$r.squared, sumwindvtemp10$r.squared, sumwindvtempair$r.squared, sumwindvtemp0_noDW$r.squared, sumwindvtemp5_noDW$r.squared, sumwindvtemp10_noDW$r.squared, sumwindvtempair_noDW$r.squared, sumDWvtemp0$r.squared, sumDWvtemp5$r.squared, sumDWvtemp10$r.squared, sumDWvairtemp$r.squared, sumDWvtemp02$r.squared, sumDWvtemp52$r.squared, sumDWvtemp102$r.squared, sumDWvairtemp2$r.squared, sumDWvtemp03$r.squared, sumDWvtemp53$r.squared, sumDWvtemp103$r.squared, sumDWvairtemp3$r.squared, sumDWvtemp04$r.squared, sumDWvtemp54$r.squared, sumDWvtemp104$r.squared, sumDWvairtemp4$r.squared, sumDWvtemp0frac$r.squared, sumDWvtemp5frac$r.squared, sumDWvtemp10frac$r.squared, sumDWvairtempfrac$r.squared,sumradvtemp0$r.squared, sumradvtemp5$r.squared, sumradvtemp10$r.squared, sumradiationvtempair$r.squared, sumairvtemp0$r.squared, sumairvtemp5$r.squared, sumairvtemp10$r.squared, sumdwby50$r.squared,sumdwby60$r.squared, sumdwby70$r.squared, sumdwby80$r.squared, sumiswinterwarmingRDDWD50$r.squared)
sum_list <- data.frame(Intercept, slope, p_value, R_squared, Note, row.names = c("Freezing Degree Days Overtime (0cm)", "Freezing Degree Days Overtime (5cm)", "Freezing Degree Days Overtime (10cm)", "Freezing Degree Days Overtime (Airtemp)", "Freezing Degree Days Overtime DWDR (0cm)", "Freezing Degree Days Overtime DWDR (5cm)", "Freezing Degree Days Overtime DWDR (10cm)", "Freezing Degree Days Overtime DWDR (Airtemp)", "Radiation Days Overtime", "Wind Days Overtime", "Wind Days v Soil FDD (0cm)", "Wind Days v Soil FDD (5cm)", "Wind Days v Soil FDD (10cm)", "Wind Days v Air FDD", "Wind Days (DWDR) v Soil FDD (0cm)", "Wind Days (DWDR) v Soil FDD (5cm)", "Wind Days (DWDR) v Soil FDD (10cm)", "Wind Days (DWDR) v Air FDD", "Down-Valley Wind Day (50%) v Soil FDD (0cm)", "Down-Valley Wind Day (50%) v Soil FDD (5cm)", "Down-Valley Wind Day (50%) v Soil FDD (10cm)", "Down-Valley Wind Day (50%) v Air FDD", "Down-Valley Wind Day (60%) v Soil FDD (0cm)", "Down-Valley Wind Day (60%) v Soil FDD (5cm)", "Down-Valley Wind Day (60%) v Soil FDD (10cm)", "Down-Valley Wind Day (60%) v Air FDD", "Down-Valley Wind Day (70%) v Soil FDD (0cm)", "Down-Valley Wind Day (70%) v Soil FDD (5cm)", "Down-Valley Wind Day (70%) v Soil FDD (10cm)", "Down-Valley Wind Day (70%) v Air FDD", "Down-Valley Wind Day (80%) v Soil FDD (0cm)", "Down-Valley Wind Day (80%) v Soil FDD (5cm)", "Down-Valley Wind Day (80%) v Soil FDD (10cm)", "Down-Valley Wind Day (80%) v Air FDD", "Down-Valley Wind Day (frac) v Soil FDD (0cm)", "Down-Valley Wind Day (frac) v Soil FDD (5cm)", "Down-Valley Wind Day (frac) v Soil FDD (10cm)", "Down-Valley Wind Day (frac) v Air FDD", "LW Radiation v Soil FDD (0cm)", "LW Radiation v Soil FDD (5cm)", "LW Radiation v Soil FDD (10cm)", "LW Radiation v Air FDD", "Soil FDD v Air FDD (0cm)", "Soil FDD v Air FDD (5cm)", "Soil FDD v Air FDD (10cm)", "Number of Down-Valley Wind Days (50%)", "Number of Down-Valley Wind Days (60%)", "Number of Down-Valley Wind Days (70%)", "Number of Down-Valley Wind Days (80%)","Radiation v DWD50"))
write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warmingSummary.csv", row.names=TRUE)

if(location == "Lake Bonney"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeBonneySummary.csv", row.names=TRUE)
  LBsum_list <- sum_list
  
}
if(location == "Explorers Cove"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/ExplorersCoveSummary.csv", row.names=TRUE)
  ECsum_list <- sum_list
}
if(location == "Lake Brownworth"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeBrownworthSummary.csv", row.names=TRUE)
  LBrsum_list <- sum_list
}
if(location == "Lake Fryxell"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeFryxellSummary.csv", row.names=TRUE)
  LFsum_list <- sum_list
}
if(location == "Lake Hoare"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeHoareSummary.csv", row.names=TRUE)
  LHsum_list <- sum_list
}
if(location == "Lake Vanda"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeVandaSummary.csv", row.names=TRUE)
  LVasum_list <- sum_list
}
if(location == "Lake Vida"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeVidaSummary.csv", row.names=TRUE)
  LVisum_list <- sum_list
}
if(location == "Miers Valley"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/MiersValleySummary.csv", row.names=TRUE)
  MVsum_list <- sum_list
}
if(location == "Mount Fleming"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/MountFlemingSummary.csv", row.names=TRUE)
  MFsum_list <- sum_list
}
if(location == "Taylor Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/TaylorGlacierSummary.csv", row.names=TRUE)
  TGsum_list <- sum_list
}
if(location == "Canada Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/CanadaGlacierSummary.csv", row.names=TRUE)
  CaGsum_list <- sum_list
}
if(location == "Commonwealth Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/CommonwealthGlacierSummary.csv", row.names=TRUE)
  CoGsum_list <- sum_list
}
if(location == "Howard Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/HowardGlacierSummary.csv", row.names=TRUE)
  HGsum_list <- sum_list
}
if(location == "Friis Hills"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/FriisHillsSummary.csv", row.names=TRUE)
  FHsum_list <- sum_list
}
}
#summary table of graph statistic but for data that has no soil temperature
if(!soiltempcheck){
Note <- c("","","","","","","","","","","","","","","","","")

if(CoGnote){
  Note <- c("","","","CoG LW","","","","","","","","CoG LW","","","","","")
}
if(LBnote){
  Note <- c("","","LB LW","","","","","","","","","LB LW","","","","","")
}
Intercept <- c(iswinterwarmingFDDAir$coefficients[1], iswinterwarmingFDDAirnhwe$coefficients[1], iswinterwarmingRD$coefficients[1], iswinterwarmingWD$coefficients[1], windvtempair$coefficients[1], windvtempair_noDW$coefficients[1], DWvairtemp$coefficients[1], DWvairtemp2$coefficients[1], DWvairtemp3$coefficients[1], DWvairtemp4$coefficients[1], DWvairtempfrac$coefficients[1], radiationvtempair$coefficients[1],dwby50$coefficients[1],dwby60$coefficients[1], dwby70$coefficients[1], dwby80$coefficients[1],iswinterwarmingRDDWD50$coefficients[1])
slope <- c(iswinterwarmingFDDAir$coefficients[2], iswinterwarmingFDDAirnhwe$coefficients[2], iswinterwarmingRD$coefficients[2], iswinterwarmingWD$coefficients[2], windvtempair$coefficients[2], windvtempair_noDW$coefficients[2], DWvairtemp$coefficients[2], DWvairtemp2$coefficients[2], DWvairtemp3$coefficients[2], DWvairtemp4$coefficients[2], DWvairtempfrac$coefficients[2], radiationvtempair$coefficients[2],dwby50$coefficients[2],dwby60$coefficients[2], dwby70$coefficients[2], dwby80$coefficients[2], iswinterwarmingRDDWD50$coefficients[2])
p_value <- c(sumiswinterwarmingFDDAir$coefficients[8], sumiswinterwarmingFDDAirnhwe$coefficients[8], sumiswinterwarmingRD$coefficients[8], sumiswinterwarmingWD$coefficients[8], sumwindvtempair$coefficients[8], sumwindvtempair_noDW$coefficients[8], sumDWvairtemp$coefficients[8], sumDWvairtemp2$coefficients[8], sumDWvairtemp3$coefficients[8], sumDWvairtemp4$coefficients[8], sumDWvairtempfrac$coefficients[8], sumradiationvtempair$coefficients[8], sumdwby50$coefficients[8],sumdwby60$coefficients[8], sumdwby70$coefficients[8], sumdwby80$coefficients[8], sumiswinterwarmingRDDWD50$coefficients[8])
R_squared <- c(sumiswinterwarmingFDDAir$r.squared, sumiswinterwarmingFDDAirnhwe$r.squared, sumiswinterwarmingRD$r.squared, sumiswinterwarmingWD$r.squared, sumwindvtempair$r.squared, sumwindvtempair_noDW$r.squared, sumDWvairtemp$r.squared, sumDWvairtemp2$r.squared, sumDWvairtemp3$r.squared, sumDWvairtemp4$r.squared, sumDWvairtempfrac$r.squared, sumradiationvtempair$r.squared,sumdwby50$r.squared,sumdwby60$r.squared, sumdwby70$r.squared, sumdwby80$r.squared, sumiswinterwarmingRDDWD50$r.squared)
sum_list <- data.frame(Intercept, slope, p_value, R_squared, Note, row.names = c("Freezing Degree Days Overtime (Airtemp)", "Freezing Degree Days Overtime DWDR (Airtemp)", "Radiation Days Overtime", "Wind Days Overtime", "Wind Days v Air FDD", "Wind Days (DWDR) v Air FDD", "Down-Valley Wind Day (50%) v Air FDD", "Down-Valley Wind Day (60%) v Air FDD", "Down-Valley Wind Day (70%) v Air FDD", "Down-Valley Wind Day (80%) v Air FDD", "Down-Valley Wind Day (frac) v Air FDD", "LW Radiation v Air FDD", "Number of Down-Valley Wind Days (50%)", "Number of Down-Valley Wind Days (60%)", "Number of Down-Valley Wind Days (70%)", "Number of Down-Valley Wind Days (80%)","Radiation v DWD50"))

if(location == "Lake Bonney"){
write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeBonneySummary.csv", row.names=TRUE)
LBsum_list <- sum_list
}
if(location == "Explorers Cove"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/ExplorersCoveSummary.csv", row.names=TRUE)
  ECsum_list <- sum_list
  }
if(location == "Lake Brownworth"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeBrownworthSummary.csv", row.names=TRUE)
  LBrsum_list <- sum_list
  }
if(location == "Lake Fryxell"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeFryxellSummary.csv", row.names=TRUE)
  LFsum_list <- sum_list
  }
if(location == "Lake Hoare"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeHoareSummary.csv", row.names=TRUE)
  LHsum_list <- sum_list
  }
if(location == "Lake Vanda"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeVandaSummary.csv", row.names=TRUE)
  LVasum_list <- sum_list
  }
if(location == "Lake Vida"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/LakeVidaSummary.csv", row.names=TRUE)
  LVisum_list <- sum_list
  }
if(location == "Miers Valley"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/MiersValleySummary.csv", row.names=TRUE)
  MVsum_list <- sum_list
  }
if(location == "Mount Fleming"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/MountFlemingSummary.csv", row.names=TRUE)
  MFsum_list <- sum_list
  }
if(location == "Taylor Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/TaylorGlacierSummary.csv", row.names=TRUE)
  TGsum_list <- sum_list
  }
if(location == "Canada Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/CanadaGlacierSummary.csv", row.names=TRUE)
  CaGsum_list <- sum_list
  }
if(location == "Commonwealth Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/CommonwealthGlacierSummary.csv", row.names=TRUE)
  CoGsum_list <- sum_list
  }
if(location == "Howard Glacier"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/HowardGlacierSummary.csv", row.names=TRUE)
  HGsum_list <- sum_list
  }
if(location == "Friis Hills"){
  write.csv(sum_list, "~/Dropbox/r_projects/mdv_winter_warming/FriisHillsSummary.csv", row.names=TRUE)
  FHsum_list <- sum_list
  }
}
dev.off()
}

#Need to make a pretty summary of all stuff

airpvalueslist <- c(FHsum_list$p_value[1], HGsum_list$p_value[1], CoGsum_list$p_value[1], CaGsum_list$p_value[1], TGsum_list$p_value[1], MFsum_list$p_value[1], MVsum_list$p_value[1], LVisum_list$p_value[4], LVasum_list$p_value[4], LHsum_list$p_value[4], LFsum_list$p_value[4], LBrsum_list$p_value[4], ECsum_list$p_value[4], LBsum_list$p_value[4])
airpvalueslist <- rev(airpvalueslist)
airslopelist <- c(FHsum_list$slope[1], HGsum_list$slope[1], CoGsum_list$slope[1], CaGsum_list$slope[1], TGsum_list$slope[1], MFsum_list$slope[1], MVsum_list$slope[1], LVisum_list$slope[4], LVasum_list$slope[4], LHsum_list$slope[4], LFsum_list$slope[4], LBrsum_list$slope[4], ECsum_list$slope[4], LBsum_list$slope[4])
airslopelist <- rev(airslopelist)
airinterceptlist <- c(FHsum_list$Intercept[1], HGsum_list$Intercept[1], CoGsum_list$Intercept[1], CaGsum_list$Intercept[1], TGsum_list$Intercept[1], MFsum_list$Intercept[1], MVsum_list$Intercept[1], LVisum_list$Intercept[4], LVasum_list$Intercept[4], LHsum_list$Intercept[4], LFsum_list$Intercept[4], LBrsum_list$Intercept[4], ECsum_list$Intercept[4], LBsum_list$Intercept[4])
airinterceptlist <- rev(airinterceptlist)
airRlist <- c(FHsum_list$R_squared[1], HGsum_list$R_squared[1], CoGsum_list$R_squared[1], CaGsum_list$R_squared[1], TGsum_list$R_squared[1], MFsum_list$R_squared[1], MVsum_list$R_squared[1], LVisum_list$R_squared[4], LVasum_list$R_squared[4], LHsum_list$R_squared[4], LFsum_list$R_squared[4], LBrsum_list$R_squared[4], ECsum_list$R_squared[4], LBsum_list$R_squared[4])
airRlist <- rev(airRlist)
airsummarysumlist <- data.frame(airinterceptlist, airslopelist, airpvalueslist, airRlist, row.names = c("Lake Bonney", "Explorers Cove", "Lake Brownworth", "Lake Fryxell", "Lake Hoare", "Lake Vanda", "Lake Vida", "Miers Valley", "Mount Fleming", "Taylor Glacier", "Canada Glacier", "Commonwealth Glacier", "Howard Glacier",  "Friis Hills"))
airsummarysumlist$nofreezing <- -airsummarysumlist$airinterceptlist/airsummarysumlist$airslopelist
