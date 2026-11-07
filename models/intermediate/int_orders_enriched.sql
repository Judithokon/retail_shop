with orders as (
    select * from {{ ref('stg_orders') }}
),

item_totals as (
    select
        order_id,
        count(*)                 as item_count,
        sum(quantity)            as units,
        sum(line_revenue_gbp)    as order_subtotal_gbp
    from {{ ref('int_order_items_enriched') }}
    group by order_id
),

payments as (
    select * from {{ ref('int_order_payments') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    o.shipped_date,
    datediff(o.shipped_date, o.order_date)          as days_to_ship,
    coalesce(i.item_count, 0)                       as item_count,
    coalesce(i.units, 0)                            as units,
    coalesce(i.order_subtotal_gbp, 0)               as order_subtotal_gbp,
    coalesce(p.payment_count, 0)                    as payment_count,
    coalesce(p.amount_paid_gbp, 0)                  as amount_paid_gbp,
    coalesce(p.is_split_payment, false)             as is_split_payment,
    coalesce(p.amount_paid_gbp, 0)
        >= coalesce(i.order_subtotal_gbp, 0)        as is_fully_paid
from orders o
left join item_totals i
    on o.order_id = i.order_id
left join payments p
    on o.order_id = p.order_id