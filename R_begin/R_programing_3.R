# one-hot encoding 
# 선형회귀, deep learning 
# 변수 <- c(상, 중, 하,...) : 상, 중, 하 
# 상 1 0 0
# 중 0 1 0
# 하 0 0 1 
##########################################################################


x <- c(10,20,30,40,50)
sum(x)
mean(x)
var(x)                # 분산     : sum((x-mean(x))^2) / (length(x)-1)
sd(x)                 # 표준편차 
sd(x)/sqrt(length(x)) # 표준오차 : 신뢰도 표본이 많을수록 0에 가까워짐 
sd(x)/mean(x)         # 변동계수 : 단위가 다른 변수끼리 퍼짐 비교

str(mtcars) # mpg : 연비, cyl : 실린더 - 기통, disp : 배기량
            # hp : 마력, drat : 후륜비 , wt : 무게, qsec : 지정속도 도달
            # vs : 엔진형테, am : 변속기, gear : 기어(자동, 수동), carb : 기화기후

# 범주화
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
summary(mtcars$mpg)
summary(mtcars)

mean(mtcars$mpg)
median(mtcars$mpg)
var(mtcars$mpg)
sd(mtcars$mpg)
range(mtcars$mpg) # 범위 
quantile(mtcars$mpg, probs = c(0.1,0.25,0.5,0.75,0.9))

# 표준 정규분포 : 평균 -> 0, x축 표준편차 분위수 
# 왜도(좌우 균형:0), 첨도(뾰족함 정도:3)
install.packages("e1071")
install.packages("moments")
library(e1071)
skewness(mtcars$mpg)
kurtosis(mtcars$mpg)
library(moments)
skewness(mtcars$mpg)
kurtosis(mtcars$mpg)

# 데이터를 구간화 숫자를 세서 그래프화
hist(mtcars$mpg,
     breaks = 10,
     main = "MPG 분포",
     xlab = "mpg",
     col = "lightblue",
     border = "white",
     freq = FALSE)   
# 밀도함수 : 연속된 그래프 
# interpolation 보간 법 -> spline 추정 
lines(density(mtcars$mpg), col = "red", lwd = 2)

##########

iris       # petal(꽃잎), sepal(꽃받침)
head(iris)
tail(iris)
dim(iris)
length(iris)
NROW(iris)
ncol(iris)
names(iris)   # 열이름 
summary(iris) # 데이터 요약
str(iris)
class(iris)
sapply(iris, class) # 열별 타입확인 
boxplot(iris)
# 1. 숫자 열만
boxplot(iris[, 1:4], col = "lightblue", main = "iris 변수별 분포")
# 2. 품종별로 나눠서 (범주화의 진짜 쓸모)
boxplot(Petal.Length ~ Species, data = iris,
        col = c("pink", "lightgreen", "lightblue"), main = "품종별 꽃잎 길이")
##########

data(airquality)
head(airquality)
str(airquality)
# 결측치 확인
is.na(airquality$Ozone)
sum(is.na(airquality))      # 결측치 총 개수 44
colSums(is.na(airquality))  # 열합계 
colMeans(is.na(airquality)) # 비율 

barplot(colSums(is.na(airquality)),
        main = "열별 결측값 개수",
        col =  "steelblue",
        ylab = "NA 개수")
aq_complete <- airquality[complete.cases(airquality), ]
nrow(aq_complete) # 111
# 행 row : data point , 열 column : feature
aq_omit <- na.omit(airquality) # 행 제거
all.equal(aq_complete, aq_omit, check.attributes = FALSE)

# 데이터를 대입으로 결측치 처리 
aq_filled <- airquality # 주소, 복사 : 처음은 주소, 수정 후 복사 
# NA filtering -> 중위수로 대입 
aq_filled$Ozone[is.na(aq_filled$Ozone)] <-
  median(aq_filled$Ozone, na.rm = TRUE)
aq_filled$Solar.R[is.na(aq_filled$Solar.R)] <-
  mean(aq_filled$Solar.R, na.rm = TRUE)
sum(is.na(aq_filled))

