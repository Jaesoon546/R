# vector : 
# 벡터의미 3대 축 : 투영(projection), 유사도(simmilarity), 가중합 
# 가격 * 판매개수 => 판매액 (Deep learning 의 행렬곱의 의미)
# 투영 : 차원 축소 (random하게 축소해도 의미) : 기준축 norm으로 나누면
# cos유사도 : 두벡터의 norm으로 나누면 유사도
a <- c(1,1,1,1,1)
b <- c(1,1,1,1,1)
sum(a*b)
(dotresult <- a%*%b)

# 피타고라스 정리 
(anorm <- sqrt(sum(a^2))) # 크기값 
(bnorm <- sqrt(sum(b^2)))
(costheta <- dotresult / (anorm*bnorm)) # 비정형 데이터를 검색 
(radianangle <- acos(costheta)) # 사람이 인식하는 각도 (radian으로 표현)
# 각도 해당되는 호의 길이(반지름이 1인 상태)
(degangle <- radianangle * 180 / pi)
# 1.207418e-06 => 0.000001207418 -> 0도 수치에러 

dot_product <- function(vec1, vec2){ # 내적 
  sum(vec1 * vec2)
}
calculate_norm <- function(vec){     # norm 크기  
  sqrt(sum(vec^2))
}
calculate_cosine_similarity <- function(vec1, vec2){ # 코사인 유사도 
  dot_product <- sum(vec1 * vec2)
  norm1 <- calculate_norm(vec1)
  norm2 <- calculate_norm(vec2)
  dot_product / (norm1 * norm2)  
}

# 다음 두 벡터의 내적, 크기, 코사인 유사도를 구하시오 
a_3d <- c(3, 1, 2)
b_3d <- c(1, 4, 5)

dot_product(a_3d, b_3d)
(a_3dn <- calculate_norm(a_3d))
(b_3dn <- calculate_norm(b_3d))
calculate_cosine_similarity(a_3d, b_3d)

# matrix
(a = matrix(1:8, nrow = 3, ncol = 3, byrow=TRUE)) # 리사이클링 -> 마지막 요소 다시 1 
matrix(1:9, nrow=3)
class(a)      # "matrix" "array"
attributes(a) # 차수 
dim(a)
colnames(a) <- c("C1","C2","C3") # 열이름 
rownames(a) <- c("R1","R2","R3") # 행이름
a["R1", "C1"] # matrix 인덱싱 
a["R1",]

# 사이즈가 다를 때는 list를 사용 
(x <- matrix(1:12, nrow = 3, ncol=4, dimnames = 
               list(c("X","Y","Z"), c("A","B","C","D"))))

y <- matrix(nrow = 2, ncol = 2) # 빈행렬 생성 
y[1,2]
y[1,1] <- 1
y[2,1] <- 2
y[1,2] <- 3
y[2,2] <- 4
# y[3,3] <- 100 인덱스 에러
y

cbind(c(1,2,3), c(4,5,6)) # column 기준 합치기 열 
rbind(c(1,2,3), c(4,5,6)) # row 기준 합치기 행 

(x <- c(1,2,3,4,5,6))
dim(x)
(dim(x) <- c(2,3))
# 다음 데이터를 rbind 와 cbind로 배치하시요 (묶어 보시오)
(x <- matrix(1:9, nrow=3, byrow = TRUE))
(y <- matrix(11:19, nrow=3, byrow = TRUE))
rbind(x, y)
cbind(x, y)
rbind(y, x)
cbind(y, x)

(x <- matrix(1:9, nrow = 3, byrow=TRUE))
x[c(1,2), c(2,3)]
x[c(2,3),]
x[,]        # 전부다 
x[-1,]      # 1행을 제외하고 
(a <- x[1,])
class(a)    # integer 
(a <- x[1,,drop=FALSE]) # matrix 성질을 유지하려면 drop=FALSE
class(a)    # "matrix" "array" 

# bolleaning
x[c(TRUE, FALSE, TRUE), c(TRUE, TRUE, FALSE)]
x[c(TRUE, FALSE), c(2,3)] # recycling 
x[c(TRUE, FALSE)]         # ,가 없으면 전체를 하나의 벡터로 취급 
# 벡터로 취급하면? -> 1,4,7,2,5,8,3,6,9 => 열우선 저장 
x

x[x > 5]
x[x%%2 == 0] # 짝수면 
class(x[x>5])# matrix 성질 잊어 버림 

# 값 바꾸기 
x <- matrix(1:9, nrow = 3, ncol = 3)
(x[2,2] <- 10)
(x[x<5] <- 0)
print(x)
t(x)
cbind(x, c(1,2,3))
rbind(x, c(1,2,3))
(x <- x[1:2,])

