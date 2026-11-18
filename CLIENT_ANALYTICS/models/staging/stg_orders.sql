-- One row per order, with consistent column names and tidy status values.
select
    id                    as order_id,
    user_id               as customer_id,
    order_date,
    lower(trim(status))   as status
from {{ source('raw', 'orders') }}
