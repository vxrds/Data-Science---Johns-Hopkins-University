## Declarations
#setwd("/mnt/hgfs/Z/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
setwd("Z:/F/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
sCorpusRDS <- "./data/corpus.RDS"
sGramRDS <- c("./data/unigram.RDS", "./data/bigram.RDS", "./data/trigram.RDS", "./data/quadrigram.RDS", "./data/fivegram.RDS")
sGramTXT <- c("./data/unigram.txt", "./data/bigram.txt", "./data/trigram.txt", "./data/quadrigram.txt", "./data/fivegram.txt")

library(dplyr)
library(tidytext)

oCorpus <- readRDS(sCorpusRDS)

iIndex <- 1
if (file.exists(sGramRDS[iIndex])){
    oUnigram <- readRDS(sGramRDS[iIndex])
} else {
    oUnigram <- data_frame(txt = oCorpus[1]) %>% 
        unnest_tokens(word, txt) %>% 
        anti_join(stop_words) %>% 
        count(word, sort = TRUE)

    colnames(oUnigram) <- c("Term", "Freq")
    saveRDS(oUnigram, sGramRDS[iIndex])
    write.table(oUnigram, sGramTXT[iIndex])
}

iIndex <- 2
if (file.exists(sGramRDS[iIndex])){
    oBigram <- readRDS(sGramRDS[iIndex])
} else {
    oBigram <- data_frame(txt = oCorpus[1]) %>% 
        unnest_tokens(bigram, txt, token = "ngrams", n = iIndex) %>% 
        count(bigram, sort = TRUE)
    
    colnames(oBigram) <- c("Term", "Freq")
    saveRDS(oBigram, sGramRDS[iIndex])
    write.table(oBigram, sGramTXT[iIndex])
}

iIndex <- 3
if (file.exists(sGramRDS[iIndex])){
    oTrigram <- readRDS(sGramRDS[iIndex])
} else {
    oTrigram <- data_frame(txt = oCorpus[1]) %>% 
        unnest_tokens(trigram, txt, token = "ngrams", n = iIndex) %>% 
        count(trigram, sort = TRUE)

    colnames(oTrigram) <- c("Term", "Freq")
    saveRDS(oTrigram, sGramRDS[iIndex])
    write.table(oTrigram, sGramTXT[iIndex])
}

iIndex <- 4
if (file.exists(sGramRDS[iIndex])){
    oQuadrigram <- readRDS(sGramRDS[iIndex])
} else {
    oQuadrigram <- data_frame(txt = oCorpus[1]) %>% 
    unnest_tokens(quadrigram, txt, token = "ngrams", n = iIndex) %>% 
    count(quadrigram, sort = TRUE)

    colnames(oQuadrigram) <- c("Term", "Freq")
    saveRDS(oQuadrigram, sGramRDS[iIndex])
    write.table(oQuadrigram, sGramTXT[iIndex])
}

iIndex <- 5
if (file.exists(sGramRDS[iIndex])){
    oFivegram <- readRDS(sGramRDS[iIndex])
} else {
    oFivegram <- data_frame(txt = oCorpus[1]) %>% 
        unnest_tokens(fivegram, txt, token = "ngrams", n = iIndex) %>% 
        count(fivegram, sort = TRUE)
    
    colnames(oFivegram) <- c("Term", "Freq")
    saveRDS(oFivegram, sGramRDS[iIndex])
    write.table(oFivegram, sGramTXT[iIndex])
}

rm(list = ls())
invisible(gc())
