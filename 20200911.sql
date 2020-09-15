COUNT(*)-- 페이징 확인하기

--join 실습 1
SELECT LPROD_GU,lprod_nm, prod_id, prod_name 
FROM prod, lprod
WHERE lprod.lprod_gu = prod.prod_lgu;

SELECT LPROD_GU,lprod_nm, prod_id, prod_name 
FROM prod JOIN lprod ON(prod.prod_lgu = lprod.lprod_gu);

--실습2
SELECT buyer_id,buyer_name, prod_id, prod_name 
FROM prod JOIN buyer ON(prod.prod_buyer = buyer.buyer_id);

--실습3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id ;
ANSI-SQL
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member ) 
            JOIN prod ON(cart.cart_prod = prod.prod_id ) ;

SELECT *
FROM member;
