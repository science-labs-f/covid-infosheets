# tests ten opzicht van cases

library(ISOweek)

d_t <- read.csv("https://epistat.sciensano.be/Data/COVID19BE_tests.csv")

d_t['date'] = as.Date(d_t$DATE)
d_t['week'] = ISOweek(d_t$date)

## get from begin June 
# d <- d_t[d_t$date >= "2020-06-01",]

## get from anytime
d<- d_t

d_t_wk <- aggregate(x= d$TESTS, FUN = sum,
                    by = list(week = d$week))
names(d_t_wk)[names(d_t_wk)=="x"] <- "sum.test"

barplot(d_t_wk$sum.test, names.arg = d_t_wk$week, cex.names = 0.6, border="red",density=0)
#abline(lm(d$TESTS ~ d$date), col="blue", lty=3, lwd=2)


# get cases
d_c <- read.csv("https://epistat.sciensano.be/Data/COVID19BE_CASES_AGESEX.csv")
d_c['date'] = as.Date(d_c$DATE)
agg_c <-aggregate(x=d_c$CASES, FUN=sum, by = list(date = d_c$DATE))
agg_c['week'] = ISOweek(agg_c$date)
names(agg_c)[names(agg_c)=="x"] <- "sum.date"
agg_c['date'] = as.Date(agg_c$date)

#get from 1/6
#d_c <- agg_c[agg_c$date >= "2020-06-01",]

# get anytime
d_c <- agg_c

#aggreg by weeknr
d_c_wk <- aggregate(x= d_c$sum.date, FUN = sum,
                    by = list(week = d_c$week))
names(d_c_wk)[names(d_c_wk)=="x"] <- "sum.cases"

d <- left_join(d_t_wk, d_c_wk, by=c("week"))
d['pos'] = d$sum.cases/d$sum.test
barplot(d$pos, names.arg = d$week, cex.names = 0.6, border="red",density=0)