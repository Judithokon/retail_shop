with source as (
    select * from {{ source('retail_raw', 'order_items') }}
),

cleaned as (
    select
        cast(order_item_id as int)   as order_item_id,
        cast(order_id as int)        as order_id,
        cast(product_id as int)      as product_id,
        cast(quantity as int)        as quantity
    from source
)

select * from cleaned