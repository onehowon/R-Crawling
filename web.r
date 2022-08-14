
# 첫번째 페이지 주소를 url로 설정하고 readLine 함수를 통해 불러와야함
url <- ""
web <- readLines(url, encoding = "UTF-8")

head(web, 30) # head로 잘 불러왔는지 확인하고

## 특정 게시글 제목 일부분 복사해서 페이지 소스 보기에서 Ctrl+F로 복사한 부분 찾기
## 제목이 있는 line에 대한 규칙 찾기

library(stringr)
web[str_detect(web, "#제목이 들어간 소스코드#")]
web_notag <- web[str_detect(web, "#제목이 들어간 소스코드#")]
gsub("#tag코드#","",web_notag)
web_clean <- gsub("#쓸모 없는 부분#", "", web_notag)

main_web <- gsub("\t", "", web_clean)
main_web
