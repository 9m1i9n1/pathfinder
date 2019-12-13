# Pathfinder Server URL
**http://218.39.221.89:8181/**

## Jenkins Server URL 
**https://c5a0e0c7.ngrok.io**

## Port
**8787** : jenkins  
**8181** : pathfinder  

# DB Information

## MariaDB
**Address** :  pathfinder.ca5sinhqhzpv.ap-northeast-2.rds.amazonaws.com

**Password** : pathfinder1123!

## MongoDB
**Address** : 15.164.187.249

## 배송비 산출 공식

**(거리 * 유틸비) + (창고 이용료(지점 비용) * T 가중치)**

(차량 선택에 의해 창고 이용료가 비싸지기 때문에 차량마다 경로가 다를 수 있다)

~~크리티컬한 오류 : 창고이용료가 엄청 비싸거나 엄청 저렴할 경우, 거리에 상관없이 제일 나중에 가거나, 제일 먼저간다.~~
다른 지점도 다 똑같으니 젤 가까운곳에서 갈듯 ^^

##### 유틸비
- 연비 : 1L = 1700원
- 인건비 : 1km = 500원

##### 시설 이용료
- 5000원 ~ 15000원

##### 트럭 종류
- 1T, 2.5T, 5T, 10.5T, 19T, 25T (비율은 T / 6)

## Schema
**User Table**

Column | Content | Type
------- | ------- | -------
user_index | 유저 키 | BIGINT
user_id | 유저 아이디 | VARCHAR(20)
user_pw | 유저 비밀번호 | VARCHAR(20)
user_name | 유저 이름 | VARCHAR(10)
branch_index | 지점 키 | BIGINT (외래키)
area_index | 지역 키 | BIGINT (외래키)
user_position | 유저 직책 | VARCHAR(10)
user_email | 유저 이메일 | VARCHAR(30)
user_phone | 유저 전화번호 | VARCHAR(20)
user_created | 아이디 생성일자 | DATETIME
user_auth | 유저 권한 | TINYINT

**Branch Table**

Column | Content | Type
------- | ------- | -------
branch_index | 지점 키 | BIGINT
branch_name | 지점 이름 | VARCHAR(20)
branch_owner | 지점장 | VARCHAR(10)
branch_value | 지점 가중치 | INTEGER
branch_addr | 지점 주소 | VARCHAR(50)
branch_daddr | 지점 상세 주소 | VARCHAR(50)
branch_phone | 지점 전화번호 | VARCHAR(20)
branch_lat | 지점 위도 | DOUBLE
branch_lng | 지점 경도 | DOUBLE

**Car Table**

Column | Content | Type
------- | ------- | -------
car_index | 자동차 키 | BIGINT
car_name | 자동차 이름 | VARCHAR(20)
car_fuel | 자동차 연비 | DOUBLE
car_number | 자동차 번호판 | VARCHAR(10)
car_buy | 자동차 구입 날짜 | DATETIME

**Area Table**

Column | Content | Type
------- | ------- | -------
area_index | 지역 키 | BIGINT
area_name | 지역 이름 | VARCHAR(10)