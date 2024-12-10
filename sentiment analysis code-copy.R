install.packages("SentimentAnalysis") 
install.packages("SnowballC")
library(ggplot2)
library(SnowballC)
library(SentimentAnalysis)
library(tree)
######Linkedin
linkedin<-read.csv("/Users/ciciwxp/Desktop/stat4996/code/SocialMediaAnalysisPSI/linkedin_final2.csv")
sentiment_linkedin<-analyzeSentiment(linkedin$clean_text)
hist(linkedin$log_plus1)
hist(sentiment_linkedin$SentimentGI)
#convertToBinaryResponse(sentiment)
plotSentimentResponse(sentiment_linkedin$SentimentGI,response = linkedin$log_plus1)
linkedin["SentimentGI"]<-sentiment_linkedin$SentimentGI
result1<-lm(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers, data=linkedin)
plot(result1)
summary(result1)
#drop
result1_2<-lm(log_plus1~SentimentGI+question_mark+average_length+emoji+word_count+followers, data=linkedin)
summary(result1_2)
result1_3<-lm(log_plus1~SentimentGI+question_mark+emoji+word_count+followers, data=linkedin)
summary(result1_3)

######twitter
twitter<-read.csv("/Users/ciciwxp/Desktop/stat4996/code/SocialMediaAnalysisPSI/twitter_final2.csv")
sentiment_twitter<-analyzeSentiment(twitter$clean_text)
plotSentimentResponse(sentiment_twitter$SentimentGI,response = twitter$log_plus1)
twitter["SentimentGI"]<-sentiment_twitter$SentimentGI
result2<-lm(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers, data=twitter)
summary(result2)
#drop
result2_2<-lm(log_plus1~SentimentGI+hashtag+average_length+emoji+word_count+followers, data=twitter)
summary(result2_2)
result2_3<-lm(log_plus1~SentimentGI+hashtag+average_length+emoji+followers, data=twitter)
summary(result2_3)
result2_3<-lm(log_plus1~SentimentGI+average_length+emoji+followers, data=twitter)
summary(result2_3)


######facebook
facebook<-read.csv("/Users/ciciwxp/Desktop/stat4996/code/SocialMediaAnalysisPSI/facebook_final2.csv")
sentiment_facebook<-analyzeSentiment(facebook$clean_text)
hist(log(facebook$response))
plotSentimentResponse(sentiment_facebook$SentimentGI,response = log_plus1)
facebook["SentimentGI"]<-sentiment_facebook$SentimentGI
result3<-lm(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers,data=facebook)
summary(result3)
#drop
result3_2<-lm(log_plus1~SentimentGI+question_mark+average_length+emoji+word_count+followers,data=facebook)
summary(result3_2)
result3_3<-lm(log_plus1~SentimentGI+question_mark+emoji+word_count+followers,data=facebook)
summary(result3_3)
result3_4<-lm(log_plus1~SentimentGI+question_mark+word_count+followers,data=facebook)
summary(result3_4)
result3_5<-lm(log_plus1~SentimentGI+word_count+followers,data=facebook)
summary(result3_5)
result3_6<-lm(log_plus1~word_count+followers,data=facebook)
summary(result3_6)

result4<-lm(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count,data=facebook)
summary(result4)
result4_1<-lm(log_plus1~SentimentGI+hashtag+average_length+emoji+word_count,data=facebook)
summary(result4_1)
result4_2<-lm(log_plus1~hashtag+average_length+emoji+word_count,data=facebook)
summary(result4_2)


#linkedin tree
tree.linkedin<-tree(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers, data=linkedin)
plot(tree.linkedin)
text(tree.linkedin, cex=0.70, pretty=0)

cv.linkedin<-tree::cv.tree(tree.linkedin, K=10)
cv.linkedin
#6
prune.linkedin<-tree::prune.tree(tree.linkedin,best = 6 )
plot(prune.linkedin)
text(prune.linkedin, cex=0.70, pretty=0)


##tw tree
tree.twitter<-tree(log_plus1~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers, data=twitter)
#summary(tree.twitter)
plot(tree.twitter)
text(tree.twitter, cex=0.70, pretty=0)

cv.twitter<-tree::cv.tree(tree.twitter, K=10)
cv.twitter
#4
prune.twitter<-tree::prune.tree(tree.twitter,best = 4 )
summary(prune.twitter)
plot(prune.twitter)
text(prune.twitter, cex=0.70, pretty=0)

##FB tree
xs
#3
prune.facebook<-tree::prune.tree(tree.facebook,best = 3)
plot(prune.facebook)
text(prune.facebook, cex=0.70, pretty=0)

(table(facebook$response))
