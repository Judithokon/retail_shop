with items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
)

select
    i.order_item_id,
    i.order_id,
    i.product_id,
    p.product_name,
    p.category,
    i.quantity,
    p.unit_price_gbp,
    i.quantity * p.unit_price_gbp    as line_revenue_gbp
from items i
left join products p
    on i.product_id = p.product_id