create schema store;
set search_path to store;

--show search_path;

create table if not exists store.customer(
	customer_id serial primary key
	, customer_name varchar(50) not null
	, email varchar(260)
	, address text
);

select * from customer;



insert into customer(customer_name, email, address)
select 
	first_name || ' ' || last_name as customer_name
	, email
	, concat(country, '   ' , state, '  ', city, '  ' , address) as address
from public.customer
;

select * from customer;



create table if not exists store.products (
	product_id serial primary key
	, product_name varchar (100)
	, price numeric(10, 2) not null
);

select * from products;



insert into products(product_name, price)
values
	('Ноутбук Lenovo Thinkpad', 12000)
	, ('Мышь для компьютера, беспроводная', 90)
	, ('Подставка для ноутбука', 300)
	, ('Шнур для ПК', 160)
;

select * from products;



create table if not exists store.sales (
	sale_id serial primary key
	, sale_timestamp timestamp not null default current_timestamp
	, customer_id int not null
	, product_id int not null
	, quantity int not null default 1)
;

select * from sales;



insert into sales (customer_id, product_id, quantity)  
values  
    (3, 4, 1),  
    (56, 2, 3),  
    (11, 2, 1),  
    (31, 2, 1),  
    (24, 2, 3),  
    (27, 2, 1),  
    (37, 3, 2),  
    (35, 1, 2),  
    (21, 1, 2),  
    (31, 2, 2),  
    (15, 1, 1),  
    (29, 2, 1),  
    (12, 2, 1)
;

select * from sales;



alter table store.sales
add column discount numeric(3, 2) default 0
;

update sales
set discount = 0.2
where product_id = 1
;

select * from sales
where product_id = 1;

drop view v_usa_customers;

create view v_usa_customers as
select
	customer_name
from customer
where address like 'USA%'
;

select * from v_usa_customers;





