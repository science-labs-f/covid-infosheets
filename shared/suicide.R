# report 3: https://www.sciensano.be/en/biblio/derde-covid-19-gezondheidsenquete-eerste-resultaten
# report 4: http://covid-19.sciensano.be/sites/default/files/Covid19/Report4_COVID_19HIS_NL_1.pdf
# report 6: https://www.sciensano.be/nl/biblio/zesde-covid-19-gezondheidsenquete-eerste-resultaten

population_be = 11431406
pop_18older=9126019
pop_15older=9498304
pop_18_29 = 1664927
months_surveyed =12

prop_suicatt_2018<-0.002 # https://his.wiv-isp.be/nl/Gedeelde%20%20documenten/MH_NL_2018.pdf
prop_suicatt <- 0.006 # p40 report 6 Sciensano

suicatt <- round(pop_18older*prop_suicatt, 0) 
suicatt_2018 <- round((pop_15older*prop_suicatt_2018), 0) 
suicatt_2018_corr <- round(suicatt_2018/12*months_surveyed, 0) 
suicatt_2018_corr_rel <- round(suicatt_2018_corr/pop_15older*100, 2)

suicatt_ratio <-round(suicatt/suicatt_2018_corr, 0)

# p 41 mannen 2.3% vrouwen 1.1%, we nemen avg
prop_suicatt_18_29_men <- 0.023
prop_suicatt_18_29_women <- 0.011
prop_suicatt_18_29 <- (prop_suicatt_18_29_men + prop_suicatt_18_29_women) / 2
suicatt_18_29 = round(prop_suicatt_18_29*pop_18_29, 0)

suicatt_18_29_ratio = round(suicatt_18_29 / suicatt * 100, 1)

YLD_suicatt_low = 1905
YLD_suicatt_high = 3715

# https://www.who.int/healthinfo/global_burden_disease/metrics_daly/en/
# YLD = Number of prevalent cases * Disease Weigth 
# DW is 0.46 (SD = 0.13; 95% CI 0.20; 0.72)  -> https://www.sciencedirect.com/science/article/pii/S0165032711002667
DW_suicatt = 0.46
YLD_suicatt_impact <-   ceiling( (suicatt * DW_suicatt ) - (suicatt_2018_corr*DW_suicatt) )

# estimated suicide 
suic_2017 = 1723 
suic_2017_corr = round( suic_2017 / 12 * months_surveyed, 0)
suic_2017_corr_rel <- round( suic_2017_corr / population_be * 100, 3)
suicatt_with_death_ratio <- round(suic_2017/suicatt_2018*100, 1)
suic_2017_daily <- round( suic_2017 / 365, 1)

pred_suicatt_succes <- round(suicatt*suicatt_with_death_ratio/100, 0)

pred_suicatt_succes_daily <- round(pred_suicatt_succes/(months_surveyed*30),0)
pred_suicatt_succes_rel <- round( pred_suicatt_succes / pop_18older *100, 3 )

#impact
extra_suic <- pred_suicatt_succes - suic_2017

DALY_suic_low <- 68451
DALY_suic_high <- 79427

DALY_suic_impact_low <- ceiling ( ( (DALY_suic_low/suic_2017) * pred_suicatt_succes) - DALY_suic_low )
DALY_suic_impact_high <- ceiling ( ( (DALY_suic_high/suic_2017) * pred_suicatt_succes) - DALY_suic_high )

if (DALY_suic_impact_low < 0) DALY_suic_impact_low = 0