##########
# 비행기 관련 정보 - 날씨 정보 
# 기본패키지, 로딩안된 패키지, 설치안된 패키지 
install.packages("nycflights13")
library(nycflights13)
weather
sum(is.na(weather))
weather = na.omit(weather)
sum(is.na(weather))

install.packages("mlbench")
library(mlbench)
data("BostonHousing", package = "mlbench")
original <- BostonHousing # 백업 

set.seed(100) # 컴퓨터 난수는 의사난수 -> 동일한 결과값 
str(BostonHousing)
sum(is.na(BostonHousing)) # NA 없음 
BostonHousing <- na.omit(BostonHousing)
# 1 ~ 506 중 40개 랜덤 (seed 100) 강제 NA 할당 
BostonHousing[sample(1:nrow(BostonHousing),40),"rad"] <- NA
BostonHousing[sample(1:nrow(BostonHousing),40),"ptratio"] <- NA
sum(is.na(BostonHousing))
sapply(BostonHousing, function(x) sum(is.na(x))) # 열별 적용
# 선형회귀 Linear model
# 종속 변수  ~ 독립 변수 (formula)
lm(medv ~ ptratio + rad, data = BostonHousing, na.action = na.omit)
#  절편         기울기       기울기 
#(Intercept)   ptratio          rad  
# 57.0465      -1.7691      -0.2032
# 선형회귀 : 최소제곱법  sigma(예측값 - 실제값)^2
fit <- lm(medv ~ ptratio + rad, data = BostonHousing, na.action = na.omit)
nobs(fit)                        # 실제로 쓰인 행 수 (506보다 적음)
sum(!complete.cases(BostonHousing[, c("ptratio", "rad")]))   # 빠진 행 수
summary(fit)
# 1행 
(medv = -1.7691*15.3+ -0.2032*1 + 57.0465)
# 2행 
(medv = -1.7691*17.8+ -0.2032*2 + 57.0465)
head(BostonHousing)
fit <- lm(medv ~ ptratio + rad, data = BostonHousing)
predict(fit, newdata = data.frame(ptratio = 17.8, rad = 2))      # 약 25.15
# 여러 지역을 한 번에
new <- data.frame(ptratio = c(14, 17.8, 21), rad = c(2, 2, 24))
predict(fit, newdata = new)
# 예측 구간까지
predict(fit, newdata = data.frame(ptratio = 17.8, rad = 2), interval = "prediction")

# 범주화 
#install.packages("ggplot2")
library(ggplot2)
library(MASS)

str(Cars93)
hist(Cars93$MPG.highway) # 연속, 자동 범주화, 카운트
disc_1 <- Cars93[,c("Model", "MPG.highway")]
head(disc_1)
within(Cars93, {MPG.highway >= 20 & MPG.highway < 25}) 
range(disc_1["MPG.highway"])

disc_1 <- within(disc_1, {                     # ← 결과를 왼쪽에서 받음
  MPG.highway_cd <- character(0) # 초기화      # ← 대입은 { } 안에서
  MPG.highway_cd[MPG.highway >= 20 & MPG.highway < 25] <- "20~25"
  MPG.highway_cd[MPG.highway >= 25 & MPG.highway < 30] <- "25~30"
  MPG.highway_cd[MPG.highway >= 30 & MPG.highway < 35] <- "30~35"
  MPG.highway_cd[MPG.highway >= 35 & MPG.highway < 40] <- "35~40"
  MPG.highway_cd[MPG.highway >= 40 & MPG.highway < 51] <- "40~50"
  MPG.highway_cd <- factor(MPG.highway_cd,
                           levels = c("20~25", "25~30", "30~35", "35~40", "40~50"))
})

head(disc_1)
table(disc_1$MPG.highway_cd)        # 도수분포표 
sum(table(disc_1$MPG.highway_cd))   # 93
sum(is.na(disc_1$MPG.highway_cd))   # 0 → 빠진 차 없음

tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd,sum)
tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd,mean)
tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd,sd)

# 다차원으로 데이터 표현 
# 미적요소 aes : y축은 카운트 , fill 컬러로 구분 
# 2차원을 컬러값, 선스타일, 모양 등을 이용해서 다차원 

