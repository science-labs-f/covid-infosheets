# YLL literature:
# Valuing the years of life lost due to COVID-19: the differences and pitfalls: https://link.springer.com/article/10.1007/s00038-020-01430-2
# PHLY: https://ec.europa.eu/eurostat/statistics-explained/index.php/Healthy_life_years_statistics#Healthy_life_years_at_birth
# GBD reference life table: http://ghdx.healthdata.org/record/global-burden-disease-study-2017-gbd-2017-reference-life-table
# Burden of disease methods: a guide to calculate COVID-19 disability-adjusted life years: https://osf.io/preprints/socarxiv/tazyh/
# Details on the GBD relational model life table with a flexible standard life table selection process (see section 2): https://www.thelancet.com/cms/10.1016/S0140-6736(20)30925-9/attachment/deb36c39-0e91-4057-9594-cc60654cf57f/mmc1.pdf
#   
# covid deaths
# calculatie met Belgische sterftetafel: https://statbel.fgov.be/sites/default/files/files/documents/bevolking/5.4%20Sterfte%2C%20levensverwachting%20en%20doodsoorzaken/5.4.3%20Sterftetafels%20en%20levensverwachting/sterftetafelsAR.xls

population_be <- 11431406
life_exp_be <- 82
HLY_limit <- 63.5 #https://ec.europa.eu/eurostat/statistics-explained/index.php/Healthy_life_years_statistics#Healthy_life_years_at_birth

d <- read.csv('https://epistat.sciensano.be/Data/COVID19BE_MORT.csv')
# correct for stable reporting
d <- d[which(as.Date(d$DATE)  < (Sys.Date()-4)) , ]

d_agg <- aggregate(x = d$DEATHS, FUN = sum, by = list(agegroup = d$AGEGROUP))

median_ages <- c(12, 35, 55, 70, 80, 85)
YLL_ages <- c(69.71, 47.17, 28.40, 16.08, 9.21, 6.39)
HLY_ages <- c(51.5, 28.5, 8.5, 0, 0, 0)

d_agg$median <- median_ages
d_agg$yll <- YLL_ages
d_agg$hly <- HLY_ages
covid_YLL <- 0
covid_HLYL <- 0
deaths = 0

for (row in 1:nrow(d_agg)) {
  
  deaths <- d_agg[row, "x"]
  
  med_age <- d_agg[row, "median"]
  yll_age <- d_agg[row, "yll"]
  hly_age <- d_agg[row, "hly"]
  YLL <- yll_age  * deaths
  HLYL <- 0
  if(hly_age > 0){
    HLYL <- hly_age  * deaths
  } 
    
  covid_YLL = covid_YLL + YLL
  covid_HLYL = covid_HLYL + HLYL
  print(med_age)
  print(YLL)
  print(HLYL)
  
  if(YLL > 0) {
    print("YLL found!")
  }
  
  deaths = deaths + deaths
}

covid_YLL <- round(covid_YLL, 0)
covid_HLYL <- round(covid_HLYL, 0)

covid_deaths <- deaths
covid_deaths_rel <- round(covid_deaths / population_be * 100, 3)

#YLL calcs, this study fir Italy showd YLD is marginal so YLL used # https://www.mdpi.com/1660-4601/17/12/4233/htm