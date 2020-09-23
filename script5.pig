
orders = LOAD '/user/maria_dev/orders_sample.csv' USING PigStorage(',') as (order_id: int, user_id: int, eval_set: chararray, order_number: int, order_dow: int, order_hour_of_day: int, days_since_prior_order: int);

product_sample = LOAD '/user/maria_dev/product_sample1.csv' USING PigStorage(',') as (order_id: int, product_id: int, add_to_cart_order: int, reordered: int); 

products = LOAD '/user/maria_dev/products1.csv' USING PigStorage(',') as (product_id: int, product_name: chararray, aisle_id: int, department_id: int); 

joined = JOIN products BY product_id, product_sample BY product_id; 

groupedProducts = GROUP joined BY product_name; 

mostPopular = FOREACH groupedProducts GENERATE group AS product_name, COUNT(joined.add_to_cart_order) AS timesBought; 

ranked = RANK mostPopular BY timesBought DESC DENSE; 

topProducts = FILTER ranked BY rank_mostPopular == 1; 

groupedTopProducts = GROUP topProducts BY product_name; 

nameAndCount = FOREACH groupedTopProducts GENERATE group AS product_name, MAX(topProducts.timesBought); 

DUMP nameAndCount;
