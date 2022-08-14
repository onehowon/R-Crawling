# URL 구성 파악
URL <- "#사이트 URL#"

# 일정 기간 동안의 여러 페이지 크롤링

URL_1 <- '#date#'
date <- #언제부터 언제까지# ex) 20200725:20200730
URL_2 <- '#page=#'
page <- #페이지 번호# ex) 1:20

for (dt in date){
  for( page_num in page ){
    URL <- paste0(URL_1, dt, URL_2, page_num)
    
    print(URL)
    }
}

# 링크 URL 수집
## F12 개발자도구 접속
## HTML 코드 살펴보면 table -> tbody -> tr -> td class -> div(id 속성값) -> div(class 속성값) -> ul(class 속성값) -> a(href 속성)

# 필수 패키지
install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)

## html_nodes : 태그가 포함한 소스코드 및 속성 추출
## html_attr : 해당 속성 값 추출
## unique : 반복 제거
URL <- ''
html <- read_html(URL)
temp <- unique(html_nodes(html, '#main_content')%>%
  html_nodes(css='.list_body') %>%
  html_nodes(css='.type06_headline')%>%
  html_nodes('a')%>%
  html_attr('href'))
  
  # 코드 종합
URL <- "#사이트 URL date까지#"
date <- #언제부터 언제까지# ex) 20200725:20200730
URL_1 <- '#page=#'
page <- #페이지 번호# ex) 1:20

new_url <- c()
new_date <- c()

for(dt in date){
  for(page_num in page){
    finding_url <- paste0(URL, URL_1, page_num)
    html <- read_html(finding_url)
    temp <- unique(html_nodes(html, '#main_content')%>%
        html_nodes(css='.list_body') %>%
        html_nodes(css='.type06_headline')%>%
        html_nodes('a')%>%
        html_attr('href'))
    new_url <- c(new_url, temp)
    new_date <- c(new_date, rep(dt, length(temp)))
    print(c(dt, page_num))
    }
 
 # 내용 가져오기
 content <- c()
 for(i in 1:length(new_url)){
  html <- read_html(new_url[i])
  temp <- repair_encoding(html_text(html_nodes(html, #articalBodyContenst')), from = 'UTF-8')
  content <- c(content, temp)
 }
 
 outcome <- cbind(date=new_date, url=new_url, content=unlist(content))
 outcome <- as.date.frame(outcome)
 
 # csv로 저장
 library(tidyverse)
 write.csv(#저장할 df#, file="이름.csv")
write.csv(#저장할 df#, file="D/경로/이름.csv")
