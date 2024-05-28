###caclculates soil summer (Nov-Feb) TDD gross and net in soils

library(lubridate)
library(tidyverse)

setwd("~/Dropbox/r_projects/mdv_winter_warming")

locations <- c("Lake Bonney", "Explorers Cove", "Lake Brownworth", "Lake Fryxell", "Lake Hoare", "Lake Vanda", "Lake Vida")

for(location in locations){

##Bonney Starts Here
  
  if(location == "Lake Bonney"){
    
soilt <- read.csv("https://mcm.lternet.edu/file/7177/download?token=b7mfxKFGbemrqCh-_DpfBdMzsZDljEqExO1XzXkIhM0")

soilt <- soilt[,c("date_time","avg_soilt0cm")]

soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")

soilt$month <- month(soilt$date)
soilt$year <- year(soilt$date)

years <- unique(soilt$year)

### loop to get net TDD by year

netTDD_log <- data.frame(year=double(),
                        nov=double(),
                        dec=double(),
                        jan=double(),
                        feb=double(),
                        stringsAsFactors=FALSE) 

grossTDDlog <- data.frame(year=double(),
                          nov=double(),
                          dec=double(),
                          jan=double(),
                          feb=double(),
                          stringsAsFactors=FALSE) 
#loop 

for(i in years){

thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]

thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)

if(nrow(thissummer)>108){
  thissummertdd <- data.frame(year=i,
                                   nov=sum(thisyearnov$avg_soilt0cm),
                                   dec=sum(thisyeardec$avg_soilt0cm),
                                   jan=sum(thisyearjan$avg_soilt0cm),
                                   feb=sum(thisyearfeb$avg_soilt0cm),
                                   stringsAsFactors=FALSE)
  }

if(nrow(thissummer)<108){
  thissummertdd <- data.frame(year=i,
                              nov=-9999,
                              dec=-9999,
                              jan=-9999,
                              feb=-9999,
                              stringsAsFactors=FALSE)
}

netTDD_log <- rbind(netTDD_log,thissummertdd)

#makes gross TDD data 

thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)

thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)

thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)

thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)

if(nrow(thissummer)>108){
  thissummergtdd <- data.frame(year=i,
                              nov=sum(thisyearnov$avg_soilt0cmg),
                              dec=sum(thisyeardec$avg_soilt0cmg),
                              jan=sum(thisyearjan$avg_soilt0cmg),
                              feb=sum(thisyearfeb$avg_soilt0cmg),
                              stringsAsFactors=FALSE)
}

if(nrow(thissummer)<108){
  thissummergtdd <- data.frame(year=i,
                              nov=-9999,
                              dec=-9999,
                              jan=-9999,
                              feb=-9999,
                              stringsAsFactors=FALSE)
}

grossTDDlog <- rbind(grossTDDlog,thissummergtdd)

}
####once that loops is done

grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb

netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb

netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]

netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]

netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)

pdf("bonneyTDD.pdf")
plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Bonney Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
abline(grossTDDlm,lty = 3, lwd = 2)
dev.off()

gross_coeffs <- summary(grossTDDlm)
net_coeffs <- summary(netTDDlm)

gslope <- gross_coeffs$coefficients[2,1]
gpval <- gross_coeffs$coefficients[2,4]
gr2 <- gross_coeffs$adj.r.squared

nslope <- net_coeffs$coefficients[2,1]
npval <- net_coeffs$coefficients[2,4]
nr2 <- net_coeffs$adj.r.squared

bonney_stats <- data.frame(gslope=gslope,
                           gpval=gpval,
                           gr2=gr2,
                           nslope=nslope,
                           npval=npval,
                           nr2=nr2,
                           stringsAsFactors=FALSE)
