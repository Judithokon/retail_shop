with source as (
    select * from {{ source('retail_raw', 'products') }}
),

cleaned as (
    select
        cast(product_id as int)              as product_id,
        trim(product_name)                   as product_name,
        trim(category)                       as category,
        cast(unit_price as decimal(10, 2))   as unit_price_gbp
    from source
)

select * from cleaned