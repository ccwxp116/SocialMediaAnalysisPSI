#install.packages("tm", repos="http://R-Forge.R-project.org")
#install.packages("tm")
install.packages("rlang")
install.packages("tm",dependencies=TRUE)
devtools::install_cran("tm", force = T)
library(tm)
library(ggplot2)
library(SnowballC)
library(SentimentAnalysis)
library(GGally)
## LINKEDIN
linkedin<-read.csv("/Users/pennyyang/Desktop/UVA/Senior/F22/STAT 4996/Datasets/linkedin_penny.csv")

hist(log(linkedin$response))

#convertToBinaryResponse(sentiment)
#plotSentimentResponse(sentiment_linkedin$SentimentGI,response = log(linkedin$likes+linkedin$comments))

result1<-lm(log(likes+comments+1)~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers,data=linkedin)
summary(result1)
par(mfrow=c(2,2))
plot(result1)

eda1 = ggplot(linkedin, aes(SentimentGI, resp)) + geom_point()
eda1
cor(linkedin$SentimentGI, linkedin$resp)

## EDA
hist(linkedin$response, main = "Distribution of Response Variable for LinkedIn", xlab = "Likes + Comments")
hist(linkedin$log_plus1, main = "Distribution of Response Variable for LinkedIn", xlab = "log(response + 1)")
ggcorr(linkedin[, c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], nbreaks = 10)
pairs(linkedin[,c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], pch = 19,  cex = 0.5, lower.panel=NULL)


## TWITTER
twitter<-read.csv("/Users/pennyyang/Desktop/UVA/Senior/F22/STAT 4996/Datasets/twitter_penny.csv")

#plotSentimentResponse(sentiment_twitter$SentimentGI,response = log(twitter$response))

result2<-lm(log(likes+comments+1)~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers,data=twitter)
summary(result2)
par(mfrow=c(2,2))
plot(result2)

ggplot(twitter, aes(SentimentGI, log_plus1)) + geom_point()+geom_smooth(se=F)

cor(twitter$SentimentGI, twitter$log_plus1)

## EDA
hist(twitter$response, main = "Distribution of Response Variable for Twitter", xlab = "Likes + Comments")
hist(twitter$log_plus1, main = "Distribution of Response Variable for Twitter", xlab = "log(response + 1)")
ggcorr(twitter[, c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], nbreaks = 10)
pairs(twitter[,c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], pch = 19,  cex = 0.5, lower.panel=NULL)


## FACEBOOK
facebook<-read.csv("/Users/pennyyang/Desktop/UVA/Senior/F22/STAT 4996/Datasets/facebook_penny.csv")

hist(log(facebook$response))
#plotSentimentResponse(sentiment_facebook$SentimentGI,response = log(facebook$response))

result3<-lm(log(likes+comments+1)~SentimentGI+hashtag+question_mark+average_length+emoji+word_count+followers,data=facebook)
summary(result3)
par(mfrow=c(2,2))
plot(result3)

## EDA

ggplot(facebook, aes(SentimentGI, log_plus1)) + geom_point()+geom_smooth(se=F)

hist(facebook$response, main = "Distribution of Response Variable for Facebook", xlab = "Likes + Comments")
hist(facebook$log_plus1, main = "Distribution of Response Variable for Facebook", xlab = "log(response + 1)")
ggcorr(facebook[, c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], nbreaks = 10)
pairs(facebook[,c('log_plus1','SentimentGI',"hashtag","question_mark", 'average_length', 'emoji', 'word_count', 'followers')], pch = 19,  cex = 0.5, lower.panel=NULL, line.main = "Scatter Plot Matrix for Facebook")


