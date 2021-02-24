
#Climate graph e Heatmap

#data

Year <- c(2014, 2015, 2016)
Response <- c(1000, 1100, 1200)
Rate <- c(0.75, 0.42, 0.80)  

library(ggplot2)
library(readr)

bel <- read.csv("G:/2. LABMETAMASS/COLABORACOES/Bel/bel R.csv")

#Chart
library(ggplot2)

order <- c("jul/17", "aug/17", "sep/17", "oct/17", "nov/17", "dec/17", "jan/18", "feb/18", "mar/18", "apr/18", "may/18", "jun/18")
 
 ggplot(bel)  + 
  geom_bar(aes(x= factor(Month, level = order), y=Rainfall),stat="identity", fill="black", colour="black")+   
  geom_line(aes(x= factor(Month, level = order), y=Average.Temperature),size = 1, color="#252525", group = 1)+
  geom_point(aes(x= factor(Month, level = order), y=Average.Temperature),size = 2, color="#252525", group = 1)+
  geom_line(aes(x= factor(Month, level = order), y=Max.Temperature),size = 1, color="red", group = 1) +
  geom_point(aes(x= factor(Month, level = order), y=Max.Temperature),size = 2, color="red", group = 1)+
  geom_line(aes(x= factor(Month, level = order), y=Minimum.Temperature),size = 1, color="blue", group = 1)+
  geom_point(aes(x= factor(Month, level = order), y=Minimum.Temperature),size = 2, color="blue", group = 1)+
  scale_y_continuous(sec.axis = sec_axis(~., name = "Temperature (ºC)"))+
  labs( x = "Months", title = "Climate Graph")

  ggsave("bel.png", type = "cairo", dpi = 600 ) #tipo cairo salva o grafico em melhor resoluo


 
  
  

  