# 1. 구간별 차종 수 (막대그래프)
ggplot(disc_1, aes(x = MPG.highway_cd, fill = MPG.highway_cd)) +
  geom_bar()
# 2. 점그림: x에는 연속값(연비), 색으로 구간 표시
ggplot(disc_1, aes(x = MPG.highway_cd, fill = MPG.highway_cd)) +
  geom_dotplot(binwidth = 0.3)

# 3. 점그림: x에는 연속값(실제 연비), 색으로 구간 표시
ggplot(disc_1, aes(x = MPG.highway, fill = MPG.highway_cd)) +
  geom_dotplot(binwidth = 1)

##########
# one-hot-encoding 
cust_id <- c("대한","민국","만세","영원","무궁","발전","행복")
cust_id <- factor(cust_id)
age <- c(25,45,31,30,49,53,27)
cust_profile <- data.frame(cust_id, age, stringsAsFactors = F)
cust_profile
# 데이터 추가 변경 
cust_profile <- transform(cust_profile,
                          age_20 = ifelse(age>=20 & age<30,1,0),
                          age_30 = ifelse(age>=30 & age<40,1,0),
                          age_40 = ifelse(age>=40 & age<50,1,0),
                          age_50 = ifelse(age>=50 & age<60,1,0))
cust_profile

#구간이 많아지면 간편화 
#age_grp <- cut(cust_profile$age, breaks = c(20, 30, 40, 50, 60),
#               labels = c("20", "30", "40", "50"), right = FALSE)
#onehot <- model.matrix(~ age_grp - 1)       # - 1 : 절편 없이 모든 범주를 열로
#onehot
#cbind(cust_profile[, 1:2], onehot)          # 위 결과와 같은 값

##########
# 정규화 (normalization)
data(mtcars)
std_scale <- function(x){ # x에는 벡터가 입력 
  (x - mean(x)) / sd(x)
}
(std_scale(mtcars$mpg))   # 정규분포는 무한대 (확률희박)

z_mpg <- scale(mtcars$mpg)# z 점수 정규화 
typeof(z_mpg)
class(z_mpg)
dim(z_mpg)
round(mean(z_mpg), 10)
round(sd(z_mpg), 10)

scaled_mtcars <- as.data.frame(scale(mtcars)) # 캐스팅 해야 data.frame
typeof(scaled_mtcars)
round(colMeans(scaled_mtcars), 10)

# min-max 정규화 
# 최소값은 0으로 최대값은 1로 변환 
minmax <- function(x) (x - min(x)) / (max(x) - min(x))
mtcars$mpg_norm <- minmax(mtcars$mpg)
range(mtcars$mpg_norm)

# list로 리턴하는 lapply
# iris 150 x 5 factor는 제외 
iris_norm <- as.data.frame(lapply(iris[,1:4], minmax)) # 함수 이름만 전달 
apply(iris_norm, 2, range)

# robust
robust_scale <- function(x) {
  (x - median(x)) / IQR(x)
}
(robust_mpg <- robust_scale(mtcars$mpg))
median(robust_mpg)   # 0
IQR(robust_mpg)      # 1

# 문제 iris 데이터에 대해서 min_max 정규화를 적용한 데이터 프레임을 작성 
#iris_norm <- as.data.frame(lapply(iris[,1:4], minmax)) 
#sapply(iris_norm, range)
min_max_norm <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

lapply(iris[1:4], min_max_norm)
iris_norm <- as.data.frame(lapply(iris[1:4], min_max_norm))
head(iris_norm, 3)
iris_norm$Species <- iris$Species
str(iris_norm)
head(iris_norm, 3)
par(mfrow = c(1, 2))
boxplot(iris[, 1:4], main = "원본")
boxplot(iris_norm[, 1:4], main = "MinMax 후")
par(mfrow = c(1, 1))

# 이상치 처리 
data(mtcars)
Q1 <- quantile(mtcars$mpg, 0.25)
Q3 <- quantile(mtcars$mpg, 0.75)
IQR_val <- IQR(mtcars$mpg)
lower <- Q1 - 1.5*IQR_val
upper <- Q3 + 1.5*IQR_val
cat("하한:", lower, "상한:", upper,"\n")
outlier_iqr <- mtcars$mpg[mtcars$mpg < lower | mtcars$mpg > upper]
cat("IQR 이상치:", outlier_iqr,"\n")

