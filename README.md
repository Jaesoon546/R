# R — 대전바이오융합 직업훈련

![R](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?logo=rstudioide&logoColor=white)

R 프로그래밍 수업 실습 코드입니다. 주제별 폴더로 나눠 보관합니다.

## 행렬 연산 학습노트

**[학습노트 열기 → jaesoon546.github.io/R](https://jaesoon546.github.io/R/)**

요소 연산, 내적, 행렬곱, 행렬곱으로 바뀌는 벡터의 크기와 방향(직접 끌어보는 그림, 행렬 × 행렬 AB·BA 비교), 행렬식·역행렬, 연립방정식(역행렬·크래머·가우스 소거), 고윳값·고유벡터, PCA와 SVD(고윳값이 분산이 되는 조건, 수업 예제 해석), 3차원 확장(텐서 축약), 행렬의 종류와 쓰이는 알고리즘, 기술통계(평균·중앙값·분산·IQR·왜도·첨도, 범주화, 그룹 요약)와 전처리(결측치·이상치 기준 비교·원-핫 인코딩·스케일링), tidyverse(파이프·tibble·pivot·tidyr 결측치 처리), dplyr 동사와 SQL 대응(**SQL 작성 순서·실행 순서·dplyr 순서 비교**), join 6종(직접 바꿔 보는 그림), R에서 DB 질의(dbplyr·DBI·매개변수 쿼리·저장 프로시저·보안)를 직접 눌러보며 복습하는 페이지입니다. 원본 파일은 [index.html](index.html)입니다.

```
R/
├── index.html              # 행렬 연산 학습노트 (GitHub Pages 메인)
└── R_begin/                # R 기초 (2026.11.23 ~)
    ├── R_programing_1.R
    ├── R_programing_2.R
    ├── R_programing_3.R
    ├── R_programing_4.R
    └── schooldata.csv      # R_programing_2.R 의 read.csv 실습 데이터
과제/
└── 20261126_박재순_R10문_과제.R
```

## R_begin/

| 파일 | 내용 |
|---|---|
| [R_programing_1.R](R_begin/R_programing_1.R) (11/23) | R 기초 — 데이터 타입·형변환, 연산자, 벡터(벡터화 연산·broadcasting·recycling), 인덱싱(1부터 시작), 행렬(열 우선 저장, `%*%` 행렬곱), 정규화·exp·삼각함수, factor(범주형), 결측치 NA, 사용자 함수·연산자 함수, 기술통계와 표본·구간추정, 날짜, 작업 디렉터리와 `save`/`load` |
| [R_programing_2.R](R_begin/R_programing_2.R) (11/24) | 벡터의 의미(내적·투영·코사인 유사도·가중합), 행렬 rbind/cbind·전치·대각, 고유값 분해(eigen)와 분산, 연립방정식·역행렬(solve), list, 고차 함수, data.frame(열 이름·subset·sample), 내장 데이터셋(trees: summary·boxplot·pairs), CSV 읽기·쓰기(read.csv/write.csv, stringr), 정규분포·히스토그램 |
| [R_programing_3.R](R_begin/R_programing_3.R) (11/25) | 기술통계(mean·median·var·sd·표준오차·변동계수·quantile, 왜도·첨도: e1071/moments, hist+density, boxplot), 범주화(factor, within 구간화, table·tapply, ggplot2), 결측치(is.na·complete.cases·na.omit·중앙값 대체·Hmisc::impute), 이상치(IQR·3σ·fivenum·boxplot.stats), 선형회귀 lm·predict, 원-핫 인코딩, 정규화(Z 점수·Min-Max·Robust), attach/detach, aggregate·tapply로 만든 판매 데이터 4차원 큐브 |
| [R_programing_4.R](R_begin/R_programing_4.R) (11/26) | tibble·파이프(`%>%`, `\|>`, `%T>%`, `%<>%`), tidyr(pivot_longer·separate·unite·pivot_wider, factor 순서), ggplot2 막대·선 그래프, dplyr(select·filter·arrange·mutate·rename·group_by·summarise·across·slice), tidyr 결측치(drop_na·replace_na·fill), join 실습(고객·주문·부서·직원), dbplyr(SQLite copy_to·tbl·show_query·collect), 파일 SQLite, RMariaDB로 GCP MySQL 접속(환경변수), dbGetQuery·매개변수 쿼리·저장 프로시저 호출 |
| [schooldata.csv](R_begin/schooldata.csv) | 사원 데이터 (id, name, salaty, start_date, dept) — 드라이브 `schooldata` 시트를 CSV로 내보낸 것 |

## 과제/

| 파일 | 내용 |
|---|---|
| [20261126_박재순_R10문_과제.R](과제/20261126_박재순_R10문_과제.R) | R 기초 10문항 — vector, sum/mean, summary, data.frame, 파생변수(total = pay + pay × bonus), barplot, dplyr filter·select, cbind로 열 추가, group_by·summarise 부서별 평균. 8번은 `filter(total >= 300)` → `select(empno, total)` 순서로 수정(조건에 쓸 열을 먼저 거르고 출력 열은 마지막에 고름, 학습노트 "dplyr·SQL 순서" 참고) |

## 실행

RStudio에서 파일을 열고 한 줄씩 `Ctrl + Enter`로 실행합니다.

> `setwd("C:\\Users\\test\\Desktop\\R_js")`는 수업 PC의 폴더 경로입니다.
> 내 컴퓨터에서 실행할 때는 존재하는 폴더로 바꾸세요. 이 폴더에 `xy.RData`가 저장되고 다시 불러옵니다.
>
> `R_programing_2.R`은 작업 디렉터리에서 `schooldata.csv`를 읽습니다. RStudio에서 **Session → Set Working Directory → To Source File Location**을 고르면 같은 폴더의 CSV를 바로 읽을 수 있고, 실행하면 `output.csv`, `data.csv`가 새로 만들어집니다.
>
> `R_programing_4.R`의 MySQL 접속 부분은 비밀번호를 코드에 넣지 않고 환경변수(`~/.Renviron`의 `DB_HOST`, `DB_USER`, `DB_PW`) 또는 `rstudioapi::askForPassword()`로 받습니다. 처음 실행하기 전에 `file.edit("~/.Renviron")`로 값을 저장하고 R을 다시 시작하세요.
>
> `R_programing_3.R`은 내장 데이터와 패키지 데이터만 씁니다. 처음 실행할 때 `e1071`, `moments`, `nycflights13`, `mlbench`, `ggplot2`, `Hmisc` 설치가 필요합니다(`MASS`는 기본 포함).
