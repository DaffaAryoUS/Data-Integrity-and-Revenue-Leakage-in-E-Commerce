-- Rename nama table
alter table train_data_olist_customers rename to customers;

alter table train_data_olist_order_items rename to order_items;

alter table train_data_olist_orderss rename to orders;

alter table train_data_olist_products rename to products;

---------------------- Table Preparation ----------------------
---------------------------------------------------------------
-- Jumlah baris
-- cek jumlah baris (15.000)
select * from customers;
select count(*) as jumlah_baris
from customers;

select * from order_items;
select count(*) as jumlah_baris
from order_items;

select * from orders;
select count(*) as jumlah_baris
from orders;

select * from products;
select count(*) as jumlah_baris
from products;

-- Pemeriksaan tipe data
select 
    table_name, 
    column_name, 
    data_type,
    character_maximum_length as max_length
from information_schema.columns
where table_schema = 'MiniProject_SQL_DaffaAryo_DA3'
  and table_name in ('customers','order_items', 'orders', 'products')
order by table_name, ordinal_position;

-- Pemeriksaan missing Value
-- cek missing value table customers
select
'customer_id' as nama_kolom,
count(*)filter(where customer_id is null) as jumlah_missing_value
from customers
union all
select
'customer_unique_id',
count(*)filter(where customer_unique_id is null)
from customers
union all
select
'customer_zip_code_prefix',
count(*)filter(where customer_zip_code_prefix is null)
from customers
union all
select
'customer_city',
count(*)filter(where customer_city is null)
from customers
union all
select
'customer_state',
count(*)filter(where customer_state is null)
from customers;

-- cek missing value table order_items
select count(*) from order_items;
select
'order_id' as nama_kolom,
count(*)filter(
	where order_id is null
	or trim(order_id) = ''
	) as jumlah_missing_value
from order_items
union all
select
'order_item_id',
count(*)filter(
	where order_item_id is null
	)
from order_items
union all
select
'product_id',
count(*)filter(
	where product_id is null
	or trim(product_id) = ''
	)
from order_items
union all
select
'seller_id',
count(*)filter(
	where seller_id is null
	or trim(seller_id) = ''
	)
from order_items
union all
select
'shipping_limit_date',
count(*)filter(
	where shipping_limit_date is null
	or trim(shipping_limit_date) = ''
	)
from order_items
union all
select
'price',
count(*)filter(
	where price is null
	)
from order_items
union all
select
'freight_value',
count(*)filter(
	where freight_value is null
	)
from order_items;

-- cek missing value table orders
select
'order_id' as nama_kolom,
count(*)filter(
	where order_id is null
	or trim(order_id) = ''
	) as jumlah_missing_value
from orders
union all
select
'customer_id',
count(*)filter(
	where customer_id is null
	or trim(customer_id) = ''
	)
from orders
union all
select
'order_status',
count(*)filter(
	where order_status is null
	or trim(order_status) = ''
	)
from orders
union all
select
'order_purchase_timestamp',
count(*)filter(
	where order_purchase_timestamp is null
	)
from orders
union all
select
'order_approved_at',
count(*)filter(
	where order_approved_at is null
	or trim(order_approved_at) = ''
	)
from orders
union all
select
'order_delivered_carrier_date',
count(*)filter(
	where order_delivered_carrier_date is null
	or trim(order_delivered_carrier_date) = ''
	)
from orders
union all
select
'order_delivered_customer_date',
count(*)filter(
	where order_delivered_customer_date is null
	or trim(order_delivered_customer_date) = ''
	)
from orders
union all
select
'order_estimated_delivery_date',
count(*)filter(
	where order_estimated_delivery_date is null
	or trim(order_estimated_delivery_date) = ''
	)
from orders;

-- cek missing value table products
select
'product_id' as nama_kolom,
count(*)filter(
	where product_id is null
	or trim(product_id) = ''
	) as jumlah_missing_value
from products
union all
select
'product_category_name',
count(*)filter(
	where product_category_name is null
	or trim(product_category_name) = ''
	)
from products
union all
select
'product_name_lenght',
count(*)filter(
	where product_name_lenght is null
	)
