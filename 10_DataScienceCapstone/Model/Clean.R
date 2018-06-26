getCleanText <- function(sText, bRemoveBadWords, bRemoveStopWords){
    #Remove non-English characters
    sCorpusText <- iconv(sText, "latin1", "ASCII", sub = " ")

    #Remove URLs
    sCorpusText <- gsub("http[^[:space:]]*", " ", sCorpusText)
    
    #Remove hashtags
    sCorpusText <- gsub("#\\S+", " ", sCorpusText)
    
    #Remove twitter handles
    sCorpusText <- gsub("@\\S+", " ", sCorpusText)
    
    #Remove words enclosed between (), [], and {}
    #oCorpus <- tm_map(oCorpus, content_transformer(bracketX))
    sCorpusText <- gsub("\\s*\\([^\\)]+\\)", " ", sCorpusText)
    sCorpusText <- gsub("\\s*\\[[^\\)]+\\]", " ", sCorpusText)
    sCorpusText <- gsub("\\s*\\{[^\\)]+\\}", " ", sCorpusText)
    
    #Remove words with numbers
    #oCorpus <- tm_map(oCorpus, removeNumbers)
    sCorpusText <- gsub("\\w*[0-9]+\\w*\\s*", " ", sCorpusText)
    
    #Replace contractions with long form
    sCorpusText <- replace_contraction(sCorpusText)
    
    #Replace abbreviations with long form
    #oCorpus <- tm_map(oCorpus, content_transformer(replace_abbreviation))
    sCorpusText <- replace_abbreviation(sCorpusText)

    #Remove badwords
    if (bRemoveBadWords == 1){
        oBadWords <- tolower(stripWhitespace(readLines("./input/badwords.txt")))
        sCorpusText <- removeWords(sCorpusText, oBadWords)
        #oCorpus <- tm_map(oCorpus, removeWords, oBadWords)
    }

    #Remove stopwords
    if (bRemoveStopWords == 1){
        sCorpusText <- removeWords(sCorpusText, stopwords())
    }

    #Remove words with more than 20 character
    sCorpusText <- gsub("\\b\\w{21,}\\b", " ", sCorpusText)
    
    #Remove words with 1 character
    #sCorpusText <- gsub("\\b\\w{1}\\b", " ", sCorpusText)
    o1Letter <- c("b", "c", "d", "e", "f", "g", "h", "j", 
                  "k", "l", "m", "n", "o", "p", "q", "r", 
                  "s", "t", "u", "v", "w", "w", "y", "z")
    sCorpusText <- removeWords(sCorpusText, o1Letter)
    

    #Convert to corpus
    system.time({
        oCorpus <- Corpus(VectorSource(list(sCorpusText)))
    })

    #Replace contractions with long form
    #system.time({
        #For some reason this truncates the corpus to ~ 1MB on all Windows/Mac/Linux platforms
        #So, used straight replace_contraction function above
        #oCorpus <- tm_map(oCorpus, content_transformer(replace_contraction))
    #})

    #Remove punctuations
    oCorpus <- tm_map(oCorpus, removePunctuation)

    #Remove whitespaces
    oCorpus <- tm_map(oCorpus, stripWhitespace)
    
    #Lowercase
    oCorpus <- tm_map(oCorpus, content_transformer(tolower))
    
    return(oCorpus)
}

createCleanedSample <- function (iFileIndex){
    iLineCount <- 0
    iWordCount <- 0

    sFileText <- getFileContents(sSwiftKeyFiles[iFileIndex])
    iLineCount <- length(sFileText)
    iWordCount <- wordcount(sFileText)
    sFileSample <- sample(sFileText, ceiling(iLineCount * nSampleSize))
    saveRDS(sFileSample, sSampleFilesRDS[iFileIndex])
    writeLines(sFileSample, sSampleFilesTXT[iFileIndex])

    system.time({
        oCorpus <- getCleanText(sFileSample, 1, 0)
        saveRDS(oCorpus, sCleanFilesRDS[iFileIndex])
        writeLines(oCorpus$content, sCleanFilesTXT[iFileIndex])
    })

    return(c(iLineCount, iWordCount))
}
