library(wordcloud)
library(ggplot2)


#Top 100 wordcloud
wordcloud(words = oUnigram$Term, 
          freq = oUnigram$Freq, 
          max.words = 200, 
          rot.per = 0.35, 
          colors=brewer.pal(8, "Dark2"), 
          random.order = FALSE)

#Unigram
ngplot <- ggplot(within(oUnigram[1:15, ], Words <- factor(Term, levels=Term)), aes(Words, Freq))
ngplot <- ngplot + geom_bar(stat="identity", fill="purple") + ggtitle("Top 15 Unigrams")
ngplot <- ngplot + theme(axis.text.x=element_text(angle=45, hjust=1))
ngplot

#Bigram
ngplot <- ggplot(within(oBigram[1:15, ], Words <- factor(Term, levels=Term)), aes(Words, Freq))
ngplot <- ngplot + geom_bar(stat="identity", fill="purple") + ggtitle("Top 15 Bigrams")
ngplot <- ngplot + theme(axis.text.x=element_text(angle=45, hjust=1))
ngplot

#Trigram
ngplot <- ggplot(within(oTrigram[1:15, ], Words <- factor(Term, levels=Term)), aes(Words, Freq))
ngplot <- ngplot + geom_bar(stat="identity", fill="purple") + ggtitle("Top 15 Trigrams")
ngplot <- ngplot + theme(axis.text.x=element_text(angle=45, hjust=1))
ngplot

#Quadrigram
ngplot <- ggplot(within(oQuadrigram[1:15, ], Words <- factor(Term, levels=Term)), aes(Words, Freq))
ngplot <- ngplot + geom_bar(stat="identity", fill="purple") + ggtitle("Top 15 Quadrigrams")
ngplot <- ngplot + theme(axis.text.x=element_text(angle=45, hjust=1))
ngplot
