orders = LOAD '/user/maria_dev/orders_sample.csv' USING PigStorage(',') as (order_id:int, user_id:int, eval_set: chararray, order_number:int, order_dow: int, order_hour_of_day: int, days_since_prior_order:int); 

product_sample = LOAD '/user/maria_dev/product_sample1.csv' USING PigStorage(',') as (order_id: int, product_id: int, add_to_cart_order:int, reordered: int);

products = LOAD '/user/maria_dev/products1.csv' USING PigStorage(',') as (product_id: int, product_name: chararray, aisle_id: int, department_id: int); 

joined = join orders by order_id, product_sample by order_id;

groupedOrders = GROUP joined by product_id;

orderCounts = FOREACH groupedOrders GENERATE group as product_id, SUM(joined.orders::order_id) as numOrders;

ordered10plus = FILTER orderCounts by numOrders >= 10;

joinedNames = join ordered10plus by product_id, products by product_id;

namesOnly = FOREACH joinedNames GENERATE product_name;

DUMP namesOnly;


