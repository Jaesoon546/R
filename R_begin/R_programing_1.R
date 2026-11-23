# R = 함수형 프로그램 + 일반화 프로그래밍 => 함수 베이스로 작동 
# 데이터의 기본 처리 단위는 vector, 기본 데이터 타입은 Double
# 기본 자료구조는 data.frame 

x_num <- 3.14
x_num

(x_num <- 3.14)     # double 
(x_int <- 5L)       # Integer
(x_chr <- "Hello R")# character 
(x_lgl <- TRUE)     # logical
(x_cpx <- 2 + 3i)   # complex 복소수 (크기와 방향을 표시)

# 변수의 타입 
# 함수가 일급객체 : 함수의 매개변수, 함수의 리턴값, 변수에 대입 
class(x_num)        # numeric (숫자) : double, Integer
typeof(x_int)       # integer
is.numeric(x_num)   # type check
is.character(x_chr) #.도 이름으로 사용가능
is.logical(x_lgl)

# 타입변환
as.integer(3.7)
as.numeric("3.14")
as.character(100)
as.logical(0)
as.logical(1)
as.logical("TRUE")

# 계산식 
5 + 3
10 / 4
2 ^ 8
sqrt(144)
log(100, base = 10) # 큰수를 간단하게 표현할 때 

# 변수 할당 
x <- 42
y <- 3.14
z <- "Hello, R!"
cat("x =", x, " y =", y, "\n")

# 관계 연산자
x <- 5
y <- 16
x < y   # TRUE
x > y   # FALSE
x <= 5  # TRUE
y >= 20 
y == 16 # TRUE
x != 5  # FALSE

# combine -> vector를 생성할때 사용 
# vector는 동질적 데이터
# 자동형 변환 -> 보다 큰 데이터 타입으로 (logical -> integer -> double -> 문자)
# TRUE -> 1, FALSE -> 0
(x <- c(TRUE, FALSE,0,6,5L, 3.1, "A"))
# R은 기본이 vector, vector가 모이면 axtrix, array 
# 열간 이질, 열내 동질 -> 데이터프레임 data.frame 
(x <- c(TRUE, FALSE,0,6))
typeof(x)
class(x)
# 벡터화 연산에 의해서 모든 데이터가 1씩 증가
x + 1 
x # original을 보호 
x <- x + 1
x   # 숫자  
!x  # NOT => vector를 부정 : 숫자는 부정이 0
# broadcasting
x&y # AND : javascript에서는 && TRUE TRUE TRUE TRUE
x|y # OR 
# 파이썬에서는 뒤에 숫자가 제외 (0부터 시작)
# 인덱스에서 주의 (뒤의 숫자가 포함) : R은 1부터 시작  
v <- 2:8
print(v)

v1 <- 8
v2 <- 12
t <- 1:10
v1 %in% t # 포함 연산자 %%
print(v1 %in% t)
print(v2 %in% t)

# 행렬 : row=행, column=열 
# 만들 때는 행우선, 저장된 것은 열우선 (R의 행렬은 열우선으로 저장)
(M <- matrix(c(2,6,5,1,10,4), nrow <- 2, ncol <- 3, byrow=TRUE))
# recycling
# (M <- matrix(c(2,6,5,1), nrow <- 2, ncol <- 3, byrow=TRUE))
# 넘치면 제거
# (M <- matrix(c(1,2,6,5,1,10,4,1,2), nrow = 2, ncol = 3, byrow =TRUE))
# (M <- matrix(c(1,2,6,5,1,10,4,1,2), nrow = 2, ncol = 3)) # byrow = FALSE 디폴트값 
(M <- matrix(c(1,2,6,5,1,10,4,1,2), nrow = 3, ncol = 3, byrow =TRUE)) 
dim(M)    # 차수 
dim(t(M)) # transpose 전치 (행과 열을 바꿈)
# 무조건 행렬은 메모리에 열 우선으로 저장 

# 행렬 곱 연산자  (형태 : 앞에 있는 행렬의 열수와 뒤에 있는 행렬 행수가 일치)
# t = M %*% M  -> 2x3행렬, 2x3행렬 행렬곱 불가
t = M %*% t(M) # 2x3행렬, 3x2행렬
t
# 행렬 곱은 내적 연산의 연속이다. 
# 내적 : 요소끼리 곱한 다음 다 더해주면 (벡터의 사이즈가 같아야 됨)

