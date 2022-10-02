select * from brewery_products;
select * from yearly_sales;

select * from brewery_products p, yearly_sales s where p.product_id = s.product_id and p.brewery_id = 518;

select
   brewery_name
 , product_id as p_id
 , product_name
 , yr
 , yr_qty
from (
   select
      bp.brewery_name
    , bp.product_id
    , bp.product_name
    , ys.yr
    , ys.yr_qty
    , row_number() over (
         partition by bp.product_id
         order by ys.yr_qty desc
      ) as rn
   from brewery_products bp
   join yearly_sales ys
      on ys.product_id = bp.product_id
   where bp.brewery_id = 518
)
where rn = 1
order by product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp,
 lateral(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   order by ys.yr_qty desc
   -- fetch first row only
) top_ys
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
cross apply(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   order by ys.yr_qty desc
   fetch first row only
) top_ys
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
outer apply(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   and ys.yr_qty < 400
   order by ys.yr_qty desc
   fetch first row only
) top_ys
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
join lateral(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   order by ys.yr_qty desc
   fetch first row only
) top_ys
    on 1 = 1     
   -- on top_ys.yr_qty < 400
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
join lateral(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   order by ys.yr_qty desc
   fetch first row only
) top_ys
    --on 1 = 1     
    on top_ys.yr_qty < 400
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
join lateral(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   and ys.yr_qty < 400
   order by ys.yr_qty desc
   fetch first row only
) top_ys
    on 1 = 1     
where bp.brewery_id = 518
order by bp.product_id;

select
   bp.brewery_name
 , bp.product_id as p_id
 , bp.product_name
 , top_ys.yr
 , top_ys.yr_qty
from brewery_products bp
join lateral(
   select
      ys.yr
    , ys.yr_qty
   from yearly_sales ys
   where ys.product_id = bp.product_id
   order by ys.yr_qty desc
   fetch first row only
) top_ys
    on 1 = 1     
where bp.brewery_id = 518
and top_ys.yr_qty < 400
order by bp.product_id;