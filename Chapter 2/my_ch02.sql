select
   minus_all_table.id   as p_id
 , minus_all_table.name as product_name
from table(
   cast(
      multiset(
         select product_id, product_name
         from customer_order_products
         where customer_id = 50741
      )
      as id_name_coll_type
   )
   multiset except all
   cast(
      multiset(
         select product_id, product_name
         from customer_order_products
         where customer_id = 50042
      )
      as id_name_coll_type
   )
) minus_all_table
order by p_id;

select
   product_id as p_id
 , product_name
 , row_number() over (
      partition by product_id, product_name
      order by rownum
   ) as rn
from customer_order_products
where customer_id = 50741
minus
select
   product_id as p_id
 , product_name
 , row_number() over (
      partition by product_id, product_name
      order by rownum
   ) as rn
from customer_order_products
where customer_id = 50042
order by p_id;