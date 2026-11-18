-- One clean row per customer.
-- The CRM sometimes re-sends a customer record; we keep only the latest version.
with source as (
    select * from {{ source('raw', 'customers') }}
)

select
    id                               as customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name   as customer_name,
    lower(email)                     as email,
    city,
    signup_date
from source
qualify row_number() over (partition by id order by _loaded_at desc) = 1
