##Script otimizaÃ§ao XCMS -  Elisa Ribeiro Miranda Antunes, LabMetaMass. 

# IPO:  a tool for automated optimization of XCMS parameters (Libiseller et al. 2015)

## "This document describes how to use R-package  IPO to optimize xcms 
## parameters. Addition to IPO the R-packages xcms and rsm are required
## The R-package msdata and mtbls2 are recommended."

#INSTALACAO
## usar http:// se https:// URLs nao funcionarem
if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("IPO")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("xcms")

install.packages("rsm")

########

library (IPO)

## arquivos para otimiza??o

datafiles <- list.files(
  path = "C:/Users/elisa/Desktop/R directory/Gui - GC", #mude o local em de acordo
  recursive =  TRUE,
  full.names =  TRUE)

datafiles #checa os arquivos para otimiza??o

## Para otimizar os parametros, diferentes valores devem ser testados.
# LC vs GC : LC geralmente tem picos mais largos

peakpickingParameters <- getDefaultXcmsSetStartingParams('matchedFilter')
peakpickingParameters$step <- c(0.2, 0.3) #conhe?a seus dados antes. Aten??o se for GC ou LC 
peakpickingParameters$fwhm <- c(2, 3) #conhe?a seus dados antes (altura e largura dos picos). Aten??o se for GC ou LC 
peakpickingParameters$steps <- 2 #se colocado somente um valor, o par?metro nao ? otimizado

time.scmsSet <- system.time({
  resultPeakpicking <-
    optimizeXcmsSet(files = datafiles [1:10], #amount of files
                    params = peakpickingParameters,
                    nSlaves = 1,
                    subdir = "C:/Users/elisa/Desktop/R directory/IPO" , # ? a pasta onde ser? salvo graficos do IPO
                    plot = TRUE)
})



## Salvar imagem e script. Salvar a imagem permite que os resultados do otimizador fiquem salvos, 
## sem que seja necessario rodar o IPO novamente. Salvar o script permite que as altera??es nos
## c?digos fiquem salvas e que possam ser usadas ou modificadas posteriormente. 