# 3 sigma (표준편차 3배수로 넘어서면 이상치)
boxplot(mtcars$mpg,
        main = "MPG Boxplot",
        col = "salmon",
        ylab = "마일리지")
boxplot.stats(mtcars$mpg)$out

# 3sigma 이상치 확인
mu <- mean(mtcars$mpg)
sig <- sd(mtcars$mpg)
outlier_3s <- mtcars$mpg[abs(mtcars$mpg - mu) > 3 * sig]
cat("3σ 이상치:", outlier_3s,"\n")

boxplot(mtcars[, c("mpg","disp","hp","wt")],
        main = "mtcars 변수별 분포",
        col = rainbow(4))
###########
data("iris")      # 150x5 (specis종)
boxplot(iris)
re<-boxplot(iris)
re
# boxplot 정보 
# $stats 통계 (min, 1quantile, median , 3quantile, max)
# n : 개수
# conf : confidence 신뢰구간 
# out : 이상치 
# group수 
# names : 열이름 
# re$stats[3, 1]               # 5.8
# median(iris$Sepal.Length)    # 5.8   ← 같음
# mean(iris$Sepal.Length)      # 5.843 ← 다름
re$out       
# 문제 : 결측치의 개수를 확인 
# 결측치를 Sepal.width의 평균값으로 대체 
data(iris)
re <- boxplot(iris$Sepal.Width, plot = FALSE)     # 이상치 찾기
iris$Sepal.Width[iris$Sepal.Width %in% re$out] <- NA
summary(iris$Sepal.Width)                         

# 문제 1: 결측치 개수 확인
sum(is.na(iris$Sepal.Width))                       # 4

# 문제 2: 평균값으로 대체
m <- mean(iris$Sepal.Width, na.rm = TRUE)          # 3.040411
iris$Sepal.Width[is.na(iris$Sepal.Width)] <- m
sum(is.na(iris$Sepal.Width))    

##########
#install.packages("Hmisc")
library(Hmisc)
data(iris)
iris$Sepal.Width <- impute(iris$Sepal.Width, median)
sum(is.na(iris))

# ?fivenum number summary (minimum, lower-hinge, median, upper-hinge, maximum) 
# 중앙값을 선정 : 왼쪽 반, 오른쪽 반중에 중위수 
data(iris)
fivenum(iris[,1], na.rm = TRUE)

outdata <- iris[1:4]
ncol(outdata)
for(i in 1: (ncol(outdata))){ # 1열, 2열, 3열 . 4열 
  uppercut=fivenum(outdata[,i], na.rm=T)[4]+1.5*IQR(outdata[,i], na.rm = T)
  lowercut=fivenum(outdata[,i], na.rm=T)[2]-1.5*IQR(outdata[,i], na.rm = T)
  outdata<- outdata[outdata[,i] <= uppercut & outdata[,i] >= lowercut,]
  #outdata<- outdata[whith(outdata[,i] <= uppercut & outdata[,i] >= lowercut),] NA가 있을때는 안전하게 
  }
str(outdata)
# 원본 기준으로 한번 판별 
#keep <- rep(TRUE, nrow(iris))
#for (i in 1:4) {
#  x <- iris[, i]
#  f <- fivenum(x, na.rm = TRUE); iqr_h <- f[4] - f[2]
#  keep <- keep & x >= f[2] - 1.5 * iqr_h & x <= f[4] + 1.5 * iqr_h
#}
#outdata2 <- iris[keep, ]       # Species도 함께 유지
#nrow(outdata2)  

############
# attach  / detach
# 패키지 내에서 이름 충돌 
# :: 패키지 소속 
weather <- nycflights13::weather
search()           # 로딩된 패키지 출력  
attach(weather)    # 데이터를 패키지 처럼 사용 
search()           # 2번째에 "weather"가 보임
names(weather)
str(weather)
length(temp) # 26115
IQR(temp, na.rm=T)
median(temp, na.rm = T)
upper <- quantile(temp, 0.75,na.rm=T) + 1.5 * IQR(temp, na.rm = T)
lower <- quantile(temp, 0.25,na.rm=T) - 1.5 * IQR(temp, na.rm = T)
weather <- weather[temp < upper, ]
weather <- weather[temp > lower, ]
length(temp) # 26115
mean(temp, na.rm = TRUE)   # weather$ 없이 열 이름만으로 사용 가능
detach(weather)    # 메모리에서 해제 
search()   

