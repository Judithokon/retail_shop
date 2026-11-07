select
    customer_id,
    customer_name,
    email,
    country,
    signup_date,
    first_order_date,
    last_order_date,
    total_orders,
    lifetime_value_gbp,
    customer_segment
from {{ ref('int_customer_orders') }}
