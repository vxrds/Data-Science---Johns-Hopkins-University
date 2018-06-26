#Parameterized n-gram tokenizer function
getNGramTokenizer <- function(n){
    #return(function(x) NGramTokenizer(x, Weka_control(min = n, max = n, delimiters = " \\r\\n\\t.,;:\"()?!")))
    return(function(x) NGramTokenizer(x, Weka_control(min = n, max = n)))
}

getNGram <- function(oCorpus, iGram){
    #Calculate term frequencies
    oTDM <- TermDocumentMatrix(oCorpus, control = list(tokenize = getNGramTokenizer(iGram)))
    oTerms <- oTDM$dimnames$Terms
    oFreq <- rowSums(as.matrix(oTDM))

    #Sort by frequency
    oDF <- data.frame(oTerms, oFreq)
    colnames(oDF) <- c("Term", "Freq")
    oDF <- oDF[order(-oDF$Freq), ]
    
    return(oDF)
}