# R 에는 scalar 값이 없음 => 내부적으로는 벡터 
c(1,3,5,7,9) * 2        # (2,2,2,2,2)
c(1,3,5,7,9) * c(2,4)   # (2,4,2,4,2)
C(1,3,5,7,9,10) * c(2,4)
c(2,4) * c(1,3,5,7,9,10)# recycling

(data = 1:5)
factorial(1:5)
1*2*3*4*5 
sum(data) #vector
prod(data)

# 중심값 
mean(data)  # 산술 평균 : 이상치에 영항을 많이 받음 
median(data)# 중앙값 : 통계학에서는 중앙값을 선호 
vec <- c(1,2,3,4,5,100)
mean(vec)
median(vec)

var(vec) # 분산 : 평균을 중심하고 값이 얼마나 흩어져 있나. (부호를 뗴기위해 제곱한 값)
sd(vec)  # 표준편차 : 분산의 루트 

cumsum(data) # 누적합
cumprod(data)# 누적곱 (culmulative product)

data^2 # 모든 요소를 제곱 

# 정규화 [1,2,3,4,5] : 15
data / sum(data)
sum(data / sum(data))
# 정규화된 값을 다 더하면 1 

diff(data) # 데이터 사이 간 차 

#exp 
exp(1)    # 자연대수 
exp(2)
exp(2:10)
log(exp(1))

# 삼각함수
# 삼각함수는 반지름이 1일 때를 기준으로, 회전과 반복주기 계산 
cos(c(0, pi/4))   # 45도 일 때의 밑변 / 빗변 
                  # sin = 높이 / 빗변 
sqrt(c(1,4,9,16))
sum(1:10)
exp(0.1*10)

# 범주형 데이터 factor 
# 일반화 되어 있음 - 함수형 프로그래밍 
seasons <- factor(c("봄", "여름", "가을", "겨울", "봄", "여름"))
levels(seasons)  # "가을" "겨울" "봄"   "여름" => 범주 
nlevels(seasons)
table(seasons)   # 도수 분포표 

# 순서있는 범주 - 관계 연산자가 동작 
size <- factor(c("소","중","대","소"),
               levels = c("소","중","대"), # 작은 수 -> 큰 수
               ordered = TRUE)
size[1] < size[3]
size[2] > size[1]
size[2] > size[3] # FALSE

# 범주형 
gender <- c('M', 'F', 'M', 'F', 'M')
gender
class(gender)
plot(gender) # 시각화 불가능 

fgender <- as.factor(gender) # factor 형으로 변환 
fgender 
fgender[3]
levels(fgender)
plot(fgender)

# 결측치 (NA) , not a number, infinite
sum(c(1,2,NA,3))
1 / 0     # 컴퓨터는 0으로 나누면 안됨 => Inf 
0 / 0     # not a number 
Inf / NaN # not a number 
Inf / Inf # not a number 
log(Inf)  # Inf
Inf + NA  # NA 

# R 에서 함수 만들기 
# 연산자 함수는 % 처리 
`%divisible%` <- function(x,y)
{
  if(x%%y == 0) return(TRUE)
  else          return(FALSE)
}
10 %divisible% 3
10 %divisible% 2
`%divisible%`(10,5)

`my variable` <- 10 # 공백도 변수 ``(사용시)

# 기술통계 
score <- c(85,95,75,65)
score
mean(score)
sum(score)

var(score)
sd(score)
score - 80
sum(score - 80)
(score - 80)
# 모집단(시간, 비용이 많이 들기 때문에) -> 표본(sampling) 
# 에너지 센서스 -> 일부 표본만 이용 
# 표본으로 부터 모집단을 이해 
# 표본의 평균으로 모집단의 평균을 추정 (점추정)
# 구간추정 : 표준오차 80 - 1.96 * 표준오차 ~ 80 + 1.96 * 표준오차
sum((score - 80)^2)/3    # n-1 자유도로 (표본일때는)
sqrt(sum((score-80)^2)/3)# 표준편차 
# 68 ~ 92 사이에 값들이 있는지 대략 짐작 가능 : 실력이 차이가 난다 
# 0 : 실력이 균등 

