
#Climate graph

#data

Year <- c(2014, 2015, 2016)
Response <- c(1000, 1100, 1200)
Rate <- c(0.75, 0.42, 0.80)  

bel <- read.csv("G:/2. LABMETAMASS/COLABORA??ES/Bel/bel R.csv")

#Chart
library(ggplot2)

  ggplot(bel)  + 
  geom_bar(aes(x=Month, y=Rainfall..mm.),stat="identity", fill="black", colour="black")+   
  geom_line(aes(x=Month, y=Average.Temperature..?C.),size = 1, color="#252525", group = 1)+
  geom_point(aes(x=Month, y=Average.Temperature..?C.),size = 2, color="#252525", group = 1)+
  geom_line(aes(x=Month, y=Max.Temperature..?C.),size = 1, color="red", group = 1) +
  geom_point(aes(x=Month, y=Max.Temperature..?C.),size = 2, color="red", group = 1)+
  geom_line(aes(x=Month, y=Minimum.Temperature..?C.),size = 1, color="blue", group = 1)+
  geom_point(aes(x=Month, y=Minimum.Temperature..?C.),size = 2, color="blue", group = 1)+
  scale_y_continuous(sec.axis = sec_axis(~., name = "Temperature (?C)"))

ggsave("bel.png", type = "cairo", dpi = 600 ) #tipo cairo salva o grafico em melhor resolu??o

