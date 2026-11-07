{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'order_id',
        on_schema_change = 'append_new_columns'
    )
}}

with orders as (
    select * from {{ ref('int_orders_enriched') }}
    {% if is_incremental() %}
    where order_date >= (
        select date_sub(max(order_date), {{ var('fct_orders_lookback_days', 30) }})
        from {{ this }}
    )
    {% endif %}
)

select
    order_id,
    customer_id,
    order_date,
    order_status,
    shipped_date,
    days_to_ship,
    item_count,
    units,
    order_subtotal_gbp,
    amount_paid_gbp,
    payment_count,
    is_split_payment,
    is_fully_paid
from orders