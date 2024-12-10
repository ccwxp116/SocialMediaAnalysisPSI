#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 30 22:42:05 2022

@author: ciciwxp
"""

import pandas as pd
import advertools as adv
from datetime import date
import nltk
import re
nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.sentiment.vader import SentimentIntensityAnalyzer as SIA
nltk.download('vader_lexicon')
import math

fb_data = pd.read_csv("facebook_1026.csv")
tw_data = pd.read_csv('twitter_1026.csv')
lk_data = pd.read_csv('linkedin_1026.csv')


# SPECIAL CHARACTERS
def count_special(data):
    Q = []
    E = []
    for i in data['text']:
        string1 = str(i)
        counts = string1.count("?")
        emoji = len(adv.extract_emoji(string1)['emoji_flat'])
        Q.append(counts)
        E.append(emoji)
    data['hashtag'] = data['text'].str.count('#')
    data['question_mark'] = pd.Series(Q)
    data['emoji'] = pd.Series(E)
    
count_special(fb_data)
count_special(tw_data)
count_special(lk_data)

#####
# word tokenize and regex
#####

# set stop words
stop_words = set(stopwords.words('english'))

# create empty lists
sia = SIA()
def ave_and_clean(data):
    token_all = []
    word_length = []
    clean_text = []
    corpus = []
    word_count = []
    for i in range(0,len(data)):
        unclean_text = data['text'][i]
        clean_text1 = re.sub(r'http\S+', '', str(unclean_text))
        clean_text2 = re.sub("@[A-Za-z0-9_]+","", clean_text1)
        clean_text3 = re.sub("#[A-Za-z0-9_]+","", clean_text2)
        string = re.sub('[^a-zA-Z \n]', '', clean_text3).lower()
        
        word_tokens = word_tokenize(string)
        
        filtered_sentence = [w for w in word_tokens if not w.lower() in stop_words]
         
        for w in word_tokens:
            if w not in stop_words:
                filtered_sentence.append(w)
                
        token_all.append(filtered_sentence)
        
        length = 0
        for j in filtered_sentence:
            length += len(j)
        if (len(filtered_sentence) == 0):
            ave_length = 0
        else:
            ave_length = length/len(filtered_sentence)
        word_length.append(ave_length)
        clean_text.append(string)
        corpus.append(filtered_sentence)
        word_count.append(len(filtered_sentence))
        
    data['average_length'] = word_length
    data['clean_text'] = clean_text
    data['corpus'] = corpus
    data['word_count'] = word_count

ave_and_clean(fb_data)
ave_and_clean(tw_data)
ave_and_clean(lk_data)

def trans_response(data):
    data['response'] = data['likes'] + data['comments']
    plus1 = []
    log = []
    for i in range(0, len(data)):
        if (data['response'][i] == 0):
            log.append(0)
        else:
            log.append(math.log(data['response'][i]))
        plus1.append(math.log(data['response'][i]+1))
    data['log_plus1'] = plus1
    data['log'] = log
    avg_diff = (data['log_plus1'] - data['log']).mean()
    max_diff = (data['log_plus1'] - data['log']).max()
    return [avg_diff, max_diff]

trans_response(fb_data)
trans_response(tw_data)
trans_response(lk_data)

# what next:
    #change emoji count into levels
    
####
#export data
####

fb_data.to_csv('facebook_final2.csv', index = False)
tw_data.to_csv('twitter_final2.csv', index = False)
lk_data.to_csv('linkedin_final2.csv', index = False)