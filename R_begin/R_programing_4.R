#install.packages("tidyverse")
library(tibble)
df_base <- data.frame(x = 1:3, y = c("a","b","c")) #열중심
tb_mod <- tibble(x = 1:3, y = c("a","b","c"))      #열중심

class(df_base)
class(tb_mod)
class(df_base[,1])   # "integer"
class(tb_mod[,1])    # tibble 
class(tb_mod[[1]])   # "integer"
as.data.frame(tb_mod)# 순수 데이터 테이블 변환 

#############
x <- c(10,20,30)
a <- sqrt(x)
b <- log(a)
# 함수의 매개변수 함수를 전달 -> 고차 함수 
# 함수베이스 언어인 R은 첫번째 매개변수가 다 데이터 
mean(log(sqrt(x))) # classic한 타임 

x %>%  # 연결 
  sqrt() %>%
  log() %>%
  mean()

a %>% sin(.) # 이전의 데이터가 .이 있는 영역으로 전달 
x |> sqrt() |> log() |> mean()
a |> sin(_)
###############################
library(tidyverse)
df <- tibble(
  name = c("Kim", "Lee"),
  math_mid = c(80,70),
  math_final = c(90,85),
  eng_mid = c(75,88),
  eng_final = c(82,91)
)
df
library(tidyr) 
df_long <- df |>
  pivot_longer(
    cols = -name,              # R에서 -의 의미, 제외하고 name을 제외한 모든 열을 세로로 내림
    names_to = "subject_exam", # 원래 열 이름이 들어갈 새 열
    values_to = "score"        # 원래 칸의 값이 들어갈 새 열
  )
df_long

df_sep <- df_long |>
  separate(
    col = subject_exam,
    into = c("subject", "exam"),
    sep = "_" # seperator 분리자 
  )
df_sep

df_unite <- df_sep |>
  unite(
    col = "subject_exam",
    subject, exam,
    sep = "_",
    remove = FALSE # subject, exam 삭제 x 
  )
df_unite

df_wide_math <- df_sep |> 
  filter(subject == "math") |> # 조건 
  pivot_wider( # 재구성
      id_cols = c(name, subject),
      names_from = exam,  # exam의 데이터를 열이름으로 
      values_from = score 
    )
df_wide_math

df_long <- df |>
  pivot_longer(
    cols = -name,
    names_to = "subject_exam",
    values_to = "score"
  ) |> 
  separate_wider_delim(
    cols = subject_exam,
    delim = "_",
    names = c("subject", "exam")
  ) |>
  mutate(# 범주형 변환 + 순서 지정 (기존 열 덮어쓰기)
      exam = factor(exam, levels = c("mid", "final")),
      subject = factor(subject, levels = c("math", "eng"))
    )
df_long

