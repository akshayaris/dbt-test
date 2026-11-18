-- One row per customer with their order history and lifetime value.
-- Re-uses fct_orders instead of re-writing the payment logic a second time.
with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
    where status <> 'returned'
)

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.signup_date,
    min(o.order_date)                 as first_order_date,
    max(o.order_date)                 as most_recent_order_date,
    count(o.order_id)                 as number_of_orders,
    coalesce(sum(o.amount_inr), 0)    as lifetime_value_inr
from customers c
left join orders o on o.customer_id = c.customer_id
group by 1, 2, 3, 4, 5
