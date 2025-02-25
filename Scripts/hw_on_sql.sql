/*
Имя: MJ Abdurakhmonova
Задача: Домашка #1 по SQL
Описание: Создание SQL-файла с комментариями в DBeaver и работа с Git.
*/

select 
name, genre_id
from track;

select 
name as song,
unit_price as price,
composer as author
from track;

select 
name, (milliseconds/60000) as durarion_minutes
from track
order by (milliseconds/60000) desc;

select 
name, genre_id
from track
limit 15;

select *
from track
order by name
offset 49 rows;

select 
name
from track 
where bytes > 100 * 1048576;

select 
name, composer
from track 
where composer != 'U2'
limit 10 
offset 9;

