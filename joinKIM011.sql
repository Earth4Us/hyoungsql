show databases;
use DB_SQLSTK;
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
AND     T3.DT = STR_TO_DATE('20190107','%Y%m%d'); # T3에 2019년 1월 7일 조건을 사용basecode