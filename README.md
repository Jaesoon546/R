# R — 대전바이오융합 직업훈련

![R](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?logo=rstudioide&logoColor=white)

R 프로그래밍 수업 실습 코드입니다. 주제별 폴더로 나눠 보관합니다.

## 행렬 연산 학습노트

**[학습노트 열기 → jaesoon546.github.io/R](https://jaesoon546.github.io/R/)**

내적, 요소 연산, 행렬곱, 행렬곱으로 바뀌는 벡터의 크기와 방향(직접 끌어보는 그림, 행렬 × 행렬 AB·BA 비교), 3차원 텐서, 행렬식·역행렬, 연립방정식(역행렬·크래머·가우스 소거), 고윳값·고유벡터, PCA와 SVD(고윳값이 분산이 되는 조건, 수업 예제 해석), 부동소수점 오차 읽는 법, 행렬의 종류와 쓰이는 알고리즘을 직접 눌러보며 복습하는 페이지입니다. 원본 파일은 [index.html](index.html)입니다.

```
R/
├── index.html              # 행렬 연산 학습노트 (GitHub Pages 메인)
└── R_begin/                # R 기초 (2026.11.23 ~)
    ├── R_programing_1.R
    ├── R_programing_2.R
    └── schooldata.csv      # R_programing_2.R 의 read.csv 실습 데이터
```

## R_begin/

| 파일 | 내용 |
|---|---|
| [R_programing_1.R](R_begin/R_programing_1.R) (11/23) | R 기초 — 데이터 타입·형변환, 연산자, 벡터(벡터화 연산·broadcasting·recycling), 인덱싱(1부터 시작), 행렬(열 우선 저장, `%*%` 행렬곱), 정규화·exp·삼각함수, factor(범주형), 결측치 NA, 사용자 함수·연산자 함수, 기술통계와 표본·구간추정, 날짜, 작업 디렉터리와 `save`/`load` |
| [R_programing_2.R](R_begin/R_programing_2.R) (11/24) | 벡터의 의미(내적·투영·코사인 유사도·가중합), 행렬 rbind/cbind·전치·대각, 고유값 분해(eigen)와 분산, 연립방정식·역행렬(solve), list, 고차 함수, data.frame(열 이름·subset·sample), 내장 데이터셋(trees: summary·boxplot·pairs), CSV 읽기·쓰기(read.csv/write.csv, stringr), 정규분포·히스토그램 |
| [schooldata.csv](R_begin/schooldata.csv) | 사원 데이터 (id, name, salaty, start_date, dept) — 드라이브 `schooldata` 시트를 CSV로 내보낸 것 |

## 실행

RStudio에서 파일을 열고 한 줄씩 `Ctrl + Enter`로 실행합니다.

> `setwd("C:\\Users\\test\\Desktop\\R_js")`는 수업 PC의 폴더 경로입니다.
> 내 컴퓨터에서 실행할 때는 존재하는 폴더로 바꾸세요. 이 폴더에 `xy.RData`가 저장되고 다시 불러옵니다.
>
> `R_programing_2.R`은 작업 디렉터리에서 `schooldata.csv`를 읽습니다. RStudio에서 **Session → Set Working Directory → To Source File Location**을 고르면 같은 폴더의 CSV를 바로 읽을 수 있고, 실행하면 `output.csv`, `data.csv`가 새로 만들어집니다.
