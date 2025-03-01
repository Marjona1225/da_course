select
	employee_id
	, first_name || ' ' || last_name as full_name
	, title
	, reports_to
	, (select first_name || ' ' || last_name from employee
where employee_id = e.reports_to) as manager_title
from employee e
;

select 
	invoice_id
	, invoice_date 
	, extract(year from invoice_date) * 100 + extract (month from invoice_date) as monthkey
	, customer_id
	, total
from invoice
where total > (select avg (total) 
from invoice where extract(year from invoice_date) = 2023)
and extract (year from invoice_date) = 2023
;




select 
	invoice_id
	, invoice_date 
	, extract(year from invoice_date) * 100 + extract (month from invoice_date) as monthkey
	, customer_id
	, (select email from customer where customer.customer_id = invoice.customer_id)as email
	, total
from invoice
where total > (select avg (total) 
from invoice where extract(year from invoice_date) = 2023)
and extract (year from invoice_date) = 2023
;


select 
	invoice_id
	, invoice_date 
	, extract(year from invoice_date) * 100 + extract (month from invoice_date) as monthkey
	, customer_id
	, (select email from customer where customer.customer_id = invoice.customer_id)as email
	, total
from invoice
where total > (select avg (total) 
from invoice where extract(year from invoice_date) = 2023)
and extract (year from invoice_date) = 2023
and (select email from customer
where customer.customer_id = invoice.customer_id) not like '%@gmail.com'
;


select
	invoice_id
	, invoice_date
	, extract (year from invoice_date) * 100 + extract (month from invoice_date) as monthkey
	, customer_id
	, total
	, (total / (select sum(total) from invoice where extract (year from invoice_date) = 2024)) * 100 as percent_of_total
from invoice
where extract (year from invoice_date) = 2024
;


select 
	customer_id
	, sum(total) as total_revenue
	, (sum(total) / (select sum(total)
from invoice where extract (year from invoice_date) = 2024)) * 100 as pecent_of_total
from invoice 
where extract (year from invoice_date) = 2024
group by customer_id
;