(x <- matrix(1:12, nrow = 3, ncol = 4)) # byrow=FALSE
x %*% t(x) # 3x4 * 4x3
xt <- t(x) 
x[1,] # 1행 
xt[,1]# 1열 
x[1,] %*% xt[,1] # 행열곱 -> 내적의 연속 (1,1) 위치 내적값 
x[1,] %*% xt[,2] # (1,2) 위치 내적값 

(mdat <- matrix(seq(20,4, -2), nrow = 3, ncol = 3, byrow = TRUE,
               dimnames = list(c("a","b","c"),c("x","y","z"))))

t(mdat)
nrow(mdat)
ncol(mdat)
dim(mdat)       # 차수 
rowSums(mdat)   # 행별 합 
rowMeans(mdat)  # 행별 평균 
colSums(mdat)
colMeans(mdat)

# 행렬의 대각선의 의미는 size를 조절 
diag(1,4,4)      # 단위행렬 (항등행렬)
diag(mdat)
diag(diag(mdat)) # 대각 행렬 

# AAᵀ는 행(관측치)끼리 내적한 결과예요. 열 개수만큼 짝을 지어 곱해 더해요.
# 결과는 정방행렬 a(4x3) x at(3x4) = (4x4) 
# -> 정방행렬 -> 대칭행렬
(mdat2 <- mdat %*% t(mdat))

# 정방행렬 + 대칭행렬 -> 고유값 분해 = 고유치 + 고유백터 (공분산, 상관계수, 거리행렬)
(mdatEigen <- eigen(mdat2))
# 데이터가 가진 특성()
# "list"가 나와요. $values와 $vectors 두 요소를 가진 리스트예요.
mode(eigen(mdat2)) # $values 고유치 (분산의 크기) -> 공분산 행렬일때, $vectors 고유벡터(정직교)
mode(mdatEigen)
mdatEigen$vectors
mdatEigen$vectors[1,]
mdatEigen$vectors[2,]
mdatEigen$vectors[3,]
mdatEigen$vectors[1,] %*% mdatEigen$vectors[2,]
mdatEigen$vectors[1,] %*% mdatEigen$vectors[3,]
mdatEigen$vectors[2,] %*% mdatEigen$vectors[3,]
# 분산의 크기로 정렬해서 출력 
mdatEigen$values # 1.532618e+03 3.382449e+00 1.796933e-13 -> 분산의 크기
                 # 제1 주성분, 제2 주성분,  제3 주성분 

# 함수
# y = 10x 
solve(10, 20)

# 연립방정식 
# 2x + 3y = 5     2,3 x 5
# 3x + 5y = 6     3,5 y 6
(mdat <- matrix(c(2,3,3,5), nrow = 2, ncol = 2, byrow = TRUE))
(c = c(5,6))
solve(mdat, c)

(inv_m = solve(mdat)) # 역행렬을 구현
mdat %*% inv_m  
inv_m %*% mdat  # 단위 행렬 
c %*% inv_m # solve(mdat, c) 와 동일 

X  <- mdat
Xc <- scale(X, center = TRUE, scale = FALSE)   # 열마다 평균 빼기

S  <- cov(X)                     # = t(Xc) %*% Xc / (nrow(X) - 1)
e  <- eigen(S)
e$values                         # 분산의 크기 (내림차순으로 정렬됨)
e$values / sum(e$values)         # 설명 비율
e$vectors[, 1]                   # 제1 주성분 방향 (x, y, z의 가중치)

scores <- Xc %*% e$vectors       # 각 관측치(a, b, c)의 주성분 점수
scores[, 1]                      # 제1 주성분 점수

prcomp(X)                        # 위 과정을 한 번에 (sdev^2 = 고윳값)

# 역행렬 : 행렬은 나눗셈이 없음 -> 역행렬구해서 곱해주면 나눗셈이 됨 
# solve -> 역행렬 
# eigen decomposition (고유값 분해) 
# -> 데이터 자체적인 특성 구조를 파악  -> 새로운 축을 발견 (분산이 가장 큰 축으로부터 작은 축으로 발견)
# 축 : 고유벡터 -> 직교, 크기값 1 (방향)
# 분산크키 : 고유치 -> 데이터가 흩어진 정도

(X <- matrix(1:4, nrow = 2, ncol = 2, byrow = FALSE, dimnames = NULL))
(Y <- matrix(5:8, nrow = 2, ncol = 2, byrow = TRUE, dimnames = NULL))
X + Y # 요소 연산 
X - Y
X * Y
X / Y
X ^ Y
2^3
2^7
rbind(X, Y)
cbind(X, Y)

# 고차 함수 
apply(X, 2, sum)  # 열로 합침 2
apply(X, 2, mean) 
apply(X, 1, mean) 
apply(X, 1, sum)  # 행으로 합침 1

apply(X, 2, max) 
apply(X, 2, min) 
apply(X, 1, max) 
apply(X, 1, min)

