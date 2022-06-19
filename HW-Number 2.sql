--- Table top 5 product_id and total_transaction (quantity)
with prod_trans as (
select product_id, sum(quantity) as total_transaction
from datasource_sql_ds14.transaction as tp
where created_at >= '2018-10-01' and created_at <= '2018-12-31'
group by tp.product_id)
select product_id, total_transaction from prod_trans
where total_transaction > (select avg(total_transaction) from prod_trans)
order by total_transaction desc
limit 5;

--- Table top 5 product_id and frequency transaction 
with prod_trans as (
select product_id, count(id) as frequency
from datasource_sql_ds14.transaction as tp
where created_at >= '2018-10-01' and created_at <= '2018-12-31'
group by tp.product_id)
select product_id, frequency from prod_trans
where frequency > (select avg(frequency) from prod_trans)
order by frequency desc
limit 5;
