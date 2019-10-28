# DB Information

**Address** :  pathfinder.ca5sinhqhzpv.ap-northeast-2.rds.amazonaws.com

**Password** : pathfinder1123!

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