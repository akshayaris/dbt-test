-- Custom business rule written in plain SQL:
-- an order can never have a negative amount. Any rows returned = test fails.
select order_id, amount_inr
from {{ ref('fct_orders') }}
where amount_inr < 0