from products
union all
select
'product_description_lenght',
count(*)filter(
	where product_description_lenght is null
	)
from products
union all
select
'product_photos_qty',
count(*)filter(
	where product_photos_qty is null
	)
from products
union all
select
'product_weight_g',
count(*)filter(
	where product_weight_g is null
	)
from products
union all
select
'product_length_cm',
count(*)filter(
	where product_length_cm is null
	)
from products
union all
select
'product_height_cm',
count(*)filter(
	where product_height_cm is null
	)
from products
union all
select
'product_width_cm',
count(*)filter(
	where product_width_cm is null
	)
from products;

-- Pemeriksaan duplicate
-- cek duplicate customer_id
select
count(*) as jumlah_id_duplikat
from(
	select 
	customer_id, 
	count(*)
	from customers
	group by customer_id
	having count(*) > 1
);
-- cek duplikat order_id pada table orders
select
count(*) as jumlah_id_duplikat
from(
	select 
	order_id, 
	count(*)
	from orders
	group by order_id
	having count(*) > 1
);
-- cek duplikat product_id pada table products
select
count(*) as jumlah_id_duplikat
from(
	select 
	product_id, 
	count(*)
	from products
	group by product_id
	having count(*) > 1
);

-- Pemeriksaan unique value table customers
select
count(distinct customer_id) as unique_customer_id,
count(distinct customer_unique_id) as unique_customer_unique_id,
count(distinct customer_zip_code_prefix) as unique_customer_zip_code_prefix,
count(distinct customer_city) as unique_customer_city,
count(distinct customer_state) as unique_customer_state
from customers;

-- Temuan: terdapat customer_unique_id yang memiliki beberapa customer_id
select distinct customer_unique_id
from customers;
-- duplikat
select 
customer_unique_id,
count(*) as jumlah_duplikat
from customers
group by customer_unique_id
having count(*) > 1;
-- 
select 
customer_unique_id,
customer_id
from customers
where customer_unique_id in (
	select 
	customer_unique_id
	from customers
	group by customer_unique_id
	having count(*) > 1
)
group by customer_unique_id, customer_id;
-- Jumlah customer_unique_id yang memiliki duplikat
select count(*)
from(
	select customer_unique_id, 
	count(*)
	from customers
	group by customer_unique_id
	having count(*) > 1
);
-- unique customer_city
select distinct customer_city
from customers
order by customer_city;

-- unique customer_state
select distinct customer_state
from customers
order by customer_state;

-- Pemeriksaan unique value order_status table orders
select
count(distinct order_status) as unique_order_status
from orders;

select
distinct order_status
from orders;

-- Pemeriksaan unique value product_category_name table products 
select
count(distinct product_category_name) as unique_product_category_name
from products;

select
distinct product_category_name
from products
order by product_category_name;

-- membuat table cleaning
create table c_customers as
select * from customers;

create table c_order_items as
select * from order_items;

create table c_orders as
select * from orders;

create table c_products as
select * from products;

-- penyeragaman format pada kolom kategori
-- table customers
update c_customers
set customer_city = trim(customer_city);
update c_customers
set customer_city = lower(customer_city);
update c_customers
set customer_state = trim(customer_state);
update c_customers
set customer_state = upper(customer_state);

-- table products
update c_products
set product_category_name = trim(product_category_name);
update c_products
set product_category_name = lower(product_category_name);

-- handle missing value
-- table orders
-- mengisi nilai missing dengan null
update c_orders
set order_approved_at = null
where trim(order_approved_at) = '';

update c_orders
set order_delivered_carrier_date = null
where trim(order_delivered_carrier_date) = '';

update c_orders
set order_delivered_customer_date = null
where trim(order_delivered_customer_date) = '';

-- table products
update c_products
set product_category_name = 'unkown' -- isi unknown untuk nama kategori produk yang kosong
where trim(product_category_name) = '';

update c_products
set product_name_lenght = 0 -- isi 0 untuk panjang karakter nama produk yang kosong
where product_name_lenght is null;

