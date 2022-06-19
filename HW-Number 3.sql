--- Table maximum transaction (quantity) male and female from a particular type store in all cities
with table_trans as (select t.store_id, sum(t.quantity) as total_transaction, c.city, c.gender --- Define sub query 1
from datasource_sql_ds14.transaction as t
inner join datasource_sql_ds14.customer as c 
on t.customer_id  = c.id
group by t.store_id, c.city, c.gender), --- there is "," between 2 sub query those defined
table_tot_trans as (select store_id, city, sum(total_transaction) --- Define sub query 2
as total_trans
from table_trans
group by store_id, city
order by total_trans desc)
select table_trans.city, s.type, table_trans.gender, table_trans.total_transaction --- our "main" query after we defined our sub queries
from table_trans
inner join datasource_sql_ds14.store as s 
on table_trans.store_id = s.id
where store_id = (select store_id from table_tot_trans limit 1);

--- Table maximum transaction (quantity) from a particular type store in Jakarta
with table_trans as (select t.store_id, sum(t.quantity) as total_transaction, c.city, c.gender --- Define sub query 1
from datasource_sql_ds14.transaction as t
inner join datasource_sql_ds14.customer as c 
on t.customer_id  = c.id
group by t.store_id, c.city, c.gender) --- there is no "," between sub query and our "main" query
select s.type, sum(total_transaction) as total_trans 
from table_trans
inner join datasource_sql_ds14.store as s 
on table_trans.store_id = s.id
where city = 'Jakarta'
group by s.type
order by total_trans desc
limit 1; 



--- Table maximum transaction (quantity) male and female from a particular type store in Jakarta
with table_trans as (select t.store_id, sum(t.quantity) as total_transaction, c.city, c.gender --- Define sub query 1
from datasource_sql_ds14.transaction as t
inner join datasource_sql_ds14.customer as c 
on t.customer_id  = c.id
group by t.store_id, c.city, c.gender), --- there is "," between 2 sub query those defined
table_tot_trans as (select store_id, city, sum(total_transaction) as total_trans --- Define sub query 2
from table_trans
group by store_id, city
order by total_trans desc) --- there is no "," between sub query and our "main" query
select s.type, table_trans.gender, table_trans.total_transaction --- our "main" query after we defined our sub queries
from table_trans
inner join datasource_sql_ds14.store as s 
on table_trans.store_id = s.id
where city = 'Jakarta' and store_id = (select store_id 
from table_tot_trans
where city = 'Jakarta' limit 1);


--- Table maximum transaction (quantity) of type store outside jakarta
with table_trans as (select t.store_id, sum(t.quantity) as total_transaction, c.city, c.gender --- Define sub query 1
from datasource_sql_ds14.transaction as t
inner join datasource_sql_ds14.customer as c 
on t.customer_id  = c.id
group by t.store_id, c.city, c.gender) --- there is no "," between sub query and our "main" query
select s.type, sum(total_transaction) as total_trans 
from table_trans
inner join datasource_sql_ds14.store as s 
on table_trans.store_id = s.id
where city != 'Jakarta'
group by s.type
order by total_trans desc
limit 1; 

--- Table maximum transaction (quantity) male and female from a particular type store in Jakarta
with table_trans as (select t.store_id, sum(t.quantity) as total_transaction, c.city, c.gender --- Define sub query 1
from datasource_sql_ds14.transaction as t
inner join datasource_sql_ds14.customer as c 
on t.customer_id  = c.id
group by t.store_id, c.city, c.gender) --- there is no "," between sub query and our "main" query
select s.type, gender, sum(total_transaction) as total_trans 
from table_trans
inner join datasource_sql_ds14.store as s 
on table_trans.store_id = s.id
where city != 'Jakarta'
group by s.type, gender
order by total_trans desc
limit 2;