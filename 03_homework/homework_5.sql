-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

--Create CTE to find the products with their name for each vendor

WITH vendor_product AS(
SELECT v.vendor_name, product_name, original_price
FROM vendor_inventory vi

INNER JOIN vendor as v
ON vi.vendor_id = v.vendor_id

INNER JOIN product as p
ON vi.product_id = p.product_id

GROUP BY vendor_name)

--Create another CTE to count the total number of customers
	
,customer_count AS(
SELECT COUNT(customer_id) as customer_number
FROM customer)

--Cross join tables to get the total sale amount that each vendor made per product
	
SELECT vp.vendor_name, vp.product_name
, 5 * vp.original_price * cc.customer_number as total_sales

FROM vendor_product as vp
CROSS JOIN customer_count as cc


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

CREATE TEMP TABLE product_units AS

SELECT *
, CURRENT_TIMESTAMP as snapshot_timestamp

FROM product

WHERE product_qty_type = 'unit'


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO product_units
VALUES(26, 'Apple Pie', '10"', 3, 'unit', CURRENT_TIMESTAMP);
  
SELECT *
FROM product_units


-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM product_units
WHERE product_name = 'Apple Pie'
AND snapshot_timestamp < (
    SELECT MAX(snapshot_timestamp)
    FROM product_units
    WHERE product_name = 'Apple Pie'
);
  
SELECT *
FROM product_units

-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

--Coalesce null values to 0 in product_units

UPDATE product_units
SET current_quantity = COALESCE(current_quantity,0);
 
--Find the last quantity in vendor inventory

WITH last_product_inventory AS (

SELECT product_id, quantity as last_quantity
FROM

(SELECT product_id, market_date, quantity
,DENSE_RANK()OVER(PARTITION BY product_id ORDER BY market_date DESC) as date_rank_max
FROM vendor_inventory) x

WHERE x.date_rank_max = 1
)

--Update to product_units with the latest quantity, and coalesce all null values to 0 to ensure no null in table

UPDATE product_units

SET current_quantity = coalesce(
(SELECT last_quantity
  FROM last_product_inventory
  WHERE last_product_inventory.product_id = product_units.product_id)
  ,0);
