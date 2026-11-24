# R — 대전바이오융합 직업훈련

![R](https://img.shields.io/badge/R-276DC3?logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?logo=rstudioide&logoColor=white)

R 프로그래밍 수업 실습 코드입니다. 주제별 폴더로 나눠 보관합니다.

## 행렬 연산 학습노트

**[학습노트 열기 → jaesoon546.github.io/R](https://jaesoon546.github.io/R/)**

내적, 요소 연산, 행렬곱, 행렬곱으로 바뀌는 벡터의 크기와 방향(직접 끌어보는 그림), 3차원 텐서, 행렬식·역행렬, 연립방정식(역행렬·크래머·가우스 소거), 고윳값·고유벡터, PCA와 SVD(고윳값이 분산이 되는 조건, 수업 예제 해석), 부동소수점 오차 읽는 법, 행렬의 종류와 쓰이는 알고리즘을 직접 눌러보며 복습하는 페이지입니다. 원본 파일은 [index.html](index.html)입니다.

```
R/
├── index.html              # 행렬 연산 학습노트 (GitHub Pages 메인)
└── R_begin/                # R 기초 (2026.11.23)
    └── R_programing_1.R
```

## R_begin/

| 파일 | 내용 |
|---|---|
| [R_programing_1.R](R_begin/R_programing_1.R) | R 기초 — 데이터 타입·형변환, 연산자, 벡터(벡터화 연산·broadcasting·recycling), 인덱싱(1부터 시작), 행렬(열 우선 저장, `%*%` 행렬곱), 정규화·exp·삼각함수, factor(범주형), 결측치 NA, 사용자 함수·연산자 함수, 기술통계와 표본·구간추정, 날짜, 작업 디렉터리와 `save`/`load` |

## 실행

RStudio에서 파일을 열고 한 줄씩 `Ctrl + Enter`로 실행합니다.

> `setwd("C:\\Users\\test\\Desktop\\R_js")`는 수업 PC의 폴더 경로입니다.
> 내 컴퓨터에서 실행할 때는 존재하는 폴더로 바꾸세요. 이 폴더에 `xy.RData`가 저장되고 다시 불러옵니다.
