select
    product_id,
    product_name,
    category,
    unit_price_gbp,
    price_band,
    orders_count,
    units_sold,
    revenue_gbp
from {{ ref('int_product_sales') }}