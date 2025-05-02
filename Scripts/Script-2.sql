/*
 지점명, 판매금액, 판매일자
 판매 내역 salesmangement
  pname,tot
 
 지점 실적 PERFORbYSTORE 
 store,
 
SELECT * FROM PERFORbYSTORE WHERE store LIKE '%%';
SELECT  p.*,to_char(selldate,'YYYY-MM') month FROM PERFORbYSTORE p;
SELECT store,sellparice,to_char(selldate,'YYYY-MM') MONTH FROM PERFORBYSTORE p 
WHERE store LIKE '%서울%'
 * */

SELECT s.pname, s.cnt*price AS tot,  p.store,to_char(p.SELLDATE ,'YYYY-MM') MONTH
FROM PERFORBYSTORE p
JOIN SALESMANGEMENT s ON p.store = s.store
WHERE p.store like '부산 해운대점';

/*
SELECT s.pname, s.cnt*price AS tot,  p.store 
FROM PERFORBYSTORE p
JOIN SALESMANGEMENT s ON p.store = s.store
WHERE p.store = #{store}
 * */

SELECT * FROM SALESMANGEMENT s ;

SELECT s.store, d.dname AS dname,  
            SUM(s.price * s.cnt) AS tot  
         FROM SALESMANGEMENT s  
         JOIN depart d ON s.store = d.deptno  
         WHERE s.saledate BETWEEN '2025-01-15' AND '2025-01-30'  
         GROUP BY s.store, d.dname  
         ORDER BY s.store;