## correct age groups
to_correct <- c('0-24', '25-44', '45-64')
corrected <- c('0-14', '15-24', '25-34', '35-44', '45-54', '55-64')
d_match <- data.frame(to_correct, corrected)

# get current correct age groups 
d_new <- d_agg
for (i in to_correct){
  d_new <- d_new[!(d_new$agegroup==i),]  
}

j=1
for (i in to_correct){
  if (d_agg$agegroup==i) {
    val = d_agg$x
    val1 = round(val*1/3, 0)
    val2 = round(val*2/3, 0)
    d_new <- d_new %>% add_row(agegroup=corrected[j], x=val1)
    d_new <- d_new %>% add_row(agegroup=corrected[j+1], x=val2)
  }
  j=j+2
}