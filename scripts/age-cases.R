# evolution of age of cases

d <- read.csv("https://epistat.sciensano.be/Data/COVID19BE_CASES_AGESEX.csv")

##agregate on data
agg_d <- aggregate(x = d$CASES, FUN = sum,
                   by = list(groupdate = d$DATE, group.age = d$AGEGROUP))
names(agg_d)[names(agg_d)=="x"] <- "cases"

# create new table with media ages per age group 
group.age <- c("0-9",	"10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79","80-89","90+")
median.age <- c(4.5, 14.5, 24.5, 34.5, 44.5, 54.5, 64.5, 74.5, 84.5, 90)
d2 <- data.frame(group.age, median.age)

# merge two tables

d_j <- left_join(agg_d, d2, by=c("group.age"))

#sum median_ages

for (row in 1:nrow(d_j)) {
  d_j["age.sum"] = d_j$cases * d_j$median.age
}

d <- d_j
agg_d_c <- aggregate(x= d$cases, FUN = sum,
                     by = list(groupdate = d$groupdate))
names(agg_d_c)[names(agg_d_c)=="x"] <- "sum.cases"
agg_d_a <- aggregate(x= d$age.sum, FUN = sum,
                     by = list(groupdate = d$groupdate))
names(agg_d_a)[names(agg_d_a)=="x"] <- "sum.ages"
d <- left_join(agg_d_a, agg_d_c, by=c("groupdate"))

# calculate mean ages

for (row in 1:nrow(d)) {
  d['mean.age'] = d$sum.ages/d$sum.cases
  betterDate <- as.Date(d$groupdate)
  d['betterDate'] = betterDate
  d['date'] = format(betterDate, "%d/%m" )
}

# to be able to do regression for dates, express dates as days since startdate
startdate = min(d$betterDate)

for (row in 1:nrow(d)){
  d['days_diff'] = (d$betterDate - startdate)
}

barplot(d$mean.age, names.arg = d$date, main="De gemiddelde leeftijd van COVID-19 cases 
        gedurende de pandemie in België", ylab= "Gemiddelde leeftijd cases", ylim=c(0, 80)  , cex.names = 0.6)
abline(lm(d$mean.age ~d$days_diff, na.action=na.exclude), col="blue", lty=3, lwd=2)
