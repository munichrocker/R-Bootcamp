# Example taken from Earth Lab
# https://www.earthdatascience.org/courses/earth-analytics/get-data-using-apis/use-twitter-api-r/

# install.packages(c("tidyverse", "rtweet", "tidytext"))
library(rtweet)
library(tidyverse)
library(tidytext)

appname <- "Twitter API Wrapper Client"
key <- ""
secret <- ""
access_token <- ""
access_secret <- ""

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret
)

users <- search_users(
  "#rstats",
  n = 500
)

length(unique(users$location))

names(users)

users %>%
  count(location, sort = TRUE) %>%
  mutate(location = reorder(location, n)) %>%
  top_n(20) %>%
  ggplot(aes(x = location, y = n)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "Count",
    y = "Location",
    title = "Unique locations of Twitter #rstats users"
  )
