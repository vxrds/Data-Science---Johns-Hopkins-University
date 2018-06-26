SwiftKey - Word Prediction
========================================================
author: Vijay Ramanujam
date: May 06, 2018
autosize: true

<h2>Introduction: </h2>
Around the world, people are spending an increasing amount of time on their mobile devices, but typing on them can be a serious pain. SwiftKey, a corporate partner of Coursera, builds a smart keyboard that makes it easier for people to type on their mobile devices. One cornerstone of their smart keyboard is predictive text models. This project provides an idea to achieve the same.

Setup
========================================================
<b>Minimum requirements to run this setup locally.</b>

A computer/laptop with quad-core processor (hyper-threaded), 8GB RAM (at least 5GB available), 2 GB free space on hard-drive
R, R Studio, CRAN/MRAN setup installed

<b>The following R packages are used:</b> tm, ngram, qdap, dplyr, tidytext, data.table.

The training data is downloaded from <a hrfe="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip">here</a>, as provided by Coursera.


Getting and Cleaning Data
========================================================
After trying different setups with commodity hardwares (Windows/Linus/Mac), the "replace_contraction" function of tm package doesn't allow more than 1MB of simplecorpus so I have reduced the sample corpus down to it's optimal 1% sample. You won't get any error message but the data would be truncated at higher sample percentages.

The following transformations were applied for cleaning the data. Remove non-English characters, URLs, hastags, twitter handles, badwords, words with 1 character (except (a and i)/more than 20 characters/enclosed between brackets; treat contractions and abbreviations; exclude bad/stop words in English.

Katz's back-off model
========================================================
The algorithm used to predict the next word in this model is Katz's back-off. It is a generative n-gram language model that estimates the conditional probability of a word given its history in the n-gram. It accomplishes this estimation by "backing-off" to models with smaller histories under certain conditions. By doing so, the model result(s) with the highest probability take precedence in the predictions.

N-grams: In the fields of computational linguistics and probability, an n-gram is a contiguous sequence of n items from a given sample of text or speech. The items can be phonemes, syllables, letters, words or base pairs according to the application. The n-grams typically are collected from a text or speech corpus.

Prediction:
========================================================
A simple implementation of Katz's back-off algorithm is used here by comparing the last n-words (n<=5) of the sentence from user input is matched against the back-off model probabilities to produce top 3 predictions with their probabilities in their respective n-grams.