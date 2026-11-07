with source as (
    select * from {{ source('retail_raw', 'payments') }}
),

cleaned as (
    select
        cast(payment_id as int)            as payment_id,
        cast(order_id as int)              as order_id,
        lower(trim(payment_method))        as payment_method,
        cast(amount as decimal(10, 2))     as amount_gbp,
        cast(paid_at as timestamp)         as paid_at
    from source
)

select * from cleaned