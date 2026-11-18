-- One row per order with the total amount paid.
-- Built on the cleaned staging models via ref(), so dbt knows the build order
-- automatically - no hand-maintained run sequence.
with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select
        order_id,
        sum(amount_inr)  as amount_inr,
        count(*)         as number_of_payments
    from {{ ref('stg_payments') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    coalesce(p.amount_inr, 0)           as amount_inr,
    coalesce(p.number_of_payments, 0)   as number_of_payments
from orders o
left join payments p on p.order_id = o.order_id
