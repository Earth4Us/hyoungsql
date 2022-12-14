show databases;
use DB_SQLSTK;
select * from stock;
select STK_NM from stock;
select STK_CD, STK_NM, EX_CD from stock order by STK_NM desc;
SELECT  STK_CD ,STK_NM ,SEC_NM
FROM    stock
WHERE   STK_NM = '삼성물산'
ORDER BY STK_CD DESC;
SELECT  STK_CD ,STK_NM ,SEC_NM
FROM    stock
WHERE   STK_CD <= '000100'
ORDER BY STK_CD DESC;
SELECT  STK_CD ,STK_NM ,SEC_NM, EX_CD from stock where ((STK_NM like '동양%') AND (SEC_NM not like '%금속%')) order by EX_CD desc, STK_NM asc; 
SELECT  STK_CD ,STK_NM ,SEC_NM, EX_CD FROM    stock
WHERE   EX_CD = 'KD'
AND     (SEC_NM = '담배' OR SEC_NM = '주류제조업')
ORDER BY STK_CD ASC;
select SEC_NM, STK_CD,STK_NM from stock where SEC_NM='자동차' order by STK_NM asc;
select SEC_NM 종목명 from stock T1 where T1.SEC_NM='자동차';
desc DB_SQLSTK.history_dt;
select STR_TO_DATE('20190108','%Y%m%d');
select 4*5 result;
select STK_CD, DT, C_PRC, VOL, C_PRC*VOL 거래금액 from history_dt 
where  STK_CD=005930  /* 005930 도 되고 '005930'도 됨 varchar의 성질인가? */
and DT >= str_to_date('20190201','%Y%m%d')
and DT < str_to_date('20190301','%Y%m%d')
order by 거래금액 desc;
desc history_dt;
select str_to_date('20190201','%Y%m%d');
select upper("A Tiger");
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS;
use INFORMATION_SCHEMA;
show tables; /* 사용 데이타베이스의 table들을 조회한다 */ 
desc COLUMNS;
show tables;
desc history_dt;
select str_to_date('20000101','%Y%m%d'); 
select str_to_date('20190201','%Y%m%d');
SELECT  T1.*
FROM    history_dt T1
WHERE   T1.DT = STR_TO_DATE('20190102','%Y%m%d')
AND     T1.C_PRC > T1.O_PRC #종가가 시가보다 크면 양봉이다.
ORDER BY T1.CHG_RT DESC; #등락률 순으로 내림차순
SELECT  *   # T1 (약어)를 꼭 쓰지 않아도 됨을 보여주는 앞과 동일 명령. 하지만 약어를 쓰는 것은 좋은 습관임. 여러 테이블을 사용할 수 있을 경우. 
FROM    history_dt 
WHERE   DT = STR_TO_DATE('20190102','%Y%m%d')
AND     C_PRC > O_PRC #종가가 시가보다 크면 양봉이다.
ORDER BY CHG_RT DESC; #등락률 순으로 내림차순
SELECT  T1.SEC_NM 회사업종
        ,COUNT(*) CNT
FROM    stock T1
WHERE   T1.STK_NM LIKE '삼성%'
GROUP BY T1.SEC_NM
ORDER BY T1.SEC_NM;  # 4.08까지 공부했고, 이후 4.09 공부하기
SELECT  T1.STK_CD
        ,T1.STK_NM 회사명
        ,CASE WHEN T1.STK_NM LIKE '삼성%' THEN '삼성 관련주'
              WHEN T1.STK_NM LIKE '현대%' THEN '현대 관련주'
              ELSE 'LG 관련주'
        END 종목구분
FROM    stock T1
WHERE   T1.STK_NM IN ('삼성전자','삼성SDI','현대차','현대모비스','LG전자','LG화학')
ORDER BY T1.STK_NM;
desc stock;
show tables;
CREATE TABLE STOCK_TAG (
  STK_CD         varchar(40)    NOT NULL   COMMENT '종목코드',
  STK_TAG_DV_NM  varchar(200)   NOT NULL   COMMENT '종목태그분류명',
  STK_TAG_NM     varchar(200)   NOT NULL   COMMENT '종목태그명',
  USE_YN         varchar(200)   NULL       COMMENT '사용여부',
  REG_DTM        DATETIME       NULL       COMMENT '등록일시',
  PRIMARY KEY (STK_CD,STK_TAG_DV_NM,STK_TAG_NM)
) ENGINE=InnoDB COMMENT='종목별태그';
SELECT  T1.TABLE_NAME ,T1.TABLE_COMMENT 
FROM    INFORMATION_SCHEMA.TABLES T1
WHERE   T1.TABLE_NAME = 'STOCK_TAG';
show tables;
show databases;
desc INFORMATION_SCHEMA.TABLES;
select TABLE_SCHEMA, TABLE_NAME, ENGINE
from INFORMATION_SCHEMA.TABLES;
SELECT  T1.ORDINAL_POSITION ,T1.COLUMN_NAME ,T1.COLUMN_COMMENT 
FROM    INFORMATION_SCHEMA.COLUMNS T1
WHERE   T1.TABLE_NAME = 'STOCK_TAG'
ORDER BY T1.ORDINAL_POSITION;
INSERT INTO STOCK_TAG
        (STK_CD, STK_TAG_DV_NM, STK_TAG_NM, USE_YN, REG_DTM)