############
library(MASS)
data(birthwt, package = "MASS")
str(bwt)
bwt <- birthwt
str(bwt)
sum(is.na(bwt))
names(bwt)
# "low"  저체중 
# "age"  나이 
# "lwt"  임산부의마지막 체중            
# "race" 인종   1, 2, 3
# "smoke"흡연여부  0, 1
# "ptl"  과거조산횟수
# "ht"   산모의 고혈압 0, 1  
# "ui"   자궁과민성 0, 1 
# "ftv"  임신 1분기 방문횟수 
# "bwt"  신생아 체중 

boxplot(bwt$age, main = "Boxplot 나이")
boxplot(bwt$bwt, main = "마지막 체중")
bwt_clean <- subset(bwt, age <= 50)
upper_limit <- quantile(bwt$bwt, 0.99) # 상위 1% 이상치 
bwt$bwt[bwt$bwt > upper_limit] <- median(bwt$bwt)
Q1 <- quantile(bwt$bwt, 0.25)
Q3 <- quantile(bwt$bwt, 0.75)
IQR_val <- Q3 - Q1
upper_bound <- Q3 + 1.5 * IQR_val
bwt$bwt[bwt$bwt > upper_bound] <- NA
bwt$bwt[is.na(bwt$bwt)] <- median(bwt$bwt, na.rm=TRUE)
# 저체중 범주화 : 정상, 저체중 
unique(bwt$low)
bwt$low <- factor(bwt$low, levels = c(0,1), labels = c("Normal", "Low"))
bwt$race <- factor(bwt$race, levels = c(1,2,3),
                   labels = c("white","Black","Other"))
bwt$smoke <- factor(bwt$smoke, levels = c(0,1), labels = c("No", "Yes"))
bwt$ht <- factor(bwt$ht, levels = c(0,1), labels = c("No", "Yes"))
bwt$ui <- factor(bwt$ui, levels = c(0,1), labels = c("No", "Yes"))
str(bwt)
summary(bwt)
hist(bwt$bwt, main="출생 체중", xlab = "Birth Weight (g)")
plot(bwt$age, bwt$bwt, main = "산모나이와 출생체중", xlab = "나이",
     ylab = "출생체중 (g)")

###########
state_table <-
  data.frame( key=c("SE", "DJ", "DG", "SH", "QD"),
              name=c("서울", "대전", "대구", "상해", "칭따오"),
              country=c("한국", "한국", "한국", "중국", "중국"))
state_table
#state_table$name <- trimws(state_table$name)   # 앞뒤 공백 제거
# 월별 판매 데이터 - 분기 
month_table <-
  data.frame(key=1:12,
             desc=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                    "Aug", "Sep", "Oct", "Nov", "Dec"),
             quarter=c("Q1","Q1","Q1","Q2","Q2","Q2","Q3","Q3","Q3",
                       "Q4","Q4","Q4"))
month_table

prod_table <-
  data.frame(key=c("Printer", "Tablet", "Laptop"),
             price=c(225, 570, 1120))
prod_table
(prod_table1 <- data.frame(Printer=225,Tablet=570, Laptop=1120 ))
(prod_table1 <-t(prod_table1))

