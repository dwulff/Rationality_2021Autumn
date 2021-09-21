require(tidyverse)
Teilnehmer = readr::read_csv('_sessions/Teilnehmer.csv')
Bernoulli = readr::read_csv('_sessions/BernoulliPascal/Bernoulli.csv')
Pascal = readr::read_csv('_sessions/BernoulliPascal/Pascal.csv')

Teilnehmer = Teilnehmer %>% 
  left_join(Bernoulli, 
            by = c("Last name" = "Nachname","First name" = "Vorname")) %>% 
  left_join(Pascal, 
            by = c("Last name" = "Nachname","First name" = "Vorname"))

Teilnehmer %>% 
  select(`Last name`,`First name`,`Aktive Lesezeit.x`,`Aktive Lesezeit.y`) %>% print(n = 100)


encode = function(x) charToRaw(paste0(base::rev(str_split(x,'')[[1]]),collapse=''))

names = paste(Teilnehmer$`First name`, Teilnehmer$`Last name`)
names_code = sapply(names, encode)

set.seed(100)
rnd = sample(1:27)

gr_1 = names_code[1:9]
gr_2 = names_code[10:18]
gr_3 = names_code[19:27]

rbind(cbind(names(gr_1),1),
  cbind(names(gr_2),2),
  cbind(names(gr_3),3)) -> grs 
last = sapply(str_split(grs[,1],' '),function(x) x[length(x)])
grs[order(last),]

paste0('"',gr_1,'"')


