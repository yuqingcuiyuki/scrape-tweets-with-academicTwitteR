# install httr to avoid firewall
library(httr)
set_config(
  use_proxy(url="127.0.0.1", port=7890) #internet options -> connections -> LAN Setting, check url and port
)
#httr::GET("www.google.com")  

# install academicTwitteR
library(academictwitteR)
bearer_token <- "*****" #apply at https://developer.twitter.com/en

#build queries
q=build_query(query ='(travel OR flight OR visit OR trip) (play OR go OR went OR fly OR flew OR get OR arrive OR arriving) (America OR (United State) OR USA OR (the States) OR Usa)',
              country = "GB",
              lang='en', 
              is_retweet = FALSE,
)

#get tweets according to queries
tweets <-
  get_all_tweets(query=q,
                 start_tweets ="2015-11-01T00:00:00Z",
                 end_tweets ="2020-11-05T00:00:00Z",
                 n=100,
                 verbose=TRUE,
                 context_annotations=TRUE,
                 bearer_token)


Date=tweets$created_at
Text=tweets$text  
Language=tweets$lang
Source=tweets$source
ID=tweets$id
URL=paste("https://twitter.com/twitter/status",ID,sep="/")

users_id=tweets$author_id   #<100
user_df=get_user_profile(users_id, bearer_token)

Username=user_df$username # @xxx
Name=user_df$name
User_Description=user_df$description
Location=user_df$location
Profile_URL=paste("https://twitter.com",Username,sep="/")

df=data.frame(Date,Name,Username,Text,Language,Source,URL,User_Description,Location,Profile_URL)

#export data to excel 
library("writexl")
write_xlsx(df,"C://Users//user//Desktop//test.xlsx")
