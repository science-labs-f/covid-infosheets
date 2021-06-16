# create plot that show the daily new DALYs for covid and suicidality, and suicide
library(dplyr)
library(ggplot2)

#import latest deaths data
d <- read.csv('https://epistat.sciensano.be/Data/COVID19BE_MORT.csv')
# correct for stable reporting
d <- d[which(as.Date(d$DATE)  < (Sys.Date()-4)) , ]
d['date'] = as.Date(d$DATE)
reporting_startdate <- min(d$date)
reporting_enddate <- max(d$date)
reporting_days =as.numeric(difftime(reporting_enddate, reporting_startdate, units = "days"))    

agegroups = c("85+", "75-84", "65-74", "45-64","25-44", "0-24")

get_table_by_agegroup <- function(d, agegroup) {
  
  df <- d[which( d$AGEGROUP == agegroup) , ]
  df_agg <- aggregate(x = df$DEATHS, FUN = sum, by = list(date = df$date))
  return (df_agg)
}

#get deaths by agegroup
d_0_24 <- get_table_by_agegroup(d, agegroups[6])
d_25_44 <- get_table_by_agegroup(d, agegroups[5])
d_45_64 <- get_table_by_agegroup(d, agegroups[4])
d_65_74 <- get_table_by_agegroup(d, agegroups[3])
d_75_84 <- get_table_by_agegroup(d, agegroups[2])
d_85_ <- get_table_by_agegroup(d, agegroups[1])

#7 day avg to improve graph reading
make_7_day_avg <- function(d_7, column_name) {
  
  #validate first that each set has a value for every date
  d_7['date'] = as.Date(d_7$date)
  startdate <- reporting_startdate

  exp_date = startdate + 1
  obs_date = d_7[which( d_7$date == exp_date) , ]
  j=0
  
  for (i in 1:reporting_days) {
    if (nrow(obs_date) == 0) {
      # date missing, so create new one with value 0
      d_7[nrow(d_7) + 1, 1] = exp_date
      d_7[nrow(d_7) , 2] = 0
      j=j+1 
    }
    
    exp_date = exp_date + 1
    obs_date = d_7[which( d_7$date == exp_date) , ]
    
  }
  
  print(j)
  
  # calc 7 day avgs
  d_7['date'] = as.Date(d_7$date)
  startdate <- min(d_7$date)
  date_to_avg <- startdate + 7
  days_to_avg <- nrow(d_7) - 7
  
  df <- data.frame("2020-01-01", '0')
  names(df) <- c("date", 'x')
  df$date = as.Date(df$date, origin="1970-01-01")
  df$x = as.integer(df$x)
  
  lowerdate = startdate
  upperdate = date_to_avg
  
  for (i in 1:days_to_avg) {
    row = d_7[which( d_7$date > lowerdate & d_7$date <= upperdate) , ]
    daily_avg = round(sum(row$x) / 7, 1)
    rm(row)
    
    df[nrow(df) + 1, 1] = upperdate
    df[nrow(df) , 2] = daily_avg
    
    lowerdate <- lowerdate + 1
    upperdate <- upperdate + 1
  }
  
  # name new dataset column
  names(df)[names(df)=="x"] <- column_name
  # truncate
  df <- df[df$date >= startdate, ]
  
  return(df)
  
}

d_0_24 <- make_7_day_avg(d_0_24, paste ("A_", agegroups[6], sep = ""))
d_25_44 <- make_7_day_avg(d_25_44, paste ("A_", agegroups[5], sep = ""))
d_45_64 <- make_7_day_avg(d_45_64, paste ("A_", agegroups[4], sep = ""))
d_65_74 <- make_7_day_avg(d_65_74, paste ("A_", agegroups[3], sep = ""))
d_75_84 <- make_7_day_avg(d_75_84, paste ("A_", agegroups[2], sep = ""))
d_85_ <- make_7_day_avg(d_85_, paste ("A_", agegroups[1], sep = ""))

# calculate YLL
# ‘standard’’ life table, suggested by https://link.springer.com/content/pdf/10.1007%2Fs00038-020-01430-2.pdf

