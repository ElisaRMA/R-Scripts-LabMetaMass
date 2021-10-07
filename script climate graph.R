
# Climate Graph - use it with the 'example_climatedata.csv'


library(ggplot2)
library(readr)

#data
climate <- read.csv(choose.files())

# if you need a specific order on the x axis create an object.
order <- c("jul/17", "aug/17", "sep/17", "oct/17", "nov/17", "dec/17", "jan/18", "feb/18", "mar/18", "apr/18", "may/18", "jun/18")

#creates a climate graph with Temperature (Min, Max, Avg) and Rainfall over the months. (2 axis)

# colors, size, labs and y data can be changed.
 ggplot(climate)  +
  geom_bar(aes(x= factor(Month, level = order), y=Rainfall),stat="identity", fill="black", colour="black")+
  geom_line(aes(x= factor(Month, level = order), y=Average.Temperature),size = 1, color="#252525", group = 1)+
  geom_point(aes(x= factor(Month, level = order), y=Average.Temperature),size = 2, color="#252525", group = 1)+
  geom_line(aes(x= factor(Month, level = order), y=Max.Temperature),size = 1, color="red", group = 1) +
  geom_point(aes(x= factor(Month, level = order), y=Max.Temperature),size = 2, color="red", group = 1)+
  geom_line(aes(x= factor(Month, level = order), y=Minimum.Temperature),size = 1, color="blue", group = 1)+
  geom_point(aes(x= factor(Month, level = order), y=Minimum.Temperature),size = 2, color="blue", group = 1)+
  scale_y_continuous(sec.axis = sec_axis(~., name = "Temperature (ºC)"))+
  labs( x = "Months", title = "Climate Graph")

 #better resolution to save the plots
ggsave("climate.png", type = "cairo", dpi = 600 )