update c_products
set product_description_lenght = 0 -- isi 0 untuk panjang karakter deskripsi produk yang kosong
where product_description_lenght is null;

update c_products
set product_photos_qty = 0 -- isi 0 untuk jumlah foto produk yang kosong
where product_photos_qty is null;

-- mengubah tipe data
-- table orders
-- ubah tipe data varchar menjadi timestamp
alter table c_orders
alter column order_purchase_timestamp type timestamp(0)
using order_purchase_timestamp::timestamp(0);

alter table c_orders
alter column order_approved_at type timestamp(0)
using order_approved_at::timestamp(0);

alter table c_orders
alter column order_delivered_carrier_date type timestamp(0)
using order_delivered_carrier_date::timestamp(0);

alter table c_orders
alter column order_delivered_customer_date type timestamp(0)
using order_delivered_customer_date::timestamp(0);

-- ubah tipe data varchar menjadi date
alter table c_orders
alter column order_estimated_delivery_date type date
using order_estimated_delivery_date::date;

-- table orders
-- ubah tipe data varchar menjadi timestamp
alter table c_order_items
alter column shipping_limit_date type timestamp(0)
using shipping_limit_date::timestamp(0);

-- Penambahan constraint
-- primary key
alter table c_customers
add constraint pk_customers primary key (customer_id);
alter table c_orders
add constraint pk_orders primary key (order_id);
alter table c_products
add constraint pk_products primary key (product_id);

-- not null
alter table c_customers
alter column customer_id set not null;
alter table c_customers
alter column customer_unique_id set not null;

alter table c_orders
alter column order_id set not null;

alter table c_order_items
alter column order_id set not null;
alter table c_order_items
alter column order_item_id set not null;
alter table c_order_items
alter column product_id set not null;
alter table c_order_items
alter column seller_id set not null;

-- pemeriksaan outlier
-- table order_items
-- kolom price
-- jumlah outlier:
with
stats as (
	select
		PERCENTILE_CONT(0.25) within group (order by price) as q1,
		PERCENTILE_CONT(0.75) within group (order by price) as q3
	from c_order_items
),
bonds as (
	select
		(q1 - 1.5*(q3-q1)) as lower_bond,
		(q3 + 1.5*(q3-q1)) as upper_bond
	from stats
)
select 
count(*) as jumlah_outlier
from c_order_items oi
cross join bonds
where 
oi.price < lower_bond
or oi.price > upper_bond;

-- outlier upper dan lower
with
stats as (
	select
		PERCENTILE_CONT(0.25) within group (order by price) as q1,
		PERCENTILE_CONT(0.75) within group (order by price) as q3
	from c_order_items
),
bonds as (
	select
		(q1 - 1.5*(q3-q1)) as lower_bond,
		(q3 + 1.5*(q3-q1)) as upper_bond
	from stats
)
select * from bonds;
-- outlier: 1.135 (karena outlier lebih dari 5%, maka akan diabiarkan)

with
stats as (
	select
		PERCENTILE_CONT(0.25) within group (order by freight_value) as q1,
		PERCENTILE_CONT(0.75) within group (order by freight_value) as q3
	from c_order_items
),
bonds as (
	select
		(q1 - 1.5*(q3-q1)) as lower_bond,
		(q3 + 1.5*(q3-q1)) as upper_bond
	from stats
)
select 
count(*) as jumlah_outlier
from c_order_items oi
cross join bonds
where 
oi.freight_value < lower_bond
or oi.freight_value > upper_bond;

-- outlier upper dan lower
with
stats as (
	select
		PERCENTILE_CONT(0.25) within group (order by freight_value) as q1,
		PERCENTILE_CONT(0.75) within group (order by freight_value) as q3
	from c_order_items
),
bonds as (
	select
		(q1 - 1.5*(q3-q1)) as lower_bond,
		(q3 + 1.5*(q3-q1)) as upper_bond
	from stats
)
select * from bonds;
-- outlier: 1.613 (karena outlier lebih dari 5%, maka akan diabiarkan)

-- data issue
alter table c_orders
add constraint fk_order_customer 
foreign key (customer_id)
references c_customers(customer_id);