VALUES  ('006400', 'samsung', '2nd Battery', 'Y', NOW());
show tables; 
DROP TABLE IF EXISTS new_table;
show tables;
use DB_SQLSTK;
select STK_TAG_DV_NM from STOCK_TAG;
SELECT T1.* FROM stock T1 WHERE T1.STK_NM = '삼성전자';    -- 이하 Join 사용법 
SELECT  T1.STK_CD ,T1.STK_NM ,T1.SEC_NM ,T2.STK_CD ,T2.DT ,T2.C_PRC
FROM  stock T1
        INNER JOIN history_dt T2
           ON (T2.STK_CD = T1.STK_CD)
WHERE   T1.STK_NM = '삼성전자'
ORDER BY T2.DT ;    -- 테이블 이름이 현재는 대소문자를 구분하고 있는데, 이는 config 파일에서 그렇게 설정했기 때문임. 
show variables like 'lower_case_%';   -- 이 명령을 통해 lower_case_table_names이 0으로 되어 있음을 알수 있으며, 이를 1로 바꾸면됨alter
                                      -- 보통 /etc/my.cnf 파일을 고치면 됨.  실제 goormide (kim.hyoungsoo계정)은 mysql.cnf임. 
show databases;
desc history_dt;  -- 일자별 주식 변화에 대한 정보를 담은 테이블에 대한 속성들 확인용
SELECT  T1.STK_CD ,T1.STK_NM ,T1.SEC_NM ,T2.STK_CD ,T2.DT ,T2.C_PRC
FROM  stock T1
        INNER JOIN history_dt T2
           ON (T2.STK_CD = T1.STK_CD)  -- 이게 연결하는 조건임
WHERE   T1.STK_NM = '삼성전자'
ORDER BY T2.DT DESC;   -- 최근부터 과거로 보여주게 함.
SELECT  T1.STK_CD ,T1.STK_NM ,T1.SEC_NM ,T2.STK_CD ,T2.DT ,T2.C_PRC
FROM  stock T1
        INNER JOIN history_dt T2
           ON (T2.STK_CD = T1.STK_CD)  -- 이게 연결하는 조건임
WHERE   T1.STK_NM Like '삼성%'  -- 삼성으로 시작하는 주식명을 갖는 조건 모두 정리하여 보여주기
ORDER BY T2.DT DESC;   -- 최근부터 과거로 보여주게 함.
SELECT  T1.STK_CD ,T1.STK_NM ,T1.SEC_NM ,T2.STK_CD ,T2.DT ,T2.C_PRC
FROM  stock T1
        INNER JOIN history_dt T2
           ON (T2.STK_CD = T1.STK_CD)  -- 이게 연결하는 조건임
WHERE   T1.STK_NM Like '삼성%'  -- 삼성으로 시작하는 주식명을 갖는 조건 모두 정리하여 보여주기
ORDER BY T1.STK_NM, T2.DT DESC;   -- 우선 이름으로 올림차순 정리하고, 최근부터 과거로 보여주게 함.
SELECT  T1.STK_CD ,T1.STK_NM ,T2.DT ,T2.C_PRC
        ,T3.DT 하루전_DT ,T3.C_PRC 하루전_C_PRC
FROM    stock T1
        INNER JOIN history_dt T2
            ON (T2.STK_CD = T1.STK_CD)
        INNER JOIN history_dt T3 # 2019년 1월 7일을 가져오기 위한 테이블
            ON (T3.STK_CD = T1.STK_CD)
WHERE   T1.STK_NM = '삼성전자'
AND     T2.DT = STR_TO_DATE('20190108','%Y%m%d')
AND     T3.DT = STR_TO_DATE('20190107','%Y%m%d'); # T3에 2019년 1월 7일 조건을 사용