# some shared values accross markdown pages
# quotes:
# > Goed geïnformeerd is het beste vaccin
# > The implication is that PCR positives lack predictive power in terms of telling whether people will die in the future.

setwd("~/Documents/wetenschap/covid-19/infosheets")

life_expectancy = 81
Pot_HLY = 63.5 #https://ec.europa.eu/eurostat/statistics-explained/index.php/Healthy_life_years_statistics#Healthy_life_years_at_birth

population_be = 11431406
pop_18older=9126019
pop_16older = 9429333
pop_15older=9498304
pop_18_24 = 925458

prop_depr = 0.094
depr = prop_depr * pop_16older
depr
C_Enq_3_pop = pop_18older # https://www.sciensano.be/en/biblio/derde-covid-19-gezondheidsenquete-eerste-resultaten
DALY_allcause = 3193582 # http://ghdx.healthdata.org/gbd-results-tool


# Anders Tegnell https://www.youtube.com/watch?v=xh9wso6bEAc
IFR_low = 0.1 
IFR_high = 0.5 

# Ioannidis < 70 median https://doi.org/10.1101/2020.05.13.20101253
IFR_70_younger = 0.04
# De gewone griep schat men IFR op 0,04 - 0,1% (https://www.medrxiv.org/content/10.1101/2020.05.13.20101253v3)

Sero_Prev_BE = 14.4 # https://www.standaard.be/cnt/dmf20201230_93874528 

wisdoms = c("We kennen 1,5 meter als een veilige persoonlijke ruimte. Waarom dan steeds herhalen wat evident is?")
