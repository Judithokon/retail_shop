with products as (
    select * from {{ ref('stg_products') }}
),

items as (
    select * from {{ ref('int_order_items_enriched') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

sales as (
    select
        i.product_id,
        count(distinct i.order_id)    as orders_count,
        sum(i.quantity)               as units_sold,
        sum(i.line_revenue_gbp)       as revenue_gbp
    from items i
    inner join orders o
        on i.order_id = o.order_id
    where o.order_status not in ('cancelled', 'returned')
    group by i.product_id
)

select
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price_gbp,
    case
        when p.unit_price_gbp < 10  then 'budget'
        when p.unit_price_gbp <= 30 then 'mid'
        else 'premium'
    end                               as price_band,
    coalesce(s.orders_count, 0)       as orders_count,
    coalesce(s.units_sold, 0)         as units_sold,
    coalesce(s.revenue_gbp, 0)        as revenue_gbp
from products p
left join sales s
    on p.product_id = s.product_id