# 판매 기록(사실 테이블) 생성 함수 / no_of_recs : 생성할 판매 건수
gen_sales <- function(no_of_recs) {
  loc <- sample(state_table$key, no_of_recs, replace=TRUE, prob=c(2,2,1,1,1))
  time_month <- sample(month_table$key, no_of_recs, replace=TRUE)
  time_year <- sample(c(2012, 2013), no_of_recs, replace=TRUE)
  prod <- sample(prod_table$key, no_of_recs, replace=TRUE, prob=c(1,3,2))
  unit <- sample(c(1,2), no_of_recs, replace=TRUE, prob=c(10,3))
  price_map <- setNames(prod_table$price, prod_table$key)
  amount <- unit * price_map[prod]  
  sales <- data.frame(
    month=time_month,
    year=time_year,
    loc=loc,
    prod=prod,
    unit=unit,
    amount=amount
  )
  # 정렬 
  sales <- sales[order(sales$year, sales$month),]
  row.names(sales) <- NULL  
  return(sales)
}
set.seed(500)
(sales_fact <- gen_sales(500))
str(sales_fact)
head(sales_fact)
tail(sales_fact)
#############
sum(sales_fact$amount)
sd(sales_fact$amount)
sd(sales_fact$unit) / sqrt(length(sales_fact$unit)) # 표준오차
sd(sales_fact$amount)/mean(sales_fact$amount) # 변동계수 
# 지역별 총 판매 수량과 총 판매액 구하기 
aggregate(unit ~ loc, data=sales_fact, sum)
aggregate(cbind(unit, amount) ~ loc, data = sales_fact, sum)

# 상품(prod)별 평균 판매 수량과 평균 판매액 구하기 
# 상품으로 그룹핑을 해서 평균 판매 수량과 평균 판매액 
aggregate(cbind(unit, amount) ~ prod, data = sales_fact, mean)

# 연도별 판매액의 합계와 평균 구하기 
aggregate(amount ~ year, data = sales_fact, sum)
aggregate(amount ~ year, data = sales_fact, mean)

# 월(month) 별 판매수량의 평균을 구하고, 어느 달이 가장 높은지 구하시오 
month_avg <- aggregate(unit ~ month, data = sales_fact, mean)
max(month_avg$unit)
month_avg[which.max(month_avg$unit), ]

# 다차원 array로 데이터를 표현 (차원별로 출력)
# apply(행과 열지정), sapply(벡터, 행렬 로 리턴), lapply(결과를 리스트로 출력)
# tapply(그룹핑)
# 4차원 
(revenue_cube <-
    tapply(sales_fact$amount,
           sales_fact[,c("prod","month","year", "loc")],
           FUN=function(x){return(sum(x))}))
names(revenue_cube)   # 열이름 (data.frame : 2차원)
dimnames(revenue_cube)# 다차원 배열
revenue_cube
revenue_cube[c("Tablet","Laptop"), , ,]
# 제품별로 판매현황 # 제품 . 그룹, 판매 대상 
tapply(sales_fact$amount,
       sales_fact[,c("prod")],
       FUN = function(x){return(sum(x))})
# 년도별 지역별 판매액 확인 
year_loc <- tapply(sales_fact$amount,
          sales_fact[,c("year","loc")],
          FUN=function(x){return(sum(x))})

# year_loc 결과 데이터 중에서 2012년도 서울의 판매현황을 출력 
year_loc["2012","SE"]
revenue_cube[,,c("2012"),c("SE")] # R에소는 기본이 벡터 
revenue_cube[, ,"2012","SE"]
# na.rm = TRUE -> NA 대비 
# 1. 서울(SE)에서 Printer(Printer)의 2013년 총 판매량(unit) 
se_P_unit <- tapply(sales_fact$unit,
        sales_fact[,c("loc","prod","year")],
        FUN = function(x){return(sum(x))})
se_P_unit["SE","Printer","2013"]
# 2. 모든 지역(loc)에서 Tablet(Tablet)의 2012년 총 판매랑(unit)
tloc_unit <- tapply(sales_fact$unit,
                      sales_fact[,c("loc","prod","year")],
                      FUN = function(x){return(sum(x))})
tloc_unit[,"Tablet","2012"]
sum(tloc_unit[,"Tablet","2012"])
# 3. 대구(DG)에서 가장 많이 팔린 상품(prob)과 그 판매 금액(amount)
dg_loc_prod <- tapply(sales_fact$amount,
                   sales_fact[, c("loc", "prod")],
                   FUN = sum)
dg_loc_prod                         
dg <- dg_loc_prod["DG", ]  
names(which.max(dg))             
max(dg)     
dg[which.max(dg)]    

