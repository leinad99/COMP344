product_sample = LOAD '/user/maria_dev/product_sample1.csv' USING PigStorage(',') as (order_id: int, product_id: int, add_to_cart_order: int, reordered: int); 

products = LOAD '/user/maria_dev/products1.csv' USING PigStorage(',') as (product_id: int, product_name: chararray, aisle_id: int, department_id: int); 

joined  = JOIN product_sample BY product_id, products BY product_id; 

groupedProducts = GROUP joined BY product_name; 

reordered = FOREACH groupedProducts GENERATE group AS product_name, MAX(joined.reordered) AS notReordered; 

noReorders = FILTER reordered BY notReordered == 0; 

groupNoReorders = GROUP noReorders ALL; 

noReordersCount = FOREACH groupNoReorders GENERATE COUNT(noReorders.product_name); 

DUMP noReordersCount;
