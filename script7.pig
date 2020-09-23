orders = LOAD '/user/maria_dev/orders_sample.csv' USING PigStorage(',') as (order_id: int, user_id: int, eval_set: chararray, order_number: int, order_dow: int, order_hour_of_day: int, days_since_prior_order: int);                                                            

product_sample = LOAD '/user/maria_dev/product_sample1.csv' USING PigStorage(',') as (order_id: int, product_id: int, add_to_cart_order: int, reordered: int);

joined  = JOIN orders BY order_id, product_sample BY order_id; 

groupedOrders = GROUP joined BY user_id; 

orders = FOREACH groupedOrders {    
	numProducts = COUNT(joined.product_id);     
	numOrders = MAX(joined.order_number);     
	GENERATE group, (float)(numProducts/numOrders) as avgOrderSize; 
} 

DUMP orders;
