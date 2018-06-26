getFileContents <- function(sFileName){
    oConn <- file(sFileName, 'rb')
    oText <- readLines(oConn, encoding = "UTF-8", skipNul = T)
    close(oConn)
    return(oText)
}
