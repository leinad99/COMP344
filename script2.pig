orders = LOAD '/user/maria_dev/orders_sample.csv' USING PigStorage(',') as (order_id: int, user_id: int, eval_set: chararray, order_number: int, order_dow: int, order_hour_of_day: int, days_since_prior_order: int);

groupedOrders = GROUP orders by user_id;

maxNODBO = FOREACH groupedOrders GENERATE group as user_id, MAX(orders.days_since_prior_order) as maxDaysBetween;

DUMP maxNODBO;

