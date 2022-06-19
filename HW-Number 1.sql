--- Number of female customers in Jakarta who has Gmail account
select count(c.id) as gmail_acc_female
from datasource_sql_ds14.customer as c
where c.city = 'Jakarta' and c.email = 'Gmail' and c.gender = 'Female';

--- Table number of female customers in Jakarta who has Gmail account (transaction at least 10 times)
select c.id, count(t.quantity) as frequency
from datasource_sql_ds14.customer as c
inner join datasource_sql_ds14.transaction as t
on c.id = t.customer_id
group by c.id
order by frequency desc;

--- Number of female customers in Jakarta who has Gmail account (transaction at least 10 times)
with cust_trans as (select c.id, c.city, c.gender, c.email, count(t.quantity) as frequency
from datasource_sql_ds14.customer as c
inner join datasource_sql_ds14.transaction as t
on c.id = t.customer_id
group by c.id, c.city, c.gender, c.email
order by c.id) select count(id) from cust_trans
where frequency >= 10 and email = 'Gmail' and gender = 'Female' and city = 'Jakarta';

--- Notes :
--- Step 1 bikin table baru bernama cust_trans
--- Step 2 eksekusi sesuai yang diinginkan (setelah keyword select)