-- pemeriksaan customer_id pada table orders dengan customers
-- list id yang tidak terdapat pada table customers
SELECT o.customer_id
FROM c_orders o
LEFT JOIN c_customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- jumlah orphan id
select
count(distinct customer_id) as jumlah_orphan_id
from (
	SELECT o.customer_id
	FROM orders o
	LEFT JOIN customers c
	ON o.customer_id = c.customer_id
	WHERE c.customer_id IS NULL
);

with jumlah_orphan_id as (
	SELECT o.customer_id
	FROM orders o
	LEFT JOIN customers c
	ON o.customer_id = c.customer_id
	WHERE c.customer_id IS null
)
select
count(jo.customer_id) as jumlah_orphan,
count(o.customer_id) as orders_customer_id,
round(
count(distinct jo.customer_id) * 100 / count(distinct o.customer_id):: numeric
, 2) as "persentase_orphan(%)"
from c_orders o
left join jumlah_orphan_id jo
on o.customer_id = jo.customer_id;

-- pemeriksaan order_id pada table order_items dengan orders
-- list id yang tidak terdapat pada table orders
select * from c_order_items;

SELECT oi.order_id
FROM c_order_items oi
LEFT JOIN c_orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- jumlah orphan id
select
count(distinct order_id) as jumlah_orphan_id
from (
	SELECT oi.order_id
	FROM c_order_items oi
	LEFT JOIN c_orders o
	ON oi.order_id = o.order_id
	WHERE o.order_id IS NULL
);

-- pemeriksaan product_id pada table order_items dengan products
-- list id yang tidak terdapat pada table order_items
select * from c_order_items;

SELECT oi.product_id
FROM c_order_items oi
LEFT JOIN c_products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- jumlah orphan id
select
count(distinct product_id) as jumlah_orphan_id
from (
	SELECT oi.product_id
	FROM c_order_items oi
	LEFT JOIN c_products p
	ON oi.product_id = p.product_id
	WHERE p.product_id IS NULL
);

-- handling data issues
-- pembuatan table baru dengan table orders yang memiliki data customer_id yang sama dengan table customers
create table cus_orders as
select o.*
from c_orders o
inner join c_customers c
on o.customer_id = c.customer_id;

select * from cus_orders;
-- cek table orders baru( jumlah row: 2.236)
select count(distinct customer_id) from cus_orders;
select count(*) as jumlah_row_table_baru
from cus_orders;

-- periksa jumlah customer_id unique (jumlah sudah sesuai)
select count(*)
from (
	select distinct oc.customer_id
	from cus_orders oc
	inner join customers c
	on oc.customer_id = c.customer_id
	where c.customer_id is not null
);

-- pembuatan table baru dengan table order_items yang memiliki data product_id yang sama dengan table products
create table prod_items as
select oi.*
from c_order_items oi
inner join c_products p
on oi.product_id = p.product_id;

select * from prod_items;
-- cek table orders baru( jumlah row: 6.756)
select count(distinct product_id) from prod_items;
select count(*) as jumlah_row_table_baru
from prod_items;

-- membuat constraint
alter table cus_orders
add constraint pk_co_order_id
primary key (order_id);

alter table cus_orders
add constraint fk_co_customers_id
foreign key (customer_id)
references c_customers(customer_id);

alter table cus_orders
alter column order_id set not null;

alter table prod_items
add constraint pk_products 
foreign key (product_id)
references c_products(product_id);

-- Data Exploration
--------- Table customers -----------
-------------------------------------

-- nama kota
select distinct customer_city
from c_customers
order by customer_city;

-- jumlah kota: 1.961
select count(distinct customer_city) as jumlah_kota
from c_customers;

-- jumlah customer tiap kota
select 
distinct customer_city,
count(customer_city) as jumlah_customer
from c_customers
group by customer_city
order by jumlah_customer desc;

-- kode state
select distinct customer_state
from c_customers
order by customer_state;

-- jumlah sate: 27
select count(distinct customer_state) as jumlah_kota
from c_customers;

-- jumlah customer tiap state
select 
distinct customer_state,
count(customer_state) as jumlah_customer
from c_customers
group by customer_state
order by jumlah_customer desc;

