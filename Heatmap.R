## HEATMAP


# read data
data <- read.csv("G:/2. LABMETAMASS/COLABORACOES/Bel/svr_Bel_FxG_months_ELISA.csv", sep = ",")

# autoscaling
## package mdatools - install only the first time to use
install.packages("mdatools") 
library(mdatools)

## only numeric columns - excluded the label and the samples columns
# 26 is the max number of features. If you have more, change that
datanorm <- data[,3:26]
datanorm <- prep.autoscale(datanorm, center = T, scale = T)

## graphs of normalization
### the lines starting with png will save the following graph on your WORKING directory (getwd() to check)
### You won't be able to see it first. If you wish, run the line below the "png" first,
### check the plot and then run the three lines to save the plot (png, boxplot, dev.off)

png("boxplot_norm.png",width = 480, height = 480, units = "px")
boxplot(datanorm, main = "Mean centered and standardized")
dev.off()

   ###separate data for the following plots
datab <- as.matrix(data[3:26])
dataa <- datanorm

### same as before, the png line will only save the plots, you won't be able to see it
png("Before_After.png", height = 480, width = 980 )
par(mfrow = c(1,2))
plot(density(datab), main = "Before Normalization", lwd=3 )
plot(density(datanorm), main = "After Normalization", lwd=3)
dev.off()

#brings the two columns back
datanorm<-as.data.frame(datanorm)

#can be done mannually until line 55
#using the [] garantees the name is exactly the same from the original data frame (data)
datanormnames <- cbind(data["X"], data["label"], datanorm)

#creates a df with the labels, so later we can substitute F... for month name
month <- c("Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May")
label <- c("F01", "F02", "F03", "F04", "F05", "F06", "F07", "F08", "F09", "F10", "F11", "F12")
label <- cbind(label, month) 

#changes F... for the month names and brings it to the first column
library(dplyr)
datanormlabeled <- merge(datanormnames, label, by.y= "label", all.x = TRUE)
datanormlabeled <- select(datanormlabeled, last_col(), everything())

#takes out the extgra column with F...
datanormlabeled2<- datanormlabeled[ , c(1,3, 4:27)]


# mean for each feature, per month, for all individuals

# split por month. It looks the same as the other dataframe, but it is splitted for
# operations

colnames(datanormlabeled2) <- c("month", "sample",letters[1:24])

datanormlabeled2$month<-as.factor(datanormlabeled2$month) #?

meses <- group_by(datanormlabeled2, datanormlabeled2$month)


#media por feature

summarise(meses, a=mean(a)) #loop through all columns? try with one column first

#loop throught letters columns dataframe 

for (i in 3:length(meses)){
   letters[1:24]<- summarise(meses, i = mean(i))
  }



for(i in 1:length(splitted)) {
  assign(paste0("F", i), splitted[[i]])
}



for (i in F) {
  
}


mean <- as.data.frame(apply(F1, 2, mean))

f1 <- as.data.frame(splitted$F01)

mean

ggplot(heatmap, aes(x = label, y = features, fill = ))  + 
  geom_tile()


"2E-Hexenal","α-Thujene","α-Pinene","Thuja-2,4 10-diene",
"Sabinene","UF","1-Octen-3-ol","3-Octanone","Myrcene","3-Octanol","3Z-Hexenyl acetate",
"δ-3-Carene","o-Cymene","UF1","Limonene","E-β-Ocimene","α-Ocimene","α-Cubebene","α-Copaene",
"β-Bourbonene","β-Cubebene","E-Caryophyllene","Germacrene D","UF3" 