library(ggplot2)
# aes 미적요인
# geom_text의 position_dodge(width = 0.7)	막대와 같은 간격이어야 숫자가 막대 위에 정확히 올라감
# vjust = -0.4	숫자를 막대 꼭대기보다 살짝 위로
# limits = c(0, 105)	91점 위 숫자 라벨이 잘리지 않게 여유
# expansion(mult = c(0, 0.05))	막대가 바닥(0)에 딱 붙게 아래 여백 제거
# as_labeller()	패널 제목을 math → "수학 (Math)"로 바꿈
ggplot(df_long, aes(x = exam, y = score, fill = name)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(aes(label = score),
            position = position_dodge(width = 0.7),
            vjust = -0.4, size = 3.5) +
  facet_wrap(~ subject,
             labeller = as_labeller(c(math = "수학 (Math)", eng = "영어 (English)"))) +
  scale_y_continuous(limits = c(0, 105), expand = expansion(mult = c(0, 0.05))) +
  labs(title = "학생별 과목 시험 점수 비교",
       x = "시험 구분", y = "점수", fill = "학생") +
  theme_minimal() # 최대한 간결한 테마로 지정 

ggplot(df_long, aes(x = exam, y=score, color=name, group = name)) +
  geom_line(linewidth = 1)+
  geom_point(size = 3) + 
  facet_wrap(~subject) + # subject 기준으로 화면분할 
  scale_y_continuous(limits = c(60,100)) +
  labs(
    title = "중간고사 대비 기말고사 점수 추이",
    x = "시험 구분",
    y = "점수",
    color = "학생"
  ) + 
  theme_minimal()

##################
head(mtcars)
df <- mtcars %>%
  rownames_to_column("car")
head(df)

df |>
  select(car, mpg, hp, wt) |> # 열선택
  head(5)
df |> select(car, mpg:hp)              # mpg부터 hp까지 연속된 열 (mpg, cyl, disp, hp)
df |> select(-cyl, -vs)                # 빼고 나머지 전부
df |> select(car, starts_with("d"))    # 이름이 d로 시작 (disp, drat)
df |> select(where(is.numeric))        # 숫자형 열만 (car 제외)
df |> select(car, everything())        # car를 맨 앞으로, 나머지는 그대로
df |> select(차량 = car, 연비 = mpg)   # 고르면서 이름 바꾸기

df |>
  select(car, mpg, cyl, hp, wt) |>
  arrange(desc(mpg)) |> # 내림차순
  head(10)

df |>
  filter(car %in% c("Mazda RX4", "Datsun 710")) |> # SQL의 WHERE car IN ('Mazda RX4', 'Datsun 710')
  select(car, mpg, hp, wt) # 공백 주의 

# SELECT AVG(mpg) AS avg_mpg, AVG(hp) AS avg_hp, AVG(wt) AS avg_wt FROM df;
df |>
  summarise(
      avg_mpg = mean(mpg),
      avg_hp = mean(hp),
      avg_wt = mean(wt)
    )

# 문제 mpg, hp, wt 만 골라서(select) long 형태(pivot_longer)로 변환 

df_long <- df |>
  select(car, mpg, hp, wt) |>        
  pivot_longer(
    cols = -car,                     
    names_to = "feature",
    values_to = "value"
  )
df_long

df_long |>
  group_by(feature) |>
  summarise(avg_value = mean(value), .groups = "drop") # 요약이 끝난 뒤 그룹 설정을 해제

# 문제 변수별(mpg, hp, wt) 최대값, 최소값, 평균을 한번에 출력 

df_long |>
  group_by(feature) |>
  summarise(max_value = max(value), min_value = min(value), avg_value = mean(value), .groups = "drop")

ggplot(df_long, aes(x = feature, y= value)) +
  geom_boxplot()

# 표준화후 그리기 
df_long |>
  group_by(feature) |>
  mutate(z = (value - mean(value)) / sd(value)) |>
  ggplot(aes(x = feature, y = z)) +
  geom_boxplot(fill = "lightpink") +
  labs(title = "표준화 후 변수별 분포", y = "z점수")

data <- data.frame(x1 = 1:6,
                   x2 = c(1,2,2,3,1,2),
                   x3 = c("F","B","C","E","A","D"))
data
dplyr::select(data, x1,x2)
dplyr::select(data,-x1)
arrange(data,x3)

filter(data, x2 == 2)
filter(data, x1 > 4, x2 >1) # 조건 두개 "," -> AND& 

data <- mutate(data, x4 = x1 + x2) # 파생변수
data

data <- mutate(data,
               x4 = x1 + x2,
               x5 = x4 / 100,             
               x6 = x4 * x2) 
data
rename(data, new_name = x3)
summarise(data, avg = mean(x2))

grouped_data = group_by(data, x2)
summarise(grouped_data,
          average_height = mean(x1),
          people = n()) # 데이터 카운트 함수 

set.seed(765) # 테스트하고 연습할때만 사용 
sample_n(data, 3)
top_n(data, 1, x1)
top_n(data, 2, -x1) # 역순
(sorted = arrange(data, -x1))
filter(sorted, x2 ==1) 

data |>
  arrange(-x1) |>
  filter(x2 == 1)

mtcars %>%
  filter(mpg > 20) %T>% 
  print() %>% # (출력만 하고 결과는 버림)
  summarise(avg_hp = mean(hp))

x <- c(-3, 2, -1, 4)
x %<>% abs %>% sort
print(x)

df <- tibble(
  id = 1:5,
  name = c("대한","민국","만세","영원","무궁"),
  age = c(25,30,35,40,45),
  gender = c("Male", "Male", "Male", "Female", "Female")
  )
df
library(magrittr)
# 문제 : 나이가 30이상인 사람만 선택해서 내림차순으로 정렬 출력 
# 결과를 filtered에 입력 
filtered <- df %>%
  filter(age >= 30) %>%  # 30세 이상만
  arrange(desc(age))     # 나이 내림차순 (필터된 데이터를 정렬)
filtered                

df %>%
  filter(age>30) %>%
  arrange(desc(age)) -> filtered

# 문제 : 데이터를 성별로 그룹핑한 다음 평균나이를 svg_age 변수로 추가 

df |>
  group_by(gender) |>
  summarise(svg_age = mean(age)) -> df_summary
df_summary

# 문제 : original 데이터의 나이에 모두 12를 곱한 다음 pension변수에 입력 

df <- df |>
  mutate(pertion = age * 12)
df

# 점수 문제 
wide_data <- data.frame(
  학생 = c("철수", "영희"),
  수학 = c(80,85),
  영어 = c(90,95),
  과학 = c(85,80)
  )
wide_data
long_data <- wide_data |>
  pivot_longer(cols = -학생, names_to = "과목", values_to = "점수")
long_data
# 과목별(group by) 로 평균 점수(summarise)를 계산 
long_data |>
  group_by(과목) |>
  summarise(평균_점수 = mean(점수, na.rm = TRUE))

# 철수의 점수 출력 
long_data |>
  filter(학생 == "철수")

# 점수가 90점 이상인 학생은 우수 아니면 보통으로  우수_학생 열을 추가(data <- data) 
long_data <- long_data |>
  mutate(우수_학생 = if_else(점수 >= 90, "우수", "보통"))
long_data

wide_data <- data.frame(
  학생 = c("철수", "영희"),
  수학 = c(80,85),
  영어 = c(90,95),
  과학 = c(85,80)
)
wide_data |> 
  summarise(across(-학생, \(x) mean(x, na.rm = TRUE)))

wide_data <- wide_data %>%
  mutate(
    총점 = rowSums(dplyr::select(.,  수학, 영어, 과학), na.rm=TRUE),
    평균 = rowMeans(dplyr::select(., 수학, 영어, 과학), na.rm=TRUE)
  )
wide_data

df <- tibble(
  학생 = c("철수", "영희", "민수", "지혜"),
  수학 = c(80,NA,75,90),
  영어 = c(85,90,NA,95),
  과학 = c(NA,80,70,85)
)
df
df_no_na <- df |>
  drop_na()
df_no_na
df_no_na_specific <- df |>
  drop_na(과학)
df_no_na_specific

df |>
  replace_na(list(
    수학 = 0,
    영어 = 0,
    과학 = 0
  ))

df |> 
  fill(수학, .direction = "down") # 이전데이터로 채우기 
df_fill_up <- df |>
  fill(수학, .direction = "up")
df_fill_up

#install.packages("RSQLite")
library(DBI)
library(RSQLite)
library(dplyr)
library(dbplyr)

# 3 - 1. 고객 테이블 
customers <- tibble::tibble(
  customer_id = c(1,2,3,4,5),
  name = c("Kim","Lee","Park","Choi","Jung"),
  city = c("Seoul", "Busan", "Seoul","Daegu","Busan")
)
customers

orders <- tibble::tibble(
  order_id = c(101, 102, 103, 104, 105, 106),
  customer_id = c(1, 1, 2, 3, 3, 6),
  product = c("Laptop", "Mouse", "Keyboard", "Monitor", "Mouse", "Tablet"),
  amount = c(1500, 50, 120, 300, 45, 900)
)

departments <- tibble::tibble(
  dept_id = c(10, 20, 30),
  dept_name = c("Sales", "HR", "IT")
)

employees <- tibble::tibble(
  emp_id = c(1, 2, 3, 4, 5),
  emp_name = c("Ahn", "Bae", "Cho", "Do", "Eom"),
  dept_id = c(10, 10, 20, 30, 40),
  salary = c(3000, 3200, 2800, 4000, 3500)
)

head(customers)
head(orders)
head(departments)
head(employees)

# sqlite 메모리 데이터베이스에 등록 
con <- dbConnect(RSQLite::SQLite(), ":memory:")
copy_to(con, customers, "customers", temporary = FALSE, overwrite = TRUE)
copy_to(con, orders, "orders", temporary = FALSE, overwrite = TRUE)
copy_to(con, departments, "departments", temporary = FALSE, overwrite = TRUE)
copy_to(con, employees, "employees", temporary = FALSE, overwrite = TRUE)
dbListTables(con)

customers_tbl <- tbl(con, "customers")
orders_tbl <- tbl(con, "orders")
departments_tbl <- tbl(con, "departments")
employees_tbl <- tbl(con, "employees")

# dplyr, tidyr => database와 관련있음 
q1 <- customers_tbl |>
  select(customer_id, name, city) |>
  filter(city == "Seoul")
show_query(q1)
# 실행
collect(q1)

q2 <- orders_tbl |>
  mutate(vat_amount = amount * 1.1) |>
  arrange(desc(vat_amount))
show_query(q2)
collect(q2)


q3 <- orders_tbl |> # db와 연결된 테이블 
  group_by(customer_id) |> # 그룹 
  summarise(               # 요약
    total_amount = sum(amount, na.rm = TRUE),
    order_count = n()
  ) |>
  arrange(desc(total_amount)) # 정렬
show_query(q3)                # 쿼리 확인 
collect(q3)                   # 실제 실행 -> 데이터 확보 

# inner_join 
q4 <- customers_tbl |> 
  inner_join(orders_tbl, by = "customer_id")
show_query(q4)
collect(q4)

q5 <- customers_tbl |> 
  left_join(orders_tbl, by = "customer_id")
show_query(q5)
collect(q5)

# left_join 으로 rigth_join 대신 (테이블 순서 변경)
q6 <- orders_tbl |> 
  left_join(customers_tbl, by = "customer_id")
show_query(q6)
collect(q6)

# right_join
q7 <- customers_tbl |> 
  right_join(orders_tbl, by = "customer_id")
show_query(q7)
collect(q7)

# 문제 고객 이름과 관련 상품명만 출력
q8 <- customers_tbl |>
  inner_join(orders_tbl, by = "customer_id") |>
  select(name, product)
show_query(q8)
collect(q8)
q8

# 문제 주문금액이 100이상인 고객의 주문만 name, city, product, amount를 출력 
q9 <- customers_tbl |>
  inner_join(orders_tbl, by = "customer_id") |>
  filter(amount >= 100) |>
  select(name, city, product, amount)
show_query(q9)
collect(q9)

# 문제 주문금액이 큰 순서대로 고객이름 , 상품, 금액을 출력 
q10 <- customers_tbl |>
  inner_join(orders_tbl, by = "customer_id") |>
  select(name, product, amount) |>
  arrange(desc(amount))
show_query(q10)
collect(q10)

head(customers_tbl) # 주문
head(orders_tbl)    # 고객 정보 
head(departments)
head(employees)

# 문제 고객정보가 없는 주문을 찾아 출력하시오 (left)
q11 <- orders_tbl |>
  left_join(customers_tbl, by = "customer_id") |>
  filter(is.na(name))
show_query(q11)
collect(q11)
# 문제 주문이 없는 고객정보를 찾아 출력 (left)
q12 <- customers_tbl |>
  left_join(orders_tbl, by = "customer_id") |>
  filter(is.na(order_id))
show_query(q12)
collect(q12)
# 문제 고객별 주문 건수를 출력 n()
q13 <- customers_tbl |>
  inner_join(orders_tbl, by = "customer_id") |>
  group_by(customer_id, name) |>
  summarise(주문건수 = n(), .groups = "drop")
show_query(q13)
collect(q13)
# 부서가 없는 직원을 찾기 
employees_tbl |>
  left_join(departments_tbl, by = "dept_id")|>
  filter(is.na(dept_name))
employees_tbl
departments_tbl
# 부서별 평균급여 가 높은 순으로 정렬
q14 <- employees_tbl |>
  inner_join(departments_tbl, by = "dept_id")|>
  group_by(dept_name) |>
  summarise(avg_salary = mean(salary, na.rm = TRUE), .groups = "drop") |>
  arrange(desc(avg_salary))
q14
head(customers_tbl) # 주문
head(orders_tbl) 
head(departments)
head(employees)
# 도시별로 고객수, 총 주문금액, 평균 주문금액을 구하고 
# 총 주문금액이 큰 순으로 정렬 
q15 <- customers_tbl |>
  inner_join(orders_tbl, by = "customer_id") |>
  group_by(city) |>
  summarise(고객수     = n_distinct(customer_id),
            주문수     = n(),
            tot_amount = sum(amount, na.rm = TRUE),
            avg_amount = mean(amount, na.rm = TRUE),
            .groups = "drop") |>
  arrange(desc(tot_amount))
show_query(q15)
collect(q15)
# 파일로 접근
# 없으면 새로 생성, 있으면 접속
# sqlite는 파일 베이스 
con <- dbConnect(RSQLite::SQLite(), "mtcars.sqlite")
dbWriteTable(con, "mtcars_table", mtcars)
dbListTables(con)
mt <- dbReadTable(con, "mtcars_table")
print(mt)
dbDisconnect(con)

# GCP 데이터 베이스 접근 
# 전처리가 된 데이터는 데이터베이스에 저장 
install.packages("RMariaDB") #mysql -> oracle (이전), mariadb
library(RMariaDB)
#방법 : 환경변수 파일(.Renviron)에 저장
#install.packages("usethis")
#usethis::edit_r_environ() 
con <- dbConnect(
  RMariaDB::MariaDB(),
  dbname = "jsdb",
  host = Sys.getenv("DB_HOST"),
  port = 3306,
  user = Sys.getenv("DB_USER"),
  password = rstudioapi::askForPassword("DB_PW")
)
dbListTables(con)
student=dbReadTable(con, "student")
print(student)
dbWriteTable(con, "mtcars_table", mtcars, overwrite=TRUE)
dbListTables(con)
mtcars_table = dbReadTable(con, "mtcars_table")
print(mtcars_table)

result <- mtcars_table |>
  filter(mpg > 20) |>
  summarise(mean_hp = mean(hp))
print(result)
dbDisconnect(con)

# 문제 student 테이블을 로딩한 다음 국어 영어 수학 점수에 대한 평균 출력 
dbListTables(con)
student=dbReadTable(con, "student")
print(student)
head(student)

stu_total <- student |>
  summarise(avg_kor = mean(kor, na.rm = TRUE),
            avg_mat = mean(mat, na.rm = TRUE),
            avg_eng = mean(eng, na.rm = TRUE))
stu_total
dbDisconnect(con)
dbListTables(con)
dbExecute(con,"SET NAMES utf8mb4") # 한글 

student |>
  dplyr::select(kor, mat, eng) |>
  summarise(across(c (kor, mat, eng), ~ round(mean(.x, na.rm = TRUE),2)))
df_summart <- dbGetQuery(
  con,
  "select * from student;"
)
print(df_summart)

stmt <- dbSendQuery(con, "SELECT * FROM student WHERE name = ?")
dbBind(stmt, list("고려인"))
res <- dbFetch(stmt)
dbClearResult(stmt)
print(res)

res_sp <- dbSendQuery(con, "CALL student_select()")
df_sp_out <- dbFetch(res_sp)
dbClearResult(res_sp)
print(df_sp_out)

# 매개변수가 있는 student_insert()
con <- dbConnect(RMariaDB::MariaDB(),
                 dbname = "jsdb", host = Sys.getenv("DB_HOST"), port = 3306,
                 user = Sys.getenv("DB_USER"), password = Sys.getenv("DB_PW"))

dbExecute(con, "SET @out_cnt = NULL")
dbExecute(con, "CALL student_insert(?, ?, ?, ?, ?, @out_cnt)",
          params = list("건강해", 100, 100, 100, "CH00000001"))
out_df <- dbGetQuery(con, "SELECT @out_cnt AS out_cnt")
print(out_df$out_cnt)
dbDisconnect(con)       
















