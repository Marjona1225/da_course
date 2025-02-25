select
	min(invoice_date) as first_purchase,
	max(invoice_date) as last_perchase
from invoice;


select 
	avg(total) as average_check
from invoice 
where 
	billing_country = 'USA';


select
	city
from customer
group by city 
having count(*)>1;


select 
	phone
from customer
where 
	phone not like '%(%)%';


select 
	concat(upper(substring('lorem ipsum', 1, 1)), 
	lower(substring('lorem ipsum', 2))) as formatted_text;

select 
	name
from track 
where 
	name like '%run%';


select 
	first_name
	, last_name
	, email
from customer
where 
	email like '%@gmail.com';


select 
	name
from track 
order by length(name) desc 
limit 1;



select 
	extract(month from invoice_date) as month_id
	, SUM(total) as sales_sum
from invoice
where
	extract(year from invoice_date) = 2021
group by extract(month from invoice_date)
order by month_id;


select 
	extract(month from invoice_date) as month_id
	, to_char(invoice_date, 'Month') as month_name
	, sum(total) as sales_sum
from invoice
where
	extract(year from invoice_date) = 2021
	and exists (
    select 1 
    from track
    where 
    	name ilike '%run%'
  )
group by extract(month from invoice_date), to_char(invoice_date, 'Month')
order by month_id;


select 
	first_name
	,last_name
	, birth_date
	, extract(year from age(birth_date)) as age_now
from employee
order by age_now desc
limit 3;



select 
	avg(extract(year from age(birth_date))+3+(4/12.0)) as avfg_age_in_3_years_4_monthasas 
from employee;


select 
	extract(year from invoice_date) as year
	, billing_country
	, sum(total) as sales_sum
from invoice
group by extract(year from invoice_date)
	, billing_country
having sum(total) > 20
order by year asc
	, sales_sum desc;


