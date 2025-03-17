/* ## Задача №1  
1. Посчитайте количество клиентов, закреплённых за каждым сотрудником (подсказка: в таблице `customer` есть поле *support_rep_id*, которое хранит *employee_id* сотрудника, за которым закреплён клиент). Итоговая таблица должна содержать следующие поля: *id сотрудника*, *полное имя*, *количество клиентов*.  
2. Добавьте к получившейся таблице поле, показывающее какой процент от общей клиентской базы обслуживает каждый сотрудник.  
*/

select 
	e.employee_id as employee_id
	, concat(e.first_name, ' ', e.last_name) as full_name
	, count(c.customer_id) as amount_customer
from employee e
left join customer c on e.employee_id = c.support_rep_id
group by e.employee_id
	, e.first_name
	, e.last_name
order by e.employee_id
;


select 
	e.employee_id as employee_id
	, concat(e.first_name, ' ', e.last_name) as full_name
	, count(c.customer_id) as amount_customer
	, round(count(c.customer_id) * 100.0 / (select count(*) from customer), 2)
	as percent_of_total_cust_base
from employee e
left join customer c on e.employee_id = c.support_rep_id
group by e.employee_id
	, e.first_name
	, e.last_name
order by e.employee_id
;



/* Задача №2
Верните список альбомов, треки из которых вообще не продавались. Итоговая таблица должна содержать следующие поля: название альбома, имя исполнителя.
*/

select
	a.title as album_name
	, ar.name as artist_name
from album a
join artist ar on a.artist_id = ar.artist_id 
where a.album_id not in (select distinct t.track_id
from track t
join invoice_line il on t.track_id = il.track_id)
order by a.title
;

/*
Задача №3
Выведите список сотрудников у которых нет подчинённых.
*/

select 
	e.employee_id as customer_id
	, concat(e.first_name, ' ', e.last_name) as full_name
from employee e
left join employee e2 on e.employee_id = e2.reports_to 
where e2.employee_id is null
order by e.employee_id
;

/*Задача №4
Верните список треков, которые продавались как в США так и в Канаде. Итоговая таблица должна содержать следующие поля: id трека, название трека.
*/

select 
	t.track_id as track_id
	, t.name as track_name
from track t
join invoice_line il on t.track_id = il.track_id
join invoice i on il.invoice_id = i.invoice_id 
where i.billing_country in ('USA', 'Canada')
group by t.track_id, t.name
having sum(case when i.billing_country = 'USA' then 1 else 0 end)>0
and sum(case when i.billing_country = 'Canada' then 1 else 0 end)>0
order by t.track_id 
;


/*Задача №5
Верните список треков, которые продавались в Канаде, но не продавались в США. Итоговая таблица должна содержать следующие поля: id трека, название трека.*/


select distinct t.track_id, t.name 
from track t
join invoice_line il on t.track_id = il.track_id
join invoice i on il.invoice_id = i.invoice_id
where i.billing_country = 'Canada'
and t.track_id not in (
    select distinct t2.track_id
    from track t2
    join invoice_line il2 on t2.track_id = il2.track_id
    join invoice i2 on il2.invoice_id = i2.invoice_id
    where i2.billing_country = 'USA'
);


