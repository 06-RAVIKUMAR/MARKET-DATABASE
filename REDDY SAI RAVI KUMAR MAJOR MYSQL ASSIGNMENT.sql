use market_star_schema;
QUESTION 1
select m.Ord_id,m.Ship_id,m.Shipping_Cost,s.Ship_Date
From market_fact_full as m
Join shipping_dimen as s
On m.Ship_id = s.Ship_id;
QUESTION 2
select c.Customer_Name,c.City,c.State,m.Ord_id,m.Order_Quantity
from cust_dimen as c
join market_fact_full as m
on c.Cust_id = m.Cust_id;
QUESTION 3
select s.Order_ID,s.Ship_id,s.Ship_Mode
from market_fact_full as m
join shipping_dimen as s
on m.Ship_id = s.Ship_id
where s.Ship_Mode = "Regular Air";
QUESTION 4 
select Order_Number,Order_Priority,
case
	when Order_Priority = "CRITICAL" then "IMMEDIATE DELIVERY"
    when Order_Priority = "HIGH" then "IMMEDIATE DELIVERY"
    else "NORMAL DELIVERY"
end as Delivery_type
from orders_dimen;
QUESTION 5
select *
from cust_dimen
where State = "West Bengal";
QUESTION 6
select Ord_id,Prod_id,Ship_id,Cust_id,Discount,Order_Quantity
from market_fact_full
Where (Discount > 0.05) and (Order_Quantity > 10)
order by 5,6;
QUESTION 7
CREATE TABLE Shipping_mode_dimen(
		ship_mode VARCHAR(25),
        vehicle_company VARCHAR(25),
        toll_required boolean
);
QUESTION 8
CREATE TABLE Shipping_mode_dimen(
		ship_mode VARCHAR(25),
        vehicle_company VARCHAR(25),
        toll_required boolean
)
alter table Shipping_mode_dimen add constraint primary key (ship_mode);
QUESTION 9
insert into Shipping_mode_dimen(ship_mode,vehicle_company,toll_required)
values('delivery truck','ashok leyland',false),
	  ('regular air', 'air india',false);
QUESTION 10
alter table Shipping_mode_dimen add column vehicle_number VARCHAR(22)
QUESTION 11
UPDATE Shipping_mode_dimen
SET vehicle_number = "MH-05-R1234";
QUESTION 12
select *
from cust_dimen
where (city = "Mumbai") or Customer_Segment = ("CORPORATE");
QUESTION 13
select count(sales)
from market_fact_full;
QUESTION 14
select count(distinct Customer_Name),city
from cust_dimen
group by 2;
QUESTION 15
select distinct Customer_Name
from cust_dimen
order by 1;
QUESTION 16
select Prod_id,sum(Order_Quantity)
from market_fact_full
group by Prod_id
order by 2 desc
limit 3;
QUESTION 17
select count(Ord_id),month(Order_Date),year(Order_Date),Order_Priority
from orders_dimen
where Order_Priority = "CRITICAL"
group by 2,3
order by 1 desc;
QUESTION 18
select count(Ship_id),ship_Mode,Ship_Date
from shipping_dimen
where year (Ship_Date) = 2011
group by 2
order by 1 desc;
QUESTION 19
select *
from cust_dimen
where Cust_id = (select Cust_id from market_fact_full group by Cust_id limit 1);
QUESTION 20
select count(Ord_id),Order_Number,Month(Order_Date),Order_Priority
from orders_dimen
Where (Month(Order_Date) = 4) and (Order_Priority = "LOW") and (Day(Order_Date) between 1 and 15);
						
                        (or)
                        
with low_priority_orders as (select Ord_id,Order_Date,Order_Priority
							 from orders_dimen
                             where Order_priority = "LOW" and Month(Order_Date) = 4)
select count(Ord_id)
from low_priority_orders
where day(Order_Date) between 1 and 15;
QUESTION 21
select c.Cust_id,c.Customer_Name,m.Ord_id,round(Sales),
		rank()over(order by sales desc) AS sales_ranks
from cust_dimen AS c
join market_fact_full as m
on c.Cust_id = M.Cust_id
where Customer_Name = "AARON SMAYLING";
QUESTION 22
select c.Cust_id,c.Customer_Name,m.Ord_id,Discount,
		rank()over(order by Discount asc) as RANKS,
        dense_rank() over (order by Discount asc) AS DENSE_RANKS
from cust_dimen AS c
join market_fact_full as m
on c.Cust_id = M.Cust_id
where Customer_Name = "AARON SMAYLING";
QUESTION 23
select Customer_Name,Ord_id,
		rank()over(order by Ord_id asc) as RANKS_by_shipping,
        dense_rank()over(order by Ord_id asc) as DENSE_RANKS,
        row_number()over(order by Ord_id asc) as ROW_RANKS
from market_fact_full as m
join cust_dimen as c
on m.Cust_id = c.Cust_id
where Customer_Name = "AARON SMAYLING";












