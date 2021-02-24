#IPO e XCMS script (Esta em ingles porque acentos em portugues se desconfiguram no R)

##-------------------- installation ----------------------##

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")

BiocManager::install("IPO") # install IPO

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("xcms") # install xcms


if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("CAMERA") # install CAMERA.

##-------------------- arquivos ----------------------##

datafiles <- list.files("D:/..", recursive = TRUE, full.names = TRUE) 
datafiles # lists files names. Check if the correct files were found 


##-------------------- carregando os pacotes ----------------------##

library(xcms)
library(Rmpi)
library(CAMERA)
library (IPO)

##-------------------- IPO ----------------------##

# peak picking parameters optimization 
peakpickingParameters <- getDefaultXcmsSetStartingParams('matchedFilter') #só aceita o matchedFilter

# para alguns parametros se delimita a range que o IPO usará para testes. Se não for especificado, ele testara a range padrão
# se só um numero for especificado, ele não testará aquele parâmetro. 
peakpickingParameters$step <- c(0.1, 0.2) # vai testar varios numeros de step, entre os valores colocados 
peakpickingParameters$fwhm <- c(1, 2)
peakpickingParameters$steps <- 2

time.xcmsSet <- system.time({ 
  resultPeakpicking <- 
    optimizeXcmsSet(files = datafiles[1:6], # na função datafiles, que listou os arquivos, foi dado números ao lado dos nomes. Coloque os numeros somente das amostras que serão analisadas
                    params = peakpickingParameters, 
                    nSlaves = 1,# mudar apenas para computadores potentes. É a quantidade de testes simultaneos.  
                    subdir = 'C:/...', #determina onde ficarão os graficos do IPO, caso esteja TRUE, embaixo
                    plot = TRUE) # TRUe: fará graficos, FALSE não fará gráficos
})

resultPeakpicking$best_settings$result 
optimizedXcmsSetObject <- resultPeakpicking$best_settings$xset 

# otimização dos parametros de correção do tempo de retenção
retcorGroupParameters <- getDefaultRetGroupStartingParams() 
retcorGroupParameters$profStep <- 1
retcorGroupParameters$gapExtend <- 2.7
retcorGroupParameters$mzwid <- 
  time.RetGroup <- system.time({ 
    resultRetcorGroup <-
      optimizeRetGroup(xset = optimizedXcmsSetObject, 
                       params = retcorGroupParameters, 
                       nSlaves = 1, # mudar apenas para computadores potentes. É a quantidade de testes simultaneos.
                       subdir = 'C:/...', # determina onde ficarão os graficos do IPO, caso esteja TRUE, embaixo
                       plot = TRUE) # TRUe: fará graficos, FALSE não fará gráficos
  })

writeRScript(resultPeakpicking$best_settings$parameters, 
             resultRetcorGroup$best_settings) #escreve o script para ser levado ao xcms direto. 

time.xcmsSet
time.RetGroup

sessionInfo()

##-------------------- XCMS ----------------------##

# separar os arquivos QC e de cada grupo em pastas isoladas. Estas pastas, colocar em uma pasta geral, que será o diretório. 

setwd ("C:/...") # modifica o diretório. Colocar o path para a pasta geral. 

#o script gerado pelo IPO é semelhante com este abaixo.Após gerado o script, colar o resultado abaixo para rodar o xcms. 
# renomear os 3 ultimos 'xset' ára xset2, xset3 e xset4 para que não ocorra overwrite dos objetos no R 

xset <- xcmsSet( 
  method   = "matchedFilter",
  fwhm     = 2.0,
  snthresh = 2,
  step     = 0.1,
  steps    = 2,
  sigma    = 0,
  max      = 100,
  mzdiff   = 0.5,
  index    = FALSE,)

xset2 <- retcor( # todos os objetos são nomeados xset no script do IPO. Renomear. 
  xset,
  method         = "obiwarp",
  plottype       = "none",
  distFunc       = "cor_opt",
  profStep       = 1, #é possível que haja problemas com profStep 1. Se for o caso, modificar para 0.99
  center         = 4,
  response       = 1,
  gapInit        = 0.528,
  gapExtend      = 2.7,
  factorDiag     = 2,
  factorGap      = 1,
  localAlignment = 0,)

xset3 <- group( 
  xset2,
  method  = "density",
  bw      = 10,
  mzwid   = 0.1,
  minfrac = 1,
  minsamp = 1,
  max     = 100)

xset4 <- fillPeaks(xset3)

an <- xsAnnotate(xset4)

#Creation of an xsAnnotate object

anF <- groupFWHM(an, perfwhm = 0.6)

#Perfwhm = parameter defines the window width, which is used for matching

anI <- findIsotopes(anF, mzabs=0.01)

#Mzabs = the allowed m/z error

anIC <- groupCorr(anI, cor_eic_th=0.75) 
anFA <- findAdducts(anIC, polarity="positive") #mudar polaridade 

write.csv(getPeaklist(anIC), file="Name.csv") # gera a tabela de features




