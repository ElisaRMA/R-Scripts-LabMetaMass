# Analysis - P. neochilus paper

## ---------------- SVR Normalization ---------------- ##

# package

library(MetNormalizer)

# change working directory to where the files are stored.
path <- setwd('D:/...')

# two files are necessary:
data   <- read.csv (choose.files(),na.strings="NA",header=T,sep=";",as.is=TRUE)
sampleinfo <- read.csv (choose.files(),na.strings="NA",header=T,sep=";",as.is=TRUE)

list.files(path, recursive = TRUE, full.names = TRUE)

metNor(
  ms1.data.name = "data",
  sample.info.name = "sampleinfo",
  minfrac.qc = 0,
  minfrac.sample = 0,
  optimization = TRUE,
  multiple = 5,
  threads = 3,
  path = "."
)