-- jumlah city per state
select
customer_state,
count(distinct customer_city) as total_city
from c_customers
group by customer_state
order by total_city desc;

-- melihat distribusi setiap kota berdasarkan populasi state
select
customer_state,
customer_city,
count(*) as total_customer,
sum(count(*)) over (partition by customer_state) as total_customer_state,
round(count(*) * 100 / sum(count(*)) over(), 2) as "persentase_proporsi(%)"
from c_customers
group by customer_state, customer_city
order by total_customer desc;

-- melihat distribusi setiap kota berdasarkan populasi state
select
customer_state,
count(*) as total_customer,
round(count(*) * 100 / sum(count(*)) over(), 2) as "persentase_proporsi(%)"
from c_customers
group by customer_state
order by total_customer desc;

-- rank
select
customer_state,
customer_city,
count(*) as total_customer,
dense_rank () over(
	order by count(*) desc
) as ranking_global,
dense_rank() over(
		partition by customer_state
		order by count(*) desc
		) as ranking_state
from c_customers
group by customer_state, customer_city
order by ranking_global;

-- distribusi cumulative
with customer_count as (
	select
	customer_city,
	count(*) as total_customer
	from c_customers
	group by customer_city
)
select
customer_city,
total_customer,
sum(total_customer) over (order by total_customer desc) as distribusi_cumulative,
round(sum(total_customer) over (order by total_customer desc) * 100 / sum(total_customer) over(), 2) as "persentase_cumulative(%)"
from customer_count
order by total_customer desc;

-- top 3 city per state
select *
from(
	select
	customer_state,
	customer_city,
	count(*) as total_customer,
	row_number() over(
					partition by customer_state
					order by count(*) desc
					) as state_ranking
	from c_customers
	group by customer_state, customer_city
) t
where state_ranking <=3;

-- ketimpangan distribusi
with city_count as (
	select
	customer_city,
	count(*) as total_customer
	from c_customers
	group by customer_city
)
select
max(total_customer) as max_customer_city,
min(total_customer) as min_customer_city,
max(total_customer) * 1.0 / min(total_customer) as ratio
from city_count;

--------- Table orders -------------
-------------------------------------

-- periksa jumlah untuk setiap order status
select
distinct order_status,
(
	select count(*)
	from c_orders o2
	where o2.order_status = o1.order_status
) as total,
round(count(*) * 100 / sum(count(*)) over(), 2) as "persentase(%)"
from c_orders o1
group by order_status
order by total desc;

-- tren order bulanan
with order_bulanan as (
	select
	date_trunc('month', order_purchase_timestamp) as bulan,
	count(*) as total_order
	from c_orders
	group by bulan
),
kalkulasi_growth as (
	select
	bulan,
	total_order,
	lag(total_order) over (order by bulan) as bulan_sebelumnya,
	total_order - lag(total_order) over (order by bulan) as growth
	from order_bulanan
)
select
    bulan,
    total_order,
    bulan_sebelumnya,
    growth,
    round(growth * 100 / nullif(bulan_sebelumnya, 0)::numeric, 2) as "growth_persen(%)"
from kalkulasi_growth
order by bulan;

-- akurasi estimasi pengiriman
with avg_pengiriman as (
	select
		avg(order_estimated_delivery_date - order_purchase_timestamp) as avg_estimasi_pengiriman,
		avg(order_delivered_customer_date - order_purchase_timestamp) as avg_pengiriman_aktual
	from c_orders
)
select
avg_estimasi_pengiriman,
avg_pengiriman_aktual,
avg_estimasi_pengiriman - avg_pengiriman_aktual as selisih
from avg_pengiriman;

--------- Table order_items ------------
----------------------------------------

-- jumlah produk yang dijual
select count(distinct product_id) as jumlah_produk
from c_order_items;

-- jumlah seller yang mendapatkan order
select count(distinct seller_id) as jumlah_produk
from c_order_items;

