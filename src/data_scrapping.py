#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 21:34:55 2022

@author: ciciwxp
"""

import json
import csv
import pandas as pd

## FACEBOOK SCRAPER 
from facebook_scraper import get_posts

# add more available companies later
fb_companies = [ 'nonprofitist', 'JoanGarryConsulting']
for i in fb_companies:
    fb_name = []
    fb_text = []
    fb_like = []
    fb_cmt = []
    for post in get_posts(i, pages=20):
        fb_text.append(post['text'])
        fb_like.append(post['likes'])
        fb_cmt.append(post['comments'])
    if fb_companies.index(i) == 0:
        fb_data = pd.DataFrame({
            'name': i,
            'text': fb_text,
            'likes': fb_like,
            'comments': fb_cmt})
    else:
        fb_data_add = pd.DataFrame({
            'name': i,
            'text': fb_text,
            'likes': fb_like,
            'comments': fb_cmt})
        fb_data = fb_data.append(fb_data_add)



## TWITTER SCRAPER
from twitter_scraper_selenium import scrap_profile

#list of ID
tw_companies = ['annwprice', 'viableinsights', 'NicoleClarkLMSW', 'nonprofitist',
                'joangarry', 'thinkinkgrants', 'mirrorgroupllc', 'TheSparkMill']
tw_name = []
tw_text = []
tw_like = []
tw_cmt = [] 
#scrape by looping through the list of ID
def tw_scraper(company):
    tweet = scrap_profile(twitter_username = company ,output_format = "json", 
                          browser = "chrome", tweets_count = 20)
    if tweet != None:
        tweet_dict = json.loads(tweet)
        for i in tweet_dict.keys():
            tw_name.append(tweet_dict[i]['name'])
            tw_text.append(tweet_dict[i]['content'])
            tw_like.append(tweet_dict[i]['likes'])
            tw_cmt.append(tweet_dict[i]['replies']) 
            
for i in tw_companies:
    tw_scraper(i)
    
tw_data = pd.DataFrame({
    'name': tw_name,
    'text': tw_text,
    'likes': tw_like,
    'comments': tw_cmt})           

#remove retweets
tw_rm = ['Ann Price (she, her, hers)', 'Viable Insights', 
         'Nicole Clark Consulting', 'Nonprofit.ist', 'Joan Garry',
         'Think and Ink Grants', '@mirrorgroupllc', 'The Spark Mill']
tw_data2 = tw_data.loc[tw_data['name'].isin(tw_rm) == True]

#WRITE CSV
tw_data2.to_csv('twitter_0927.csv', index = False)
fb_data.to_csv('facebook_0927.csv', index = False)
