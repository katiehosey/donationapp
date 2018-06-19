library (RSelenium)
library(rvest)

#Open Chrome
driver <- rsDriver(browser = c("chrome"))
remDr <- driver[["client"]]
remDr$navigate("https://twitter.com/realDonaldTrump/status/1001961235838103552")

#Get random information from website
remDr$getCurrentUrl()
remDr$getTitle()
remDr$getWindowSize()

#scroll down
webElem <- remDr$findElement("css", "body")
webElem$sendKeysToElement(list(key = "end"))

#email
mailid<-remDr$findElement(using = 'css',  "[class = 'text-input email-input js-signin-email']")
mailid$sendKeysToElement(list("yadir.lakehal@ixperience.co.za"))

#password
password<-remDr$findElement(using = 'css', ".LoginForm-password .text-input")
password$sendKeysToElement(list("datascience"))

#login
login <- remDr$findElement(using = 'css',".js-submit")
login$clickElement()

#collect tweets
t <- remDr$findElements(using = 'css', '.tweet-text')
tweets=list()
tweets=sapply(t, function(x){x$getElementText()})
for(i in 1:6)
  print(tweets[i])