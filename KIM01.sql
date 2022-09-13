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
SELECT  STK_CD ,STK_NM ,SEC_NM, EX_CD
FROM    stock
WHERE   EX_CD = 'KD'
AND     (SEC_NM = '담배' OR SEC_NM = '주류제조업')
ORDER BY STK_CD ASC;
select SEC_NM, STK_CD,STK_NM from stock where SEC_NM='자동차' order by STK_NM asc;