x <- c(10,20,30,'40')
mode(x)
typeof(x)
(xx <- as.numeric(x))
mode(xx)

Sys.Date()
Sys.time()
# 날짜 -> 문자열로 입출력 , 계산은 수식 
today <- '2026-11-23 16:01:27'
today 
class(today)
typeof(today)

today2 <- as.Date(today)
today2
class(today2)
ctoday <- strptime(today, '%Y-%m-%d %H:%M:%S')
ctoday
class(ctoday)

help("mean")
?sum 
args(sum)
example(sum)

getwd() # working directory 
setwd("C:\\Users\\test\\Desktop\\R_js")
getwd()
# R 의 특징은 in memory 데이터가 메모리에 있어야 한다 
# 분산처리 - spark(메모리 기반 분산처리)
# hadoop 파일 기반 분산처리 
ls()
rm(list=ls())
ls()

x <- 1:10
x 
y <- 100:200
y 
setwd("C:\\Users\\test\\Desktop\\R_js")
save(x,y, file='xy.RData')
rm(list=ls())
ls()
load('xy.RData')
ls()

# indexing
a = c(1,2,3) # 인덱스가 0부터 시작 
a[2]
(b = 1:10)
b[2]
# 파이썬 -> error , R -> NA로 처리 
b[c(2,3,4,100)]  # 벡터 인덱싱 

x <- c(1:9)
x
x[3]
x[c(2,4)]     # 벡터 인덱스 
x[-1]         # 음수 : 제외하고 
x[c(2,-4)]    # 혼용하면 안됨 
x[c(-2,-4)]
x[c(2.4,3.54)]# 내림으로 처리 
#  1     2     3      4     5      6      7     8    9
#TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE,TRUE
x[c(TRUE, FALSE, FALSE, TRUE)] # Boolean indenxing 
x[x<3] # 관계연산자로 boolean indexing (if filtering)
x[x>3]

# vector는 행과 열이 없음
x <- c(1, 5, 4, 9, 0)
length(x) # 개수 
NROW(x)   # 행 
NCOL(x)   # 열 

# python = range
# 간격 
seq(1,3.2, by=0.2)
# 균등분할 
seq(1,5, length.out=4)
seq(1,6, length.out=4)

# 문제 1 : 3.2에서 1사이의 값을 0.2 간격으로 출력 
seq(3.2, 1, by=(-0.2))

# repeat
(b <- rep(1:4,2))
(d <- rep(1:3, each=3))
(d <- rep(1:3,2, each=3)) # 각각이 우선 

# which 
x <- c(10,20,30,40)
y <- c("대한","독립","만세","영원")
which(x > 20)   # 인덱스 3 4 로 출력
# x값이 20보다 큰 데이터의 이름을 알고 싶다.
y[which(x > 20)]# x,y가 1:1로 매핑되어 있을때 
x[which(x > 20)]
which.max(x)    # 가장큰 인덱스 
which.min(x)    # 가장 작은 인덱스 

v1 <- c(10,20,30,40,50)
length(v1)
# 요소에 이름주기 
names(v1) <- c("a","b","c","d","e")
v1
any(v1 > 45)  # 하나라도 있으면 TRUE
all(v1 > 0)   # 모든요소가 조건을 만족하면 TRUE
which(v1 > 25)

subset(x, x>20)
# 열간 이질성, 열내 동질성 
# 열이름과 데이터로 구성 
df <- data.frame(
  name = c("A", "B", "C"),
  score = c(80,90,70)
)
subset(df, score > 75)

# rep, seq 등
#1) vector1 벡터 변수를 만들고, "R" 문자가 5회 반복되도록 하시오 
#2) vector2 벡터 변수에 1 ~ 20까지 3간격으로 연속된 정수를 만드시오
#3) vector3 에는 1 ~ 10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오
#4) vector4 에는 vector2 ~ vector3 모두 포함되는 벡터를 만드시오 
#5) 25 ~ -15까지 5 간격으로 벡터 생성 - seq() 함수 이용 

vector1 <- rep(c("R"),5)
vector1
vector2 <- seq(1,20, by=3)
vector2
vector3 <- rep(seq(1,10, by=3),3)
vector3
vector4 <- append(vector2, vector3)
vector4
seq(25, -15, by=-5)
