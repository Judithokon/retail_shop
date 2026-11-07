select
    order_id,
    count(*)            as payment_count,
    sum(amount_gbp)     as amount_paid_gbp,
    max(paid_at)        as last_paid_at,
    count(*) > 1        as is_split_payment
from {{ ref('stg_payments') }}
group by order_id