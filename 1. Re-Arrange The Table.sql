create Database Interview_DB;
/*1. Write a query to rearrange the Products table so each row has (product_id, store, price). 
If a product is unavailable in a store, do not include a row with that product_id and store combination in the result table.

Note: Return the result ordered by product_id and store in ascending order.
*/
-- Create the 'products' table
use Interview_DB;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    store1 INT,
    store2 INT,
    store3 INT
);

-- Insert data into the 'products' table
INSERT INTO products(product_id, store1, store2, store3)
VALUES 
  (0, 90, 105, 110),
  (1, null, 87, 85),
  (2, null, 30, 40);
  
  -- sample input-
  select * from products;
  
-- Answer
-- Method 1-
#Select Records for Store1:
#Select Records for Store2:
#Select Records for Store3:
#Combine Results Using UNION:
#Order the Result Set:
SELECT  product_id, 'store1' AS store, store1 AS price
FROM products
WHERE store1 IS NOT NULL
UNION
SELECT  product_id, 'store2' AS store, store2 AS price
FROM products
WHERE store2 IS NOT NULL
UNION
SELECT  product_id, 'store3' AS store, store3 AS price
FROM products
WHERE store3 IS NOT NULL
ORDER BY "product_id", store;

#Method 2 : Using union, Case statement & order by

#Select Records for Store1 (using case statement):
#Select Records for Store2 (using case statement) :
#Select Records for Store3 (using case statement):
#Combine Results Using UNION:
#Order the Result Set:

select 
	product_id,
    case
		when store1 is not null then 'store1'
	end as store,
    store1 as price
from product
where store1 is not null
union
select 
	product_id,
    case
		when store2 is not null then 'store2'
	end as store,
    store2 as price
from product
where store2 is not null
union
select 
	product_id,
    case
		when store3 is not null then 'store3'
	end as store,
    store3 as price
from product
where store3 is not null
order by store asc;

SELECT p.product_id, 
       v.store, 
       CASE v.store 
           WHEN 'store1' THEN p.store1
           WHEN 'store2' THEN p.store2
           WHEN 'store3' THEN p.store3
       END AS price
FROM product p
CROSS JOIN (
    SELECT 'store1' AS store
    UNION 
    SELECT 'store2'
    UNION 
    SELECT 'store3'
) v
WHERE CASE v.store 
           WHEN 'store1' THEN p.store1
           WHEN 'store2' THEN p.store2
           WHEN 'store3' THEN p.store3
       END IS NOT NULL
ORDER BY v.store ASC;

# Method 3 : Using union, case statement, Cross join & order by 

#Create a Table with Store Names:
#Cross Join the Virtual Table with the Input Table:
#Filter Records Based on Non-Null Prices:
#Order the Result Set:

select 
	product_id,
    v.store,
    case v.store
		when 'store1' then p.store1
        when 'store2' then p.store2
        when 'store3' then p.store3
	end as price
from product p
cross join(select 'store1' as store
union
select 'store2' 
union
select 'store3' ) v
where case v.store
		when 'store1' then p.store1
        when 'store2' then p.store2
        when 'store3' then p.store3
	end is not null
order by v.store asc;