# 다음은 가격 데이터와 판매량 데이터이다. 이로 부터 매출액을 계산하시오 
# 가중합 
product <- c("A", "B", "C")
price <- c(1000,2000,1500)
qty <- c(10,5,8) # Quantity
(total <- sum(price * qty))
(total_w <- price %*% qty)
df <- data.frame(product, qty, price) # 벡터들의 합 : data.frame
# 열간 이질적(다른요소도 상관없음), 열내 동질적 (같은요소) 
df
df$sales <- df$qty * df$price # 실시간 추가가 가능 
df
head(df,2) # 구조 파악 

x <- c(10,20,30,40)
y <- c(6,7,8,9)
# 열이름 
data <- data.frame(width=x, height=y)
str(data)
data$width
data["width"]
data[,1]
head(data)
data$delinetr <- c(30,40,50,60)
data

d.f <- data.frame()
d.f <- edit(d.f)
d.f

######
LETTERS[1:26]
letters[1:26]
month.name[1:12]
month.abb[1:12]
pi
m
L3 <- LETTERS[1:3]
# 복원 추출 
d <- data.frame(cbind(x=1, y=1:10), fac=sample(L3, 10, replace = TRUE))
d
d$fac
names(d) # 열이름 
(d$yhat <- d$fac) # 실시간 추가 
str(d)
head(d)
d$fac <- factor(d$fac) # 범주형 변수로 변경 
rownames(d) <- c("일","이","삼","사","오","육","칠","팔","구","십")
d
class(d$fac)

#### 
# 자동벡터로 로딩 : stringsAsFactors=F
# 문자열 로딩 
x <- data.frame("SN" = 1:2, "Age" = c(21,15), "NAME" = c("에이콘", "삼성SDS"))
str(x)
x <- data.frame("SN" = 1:2, "Age" = c(21,15), "NAME" = c("에이콘", "삼성SDS"), stringsAsFactors = T)
x 
str(x)

x["NAME"]
x$NAME
class(x)
class(x$NAME) 
class(x["NAME"])   # data.frame
class(x[["NAME"]]) # factor
x[3] # 데이터프레임에서는 단독 인덱스는 열 
#####

#library(help = "datasets")
#data()
str(trees)
head(trees, n=3)
tail(trees, n=3)
trees[2:3,] 
trees[trees$Height > 82,] # filtering 
trees[10:12,2]
trees[10:12,2, drop=FALSE]# 원래 데이터 형태를 유지 (data.frame)
summary(trees)
boxplot(trees)

pairs(trees)

(data <- read.csv("schooldata.csv", blank.lines.skip = T,
                  stringsAsFactors = F, encoding = "UTF-8"))
str(data)
data$start_date <- as.Date(data$start_date)
data$salaty <- as.numeric(data$salaty)
colnames(data)
print(is.data.frame(data))
print(ncol(data))
print(nrow(data))
print(length(data))
sal <- max(data$salaty)
print(sal)

(retval <- subset(data, salaty == max(salaty)))
#install.packages("stringr") # 최초 1회 설치
library(stringr) # import
retval <- subset(data, strtrim(dept)=='회계')
print(retval)
# 2014-01-01 이후에 입사한 사람만 출력 
(retval <- subset(data, start_date >= "2014-01-01"))
write.csv(retval, "output.csv")
newdata <- read.csv("output.csv")
print(newdata)

# dataframe
# 문제1) 데이터 프레임에 영어 점수의 퀴즈, 중간, 기말 점수를 입력 
# 퀴즈 67 "C"
# 중간 92 "A"
# 기말 89 "B"
# 문제2) 수학점수를 열로 입력하고 (50,100,80)
# 문제3) 한사람에 대한 점수를 rbind 하기 
# (영어점수 90, 등급 "A", 수학점수 100)
# 문제4) 영어의 중간점수를 100점으로 수정

eng <- c(67,92,89)
grade <- c("C", "A", "B")
name <- c("퀴즈", "중간", "기말")
(data <- data.frame("영어"=eng, "등급"=grade, row.names=name))
data$"수학" <- c(50,100,80)
data

da <- data.frame("영어"=c(90), "등급"=c("A"), "수학"=c(100),
                 row.names = "보충")
(data2 <- rbind(data, da))
data["중간","영어"] = 100
data

# 열별합계를 내보기 
sum(data$영어)
# 영어 기말점수를 88점으로 변경
data$영어[3] = 88
data
# 데이터를 저장
write.csv(data, "data.csv")
# 저장한 데이터 로딩 
newdata <- read.csv("data.csv")
newdata

# 정규 분포 
x <- rnorm(400, mean = 50, sd=10) # 의사난수 seed값 
head(x)
hist(x) # 연속된 수치를 구간값으로 나누어서 카운트 

x <- runif(400, min=0, max=100) # uniform 균등분포 
hist(x)

# 영어 점수의 histogram을 그리기 
data <- newdata$영어
barplot(data, names.arg = paste0("학생", 1:3), las = 2, ylab = "점수")

