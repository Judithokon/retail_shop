WITH source as (select * from {{ source('retail_raw', 'customers') }})

,cleaned as (
    select
        cast(id as int)                  as customer_id,
        initcap(trim(customer_name))     as customer_name,
        lower(trim(email))               as email,
        trim(country)                    as country,
        cast(signup_date as date)        as signup_date
    from source
)

select * from cleaned