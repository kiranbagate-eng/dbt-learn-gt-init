select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    amount/100 as amount,
    status,
    created as created_at
from raw.stripe.payment