#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 30 22:42:05 2022

@author: ciciwxp
"""
import re
import nltk
nltk.download('punkt')
import pandas as pd
import advertools as adv

fb_data = pd.read_csv("facebook_0927.csv")
tw_data = pd.read_csv('twitter_0927.csv')
# add linked in data 

string = fb_data['text']

tokens = nltk.word_tokenize(fb_data['text'][19])

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
fb_data.to_csv( 'facebook(sc_add).csv', index = False)
count_special(tw_data)
tw_data.to_csv( 'twitter(sc_add).csv', index = False)