-- matric revenue
select
sum(price) as total_prodcut_revenue,
sum(freight_value) as total_freight_value,
sum(price + freight_value) as total_revenue,
round(avg(price + freight_value):: numeric, 2) as avg_revenue,
round(avg(price):: numeric, 2) as avg_price,
round(avg(freight_value):: numeric, 2) as avg_freight
from c_order_items;

-- nilai max, min, avg dari price dan freight
select
max(price) as max_price,
min(price) as min_price,
max(freight_value) as max_fright_value,
min(freight_value) as min_fright_value
from c_order_items;

-- rasio ongkir dan price
select
avg(freight_value/price) as avg_ratio_fright
from c_order_items;

-- Top product by total terjual
select
oi.product_id,
p.product_category_name,
count(*) as total_terjual
from c_order_items oi
left join c_products p
on oi.product_id = p.product_id 
group by oi.product_id, p.product_category_name
order by total_terjual desc;

-- jumlah produk
select count(*) as jumlah_produk
from(
	select
	oi.product_id,
	p.product_category_name,
	count(*) as total_terjual
	from c_order_items oi
	left join c_products p
	on oi.product_id = p.product_id 
	group by oi.product_id, p.product_category_name
	order by total_terjual desc
);

-- rank top product
select 
oi.product_id,
p.product_category_name,
round(sum(price):: numeric, 2) as sales_revenue,
rank() over(
	order by sum(price) desc
) as ranking_product
from c_order_items oi
left join c_products p
on oi.product_id = p.product_id
group by oi.product_id, p.product_category_name;

-- rank top seller
select
seller_id,
round(sum(price)::numeric, 2) as seller_revenue,
rank() over(
	order by sum(price) desc
) as ranking_seller
from c_order_items
group by seller_id;

-- top revenue berdasarkan city
select 
c.customer_city,
round(sum(price):: numeric, 2) as sales_revenue,
rank() over(
	order by sum(price) desc
) as ranking_product
from c_order_items oi
left join c_orders o
on oi.order_id = o.order_id
left join c_customers c
on o.customer_id = c.customer_id
group by c.customer_city;

-- top revenue berdasarkan state
select 
c.customer_state,
round(sum(price):: numeric, 2) as sales_revenue,
rank() over(
	order by sum(price) desc
) as ranking_product
from c_order_items oi
left join c_orders o
on oi.order_id = o.order_id
left join c_customers c
on o.customer_id = c.customer_id
group by c.customer_state;

--------- Table products ---------------
----------------------------------------
-- kategori produk
select distinct product_category_name 
from c_products
order by product_category_name;

-- jumlah produk
select count(distinct product_category_name) from c_products;

-- distribusi kategori
select
product_category_name,
count(*) as total_produk,
round(count(*) * 100 / sum(count(*)) over(), 2) as "persentase(%)"
from c_products
group by product_category_name 
order by total_produk desc;

-- min, max, dan avg berat product
select
min(product_weight_g) as min_berat_produk,
max(product_weight_g) as max_berat_produk,
round(avg(product_weight_g):: numeric, 2) as avg_berat_produk
from c_products;

-- volume produk
select
product_id,
(product_length_cm * product_height_cm * product_width_cm) as volume
from c_products
order by volume desc;

-- perbandingan jumlah photo produk
select
product_id,
product_category_name,
product_photos_qty,
lead(product_photos_qty) over(
	partition by product_category_name
	order by product_photos_qty desc
	) as next_photo_qty
from c_products;

------- analisis join ---------
-------------------------------
-- konversi order berdasarkan city (untuk 10 city dengan populasi terbanyak)
select
c.customer_city,
c.customer_state,
count(distinct c.customer_id) AS total_customer,
count(o.order_id) AS total_orders,
round(count(o.order_id) * 1.0 / NULLIF(COUNT(DISTINCT c.customer_id), 0), 2) AS ratio_order
from c_customers c
left join c_orders o
on c.customer_id = o.customer_id
group by c.customer_city, c.customer_state
order by total_customer desc
limit 10;

 -- konversi order berdasarkan state (untuk 10 state dengan populasi terbanyak)
