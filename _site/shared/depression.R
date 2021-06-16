# depression

pop_18older=9126019

prop_depr_2018=0.095
prop_depr=0.22 # 6the report from sciensano (April 2021 data) https://www.sciensano.be/nl/biblio/zesde-covid-19-gezondheidsenquete-eerste-resultaten

depr =  pop_18older * prop_depr
not_depr = pop_18older - depr

prop_depr_increase <- prop_depr - prop_depr_2018
depr_increase <- pop_18older*prop_depr_increase

depr_2018 <- prop_depr_2018 * pop_18older

DALY_depr_lower_ref <- 57766
DALY_depr_upper_ref <- 109981

DALY_depr_lower <- ceiling( (DALY_depr_lower_ref / depr_2018) * depr )
DALY_depr_upper <- ceiling( (DALY_depr_upper_ref / depr_2018) * depr )
DALY_depr_impact_low = DALY_depr_lower - DALY_depr_lower_ref
DALY_depr_impact_high = DALY_depr_upper - DALY_depr_upper_ref

# TODO # correct for sens / spec PHQ-9 see:

# # correct for sens / spec PHQ-9 see: https://www.bmj.com/content/365/bmj.l1476
# prop_true_depr_low = 0.565
# prop_true_depr_high = 0.684
# prop_true_not_depr_low = 0.945
# prop_true_not_depr_high = 0.975
# 
# #corrected estimates -> how?
# depr_low = prop_true_depr_low * depr
# depr_high = prop_true_depr_high * depr
# not_depr_low = prop_true_not_depr_low * not_depr
# not_depr_high = prop_true_not_depr_high * not_depr
