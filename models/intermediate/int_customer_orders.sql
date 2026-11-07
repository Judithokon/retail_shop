with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('int_orders_enriched') }}
),

order_stats as (
    select
        customer_id,
        sum(case when order_status != 'cancelled' then 1 else 0 end)      as total_orders,
        min(order_date)                                                   as first_order_date,
        max(order_date)                                                   as last_order_date,
        sum(case when order_status not in ('cancelled', 'returned')
                 then amount_paid_gbp else 0 end)                         as lifetime_value_gbp
    from orders
    where customer_id is not null
    group by customer_id
)

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.country,
    c.signup_date,
    s.first_order_date,
    s.last_order_date,
    coalesce(s.total_orders, 0)          as total_orders,
    coalesce(s.lifetime_value_gbp, 0)    as lifetime_value_gbp,
    case
        when coalesce(s.total_orders, 0) = 0 then 'no orders'
        when s.total_orders = 1             then 'new'
        when s.total_orders <= 5            then 'returning'
        else 'loyal'
    end                                  as customer_segment
from customers c
left join order_stats s
    on c.customer_id = s.customer_id