select
c.customer_state,
count(distinct c.customer_id) AS total_customer,
count(o.order_id) AS total_orders,
round(count(o.order_id) * 1.0 / NULLIF(COUNT(DISTINCT c.customer_id), 0), 2) AS ratio_order
from c_customers c
left join c_orders o
on c.customer_id = o.customer_id
group by c.customer_state
order by total_customer desc
limit 10;

-- Revenue per order berdasarkan state
with state_revenue as (
    select
    c.customer_state,
    sum(oi.price)::numeric as total_sales,
    count(distinct oi.order_id) as total_orders
    from c_order_items oi
    left join c_orders o on oi.order_id = o.order_id
    left join c_customers c ON o.customer_id = c.customer_id
    where c.customer_city is not null 
    and o.order_status not in ('canceled', 'unavailable')
    group by c.customer_state
)
select
customer_state,
round(total_sales, 2) as total_sales_revenue,
total_orders,
round((total_sales * 1.0 / nullif(total_orders, 0))::numeric, 2) as revenue_per_order,
dense_rank() over (
        order by (total_sales * 1.0 / nullif(total_orders, 0)) desc
) as ranking_by_ratio
from state_revenue
order by revenue_per_order desc;

-- melihat durasi pengiriman setiap state
select
c.customer_state,
count(o.order_id) as total_pesanan,
round(avg(extract(day from (o.order_delivered_customer_date - o.order_purchase_timestamp)))::numeric, 1
 ) as avg_durasi_kirim_hari
from c_orders o
join c_customers c on o.customer_id = c.customer_id
where o.order_status = 'delivered' 
and o.order_delivered_customer_date is not null
group by c.customer_state
having count(o.order_id) >= 10
order by avg_durasi_kirim_hari;

------ Membuat View -----
-------------------------

-- revenue per order berdasarkan city
create view vw_city_revenue_performance as
with city_revenue as (
	select
	c.customer_city,
	c.customer_state,
	sum(oi.price)::numeric as total_sales,
	count(distinct oi.order_id) as total_orders
	from c_order_items oi
	left join c_orders o on oi.order_id = o.order_id
	left join c_customers c on o.customer_id = c.customer_id
	where c.customer_city is not null 
	and o.order_status not in ('canceled', 'unavailable')
	group by c.customer_city, c.customer_state
)
select
customer_city,
customer_state,
round(total_sales, 2) as total_sales_revenue,
total_orders,
round((total_sales * 1.0 / nullif(total_orders, 0))::numeric, 2) as revenue_per_order,
dense_rank() over (
	order by (total_sales * 1.0 / nullif(total_orders, 0)) desc
) as ranking_by_ratio
from city_revenue;

-- tren order bulanan
create view vw_monthly_order_growth as
with order_bulanan as (
	select
	date_trunc('month', order_purchase_timestamp) as bulan,
	count(*) as total_order
	from c_orders
	group by bulan
),
kalkulasi_growth as (
	select
	bulan,
	total_order,
	lag(total_order) over (order by bulan) as bulan_sebelumnya,
	total_order - lag(total_order) over (order by bulan) as growth
	from order_bulanan
)
select
bulan,
total_order,
bulan_sebelumnya,
growth,
round(growth * 100 / nullif(bulan_sebelumnya, 0)::numeric, 2) as "growth_persen(%)"
from kalkulasi_growth;

-- melihat durasi pengiriman setiap city
create view vw_delivery_sla_performance as
select
c.customer_state,
c.customer_city,
count(o.order_id) as total_pesanan,
round(avg(extract(day from (o.order_delivered_customer_date - o.order_purchase_timestamp)))::numeric, 1) as avg_durasi_aktual_hari,
round(avg(extract(day from (o.order_estimated_delivery_date - o.order_purchase_timestamp)))::numeric, 1) as avg_durasi_estimasi_hari,
round(avg(extract(day from (o.order_delivered_customer_date - o.order_estimated_delivery_date)))::numeric, 1) as selisih_hari_vs_estimasi
from c_orders o
join c_customers c on o.customer_id = c.customer_id
where o.order_status = 'delivered' 
and o.order_delivered_customer_date is not null
group by c.customer_state, c.customer_city;