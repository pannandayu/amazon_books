-- author count
select count(distinct Author) as "Author Count"
from books;

-- book name filtering
select *
from books b
where Name like '%nes%';

-- count of books over years
select `Year`, count(distinct name) as "Books Over Years"
from books
group by `Year`;

-- dataset filtering
select *
from books
where `Year` in (2013, 2015) and `User Rating` > 4.5 and Reviews > 10000 and Price < 100 and not Genre = 'Non Fiction'
		and Author like '%k%';

-- books filtering by author
select *
from books
where Author in ('George R. R. Martin','JJ Smith', 'Stephen King')
order by `Year`;

-- aggregating avergare reviews, rating, and price by genre
select Genre, avg(Reviews) as "Average Reviews", avg(`User Rating`) as "Average User Rating",
	   avg(Price) as "Average Price"
from books
group by Genre
order by 1;

-- book price filter
with price
as 
(
	select Author, sum(Price) as "Total Price"
	from books
	group by Author
)
select *
from price
where `Total Price` > (select avg(`Total Price`) from price);

-- review and rating filter
with rr
as 
(
	select Author, avg(Reviews) as "Average Reviews", avg(`User Rating`) as "Average User Rating",
		   avg(Price) as "Average Price",
		   case
		   when avg(Reviews) > 7000 and avg(`User Rating`) >= 4.5 then 'High Reviews and High Ratings'
		   when avg(Reviews) > 7000 and avg(`User Rating`) < 4.5 then 'High Reviews and Low Ratings'
		   when avg(Reviews) < 7000 and avg(`User Rating`) >= 4.5 then 'Low Reviews and High Ratings'
		   else 'Low Reviews and Low Ratings'
		   end as 'Reviews and Ratings'
	from books b
	group by Author
)
select `Reviews and Ratings`, count(`Reviews and Ratings`) as 'Counts'
from rr
group by `Reviews and Ratings`
order by 1;