write.csv(bonney_stats,"bonney_tdd_stats.csv")
  }
  
  ##Explorer's Cove Starts Here
  
  if(location == "Explorers Cove"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7339/download?token=VgQeVTq9B3BL-6-aXoNg0KGUekQxFHtYtifcxwS-iBE")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("excoveTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Explorer's Cove Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    excove_stats <- data.frame(gslope=gslope,
                               gpval=gpval,
                               gr2=gr2,
                               nslope=nslope,
                               npval=npval,
                               nr2=nr2,
                               stringsAsFactors=FALSE)
    write.csv(excove_stats,"excove_tdd_stats.csv")
  }

  ##Lake Brownworth Starts Here
  
  if(location == "Lake Brownworth"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7277/download?token=B13OUIw83k4_edrd9bYkNTkIeTkYVztQPW8-6SWXrZ8")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("brownworthTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Brownworth Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    brownworth_stats <- data.frame(gslope=gslope,
                               gpval=gpval,
                               gr2=gr2,
                               nslope=nslope,
                               npval=npval,
                               nr2=nr2,
                               stringsAsFactors=FALSE)
    write.csv(brownworth_stats,"brownworth_tdd_stats.csv")
  } 
  
  ##Lake Fryxell Starts Here
  
  if(location == "Lake Fryxell"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7197/download?token=kcZUMMlsteUY_Hn9R6tgPAPCVa-snmjgn_05LuMylYk")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("fryxellTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Fryxell Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    fryx_stats <- data.frame(gslope=gslope,
                                   gpval=gpval,
                                   gr2=gr2,
                                   nslope=nslope,
                                   npval=npval,
                                   nr2=nr2,
                                   stringsAsFactors=FALSE)
    write.csv(fryx_stats,"fryx_tdd_stats.csv")
  } 
  
  ##Lake Hoare Starts Here
  
  if(location == "Lake Hoare"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7234/download?token=D8r5BUTFgyjKS993bSDxQ_Pw4OevMGCEKzkwOSLFWto")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("hoareTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Hoare Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    hoare_stats <- data.frame(gslope=gslope,
                             gpval=gpval,
                             gr2=gr2,
                             nslope=nslope,
                             npval=npval,
                             nr2=nr2,
                             stringsAsFactors=FALSE)
    write.csv(hoare_stats,"hoare_tdd_stats.csv")
  } 

  ##Lake Vanda Starts Here
  
  if(location == "Lake Vanda"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7259/download?token=YtfzqUsXNnaeAQAsfeK4tVNu_neXYbGWjkr-soykd3s")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("vandaTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Vanda Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    vanda_stats <- data.frame(gslope=gslope,
                              gpval=gpval,
                              gr2=gr2,
                              nslope=nslope,
                              npval=npval,
                              nr2=nr2,
                              stringsAsFactors=FALSE)
    write.csv(vanda_stats,"vanda_tdd_stats.csv")
  } 
  
  ##Lake Vida Starts Here
  
  if(location == "Lake Vida"){
    
    soilt <- read.csv("https://mcm.lternet.edu/file/7419/download?token=pO0dcBWltpBTkET0yZwFDZ26PkP6ivmv_7g5tr0HBt8")
    
    soilt <- soilt[,c("date_time","avg_soilt0cm")]
    
    soilt$date <- as.Date(soilt$date_time,format = "%m/%d/%y")
    
    soilt$month <- month(soilt$date)
    soilt$year <- year(soilt$date)
    
    years <- unique(soilt$year)
    
    ### loop to get net TDD by year
    
    netTDD_log <- data.frame(year=double(),
                             nov=double(),
                             dec=double(),
                             jan=double(),
                             feb=double(),
                             stringsAsFactors=FALSE) 
    
    grossTDDlog <- data.frame(year=double(),
                              nov=double(),
                              dec=double(),
                              jan=double(),
                              feb=double(),
                              stringsAsFactors=FALSE) 
    #loop 
    
    for(i in years){
      
      thisyearnov <- soilt[soilt$year==i & soilt$month==11, ]
      thisyeardec <- soilt[soilt$year==i & soilt$month==12, ]
      thisyearjan <- soilt[soilt$year==i+1 & soilt$month==1, ]
      thisyearfeb <- soilt[soilt$year==i+1 & soilt$month==2, ]
      
      thissummer <- rbind(thisyearnov,thisyeardec,thisyearjan,thisyearfeb)
      
      if(nrow(thissummer)>108){
        thissummertdd <- data.frame(year=i,
                                    nov=sum(thisyearnov$avg_soilt0cm),
                                    dec=sum(thisyeardec$avg_soilt0cm),
                                    jan=sum(thisyearjan$avg_soilt0cm),
                                    feb=sum(thisyearfeb$avg_soilt0cm),
                                    stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummertdd <- data.frame(year=i,
                                    nov=-9999,
                                    dec=-9999,
                                    jan=-9999,
                                    feb=-9999,
                                    stringsAsFactors=FALSE)
      }
      
      netTDD_log <- rbind(netTDD_log,thissummertdd)
      
      #makes gross TDD data 
      
      thisyearnov$avg_soilt0cmg <- ifelse(thisyearnov$avg_soilt0cm>0,thisyearnov$avg_soilt0cm,0)
      
      thisyeardec$avg_soilt0cmg <- ifelse(thisyeardec$avg_soilt0cm>0,thisyeardec$avg_soilt0cm,0)
      
      thisyearjan$avg_soilt0cmg <- ifelse(thisyearjan$avg_soilt0cm>0,thisyearjan$avg_soilt0cm,0)
      
      thisyearfeb$avg_soilt0cmg <- ifelse(thisyearfeb$avg_soilt0cm>0,thisyearfeb$avg_soilt0cm,0)
      
      if(nrow(thissummer)>108){
        thissummergtdd <- data.frame(year=i,
                                     nov=sum(thisyearnov$avg_soilt0cmg),
                                     dec=sum(thisyeardec$avg_soilt0cmg),
                                     jan=sum(thisyearjan$avg_soilt0cmg),
                                     feb=sum(thisyearfeb$avg_soilt0cmg),
                                     stringsAsFactors=FALSE)
      }
      
      if(nrow(thissummer)<108){
        thissummergtdd <- data.frame(year=i,
                                     nov=-9999,
                                     dec=-9999,
                                     jan=-9999,
                                     feb=-9999,
                                     stringsAsFactors=FALSE)
      }
      
      grossTDDlog <- rbind(grossTDDlog,thissummergtdd)
      
    }
    ####once that loops is done
    
    grossTDDlog$gTDD <- grossTDDlog$nov+grossTDDlog$dec+grossTDDlog$jan+grossTDDlog$feb
    
    netTDD_log$nTDD <- netTDD_log$nov+netTDD_log$dec+netTDD_log$jan+netTDD_log$feb
    
    netTDD_log <- netTDD_log[complete.cases(netTDD_log),]
    grossTDDlog <- grossTDDlog[complete.cases(grossTDDlog),]
    
    netTDD_log <- netTDD_log[netTDD_log$nTDD>-39996,]
    grossTDDlog <- grossTDDlog[grossTDDlog$gTDD>-39996,]
    
    netTDDlm <- lm(netTDD_log$nTDD~netTDD_log$year)
    grossTDDlm <- lm(grossTDDlog$gTDD~grossTDDlog$year)
    
    pdf("vidaTDD.pdf")
    plot(grossTDDlog$gTDD~grossTDDlog$year, pch = 20, xlab = "Year", ylab = "TDD (Gross and Net)", main = "Lake Vida Thawing Degree Days",xlim = c(1993,2023), ylim = c(min(netTDD_log$nTDD),max(grossTDDlog$gTDD)))
    points(netTDD_log$nTDD~netTDD_log$year, pch = 20, col = "gray")
    legend('bottomright', legend = c("Gross TDD", "Net TDD"), col = c("black","gray"), pch = 20, bty = "n")
    abline(netTDDlm, lty = 3, lwd = 2, col = "gray")
    abline(grossTDDlm,lty = 3, lwd = 2)
    dev.off()
    
    gross_coeffs <- summary(grossTDDlm)
    net_coeffs <- summary(netTDDlm)
    
    gslope <- gross_coeffs$coefficients[2,1]
    gpval <- gross_coeffs$coefficients[2,4]
    gr2 <- gross_coeffs$adj.r.squared
    
    nslope <- net_coeffs$coefficients[2,1]
    npval <- net_coeffs$coefficients[2,4]
    nr2 <- net_coeffs$adj.r.squared
    
    vida_stats <- data.frame(gslope=gslope,
                              gpval=gpval,
                              gr2=gr2,
                              nslope=nslope,
                              npval=npval,
                              nr2=nr2,
                              stringsAsFactors=FALSE)
    write.csv(vida_stats,"vida_tdd_stats.csv")
  } 

    
}

