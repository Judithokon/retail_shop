with source as (
    select * from {{ source('retail_raw', 'orders') }}
),

cleaned as (
    select
        cast(order_id as int)             as order_id,
        try_cast(customer_id as int)      as customer_id,
        cast(order_date as date)          as order_date,
        lower(trim(status))               as order_status,
        try_cast(shipped_date as date)    as shipped_date
    from source
)

select * from cleaned