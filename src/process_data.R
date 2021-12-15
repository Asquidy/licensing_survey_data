### This code gives an example calculation from the survey to calculate the distribution of prices for transactions initiated via a common digital platform.
library(data.table)

data <- fread('../data/p4f6_OCL_Survey_Prodege_Full_20190312_0604.csv')
data <- data[Flag_Any==0]
data[, mean(Q6_FindProvider %like% 'friend')]

data[, platform := ifelse(Q6_FindProvider %like% "Yelp" | 
                             Q6_FindProvider %like% "Angie's List" | 
                             Q6_FindProvider %like% "HomeAdvisor" | 
                             Q6_FindProvider %like% "Thumbtack", 
                           1, 0)]
data[, common_platform := as.numeric(Q6_FindProvider %like% c('HomeAdvisor|Thumbtack|Angie|Yelp|Google|Craig'))]
data[common_platform==1, list(obs = .N,
                                mean = mean(Q8_Price_Numeric),
                                min = min(Q8_Price_Numeric),
                                perc25 = quantile(Q8_Price_Numeric, .25, na.rm=TRUE),
                                median = quantile(Q8_Price_Numeric, .50, na.rm=TRUE),
                                perc75 = quantile(Q8_Price_Numeric, .75, na.rm=TRUE),
                                max  = max(Q8_Price_Numeric))]

