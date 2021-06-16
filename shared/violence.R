#interpersoanl violence
#verbaal, fysiek als psychisch, ook ten aanzien van kinderen kindermishandeling, partnergeweld en oudermishandeling

population_be = 11431406
pop_15older=9498304
pop_younger_15 = population_be - pop_15older


p_dir_violence = 0.035 # direct repeated violence
dir_violence_abs <- ceiling(p_dir_violence * pop_16older)

p_serious_child_abuse = 0.03
val_serious_child_abuse = ceiling(pop_younger_15 * p_serious_child_abuse)

# child abuse, Stroobants, http://docs.vlaamsparlement.be/pfile?id=1606759
# nr_young = population_be - pop_18older
# ca_low = nr_young * 0.1
# ca_up = nr_young * 0.15
# sca = nr_young *0.03