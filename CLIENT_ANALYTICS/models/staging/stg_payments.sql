-- One row per payment. Amounts are converted from paise to rupees using a
-- shared, reusable rule (macros/paise_to_rupees.sql) - written once, used everywhere.
select
    id                                as payment_id,
    order_id,
    payment_method,
    {{ paise_to_rupees('amount') }}   as amount_inr,
    created_at
from {{ source('raw', 'payments') }}
