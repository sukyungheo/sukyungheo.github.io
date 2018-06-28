path = "../data/"

#library(data.table)
#df <- fread(paste0(path, "train_sample.csv"))
#head(df, 20)
install.packages("data.table")
library(fread)
tr <- fread(paste0(path, "train.csv"))
head(tr, 20)
install.packages("dplyr")
library(dplyr)
tr_head <- tr %>%
  select(-c(attributed_time)) %>%
  mutate(wday = Weekday(click_time), hour = hour(click_time)) %>% 
  select(-c(click_time)) %>%
  add_count(ip, wday, hour) %>% rename("nip_day_h" = n) %>%
  add_count(ip, hour, channel) %>% rename("nip_h_chan" = n) %>%
  add_count(ip, hour, os) %>% rename("nip_h_osr" = n) %>%
  add_count(ip, hour, app) %>% rename("nip_h_app" = n) %>%
  add_count(ip, hour, device) %>% rename("nip_h_dev" = n) %>%
  select(-c(ip)) %>%
  head(20)

write.csv(tr_head,"tr_head.csv",row.names = F)